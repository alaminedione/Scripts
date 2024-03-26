#!/bin/bash

# Définition des variables
LOG_FILE="download.log"
VIDEO_FILE="listvideo.txt"
ECHEC_FILE="echoue.txt"
TERMINE_FILE="termine.txt"
DOSSIER_VIDEOS="videos_telechargees"

# Vérification de l'existence du fichier listvideo.txt
if [ ! -f "$VIDEO_FILE" ]; then
    echo "Erreur : Le fichier listvideo.txt est introuvable."
    exit 1
fi

# Fonction pour enregistrer les logs
log() {
    echo -e "$(date) - $1" >> "$LOG_FILE"
}

# Création des fichiers echoue et termine s'ils n'existent pas
touch "$ECHEC_FILE"
touch "$TERMINE_FILE"

log "Début du téléchargement des vidéos."

# Création du dossier pour les vidéos téléchargées
mkdir -p "$DOSSIER_VIDEOS"

# Lecture de chaque lien vidéo depuis le fichier
while IFS= read -r video_link || [ -n "$video_link" ]; do
    if [ -z "$video_link" ]; then
        continue
    fi

    log "Début du téléchargement de la vidéo : $video_link"

    echo "Vidéo en cours de téléchargement"
    # Téléchargement de la vidéo avec yt-dlp et déplacement dans le dossier videos_telechargees
    yt-dlp -o "$DOSSIER_VIDEOS/%(title)s.%(ext)s" "$video_link"

    if [ $? -eq 0 ]; then
        log "Téléchargement réussi pour la vidéo : $video_link \n"
        echo "Téléchargement réussi pour la vidéo : $video_link"
        echo "$video_link" >> "$TERMINE_FILE"
    else
        log "Erreur : Échec du téléchargement pour la vidéo : $video_link \n"
        echo "Échec du téléchargement pour la vidéo : $video_link"
        echo "$video_link" >> "$ECHEC_FILE"
    fi

done < "$VIDEO_FILE"

log "Execution du script terminé"
echo "Execution du script terminé"

# supprimer la liste de liens des videos sur la fichier listvideo.txt
echo "" > "$VIDEO_FILE"

echo "Veuillez consulter le fichier $LOG_FILE pour plus de détails."

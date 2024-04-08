#!/bin/bash

# activer l'utilisation des scripts 
shopt -s expand_aliases

# Définition des variables
LOG_FILE="download.log"
VIDEO_FILE="listvideo.txt"
ECHEC_FILE="echoue.txt"
TERMINE_FILE="termine.txt"
DOSSIER_VIDEOS="videos_telechargees"

#[yt-dlp]
# Options pour la meilleure qualité vidéo MP4
yt_dlp_qualite="-f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]'"
yt_dlp_subs="--write-sub --sub-lang en,fr"
yt_dlp_auto_subs="--write-auto-sub --sub-lang en,fr"
yt_dlp_downloader="--downloader aria2c --downloader-args '-c -j 3 -x 3 -s 3 -k 1M'"
yt_dlp_audio="-x -f 'bestaudio[ext=m4a]'"

alias yt_dlp_q="yt-dlp ${yt_dlp_qualite} ${yt_dlp_downloader}"
alias yt_dlp_q_s="yt-dlp ${yt_dlp_qualite} ${yt_dlp_downloader} ${yt_dlp_subs}"
alias yt_dlp_q_as="yt-dlp ${yt_dlp_qualite} ${yt_dlp_downloader} ${yt_dlp_auto_subs}"
alias yt_dlp_x="yt-dlp ${yt_dlp_downloader} ${yt_dlp_audio}"
alias yt_dlp_test="yt-dlp ${yt_dlp_qualite}"

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

 echo -e " \n
            --------------------------------------------------------------
             -- scripte execute à :  -- $(date)' -- 
            --------------------------------------------------------------
         "  >> "$LOG_FILE"


log "  ----- Début du téléchargement des vidéos.  ----- \n "

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
    yt_dlp_q -o "$DOSSIER_VIDEOS/%(title)s.%(ext)s" "$video_link"

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

log "Execution du script terminé   ---------------------------------------------------------------------------------------------"
echo "Execution du script terminé"

cp $ECHEC_FILE  $VIDEO_FILE  # option -n = no-clobber i.e. without overiting

echo "" > "$ECHEC_FILE"

echo "Veuillez consulter le fichier $LOG_FILE pour plus de détails."

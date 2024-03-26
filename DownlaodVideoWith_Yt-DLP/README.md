# Script de Téléchargement de Vidéos

Ce script Bash permet de télécharger des vidéos à partir de liens fournis dans un fichier texte en utilisant yt-dlp, tout en gérant les vidéos téléchargées, les échecs de téléchargement et en déplaçant les vidéos dans un dossier spécifique.

## Instructions d'utilisation

1. Assurez-vous d'avoir installé yt-dlp sur votre système.
2. Créez un fichier texte nommé `listvideo.txt` et placez les liens des vidéos que vous souhaitez télécharger, un lien par ligne.
3. Exécutez le script `download_videos.sh` en utilisant la commande suivante :
   ```bash
   ./download_videos.sh
   ```
4. Le script téléchargera les vidéos, les déplacera dans un dossier `videos_telechargees`, et enregistrera les détails dans les fichiers `download.log`, `echoue.txt`, et `termine.txt`.
5. Les liens seront supprimées du fichier `listvideo.txt` à la fin de l'exécution du script.

## Structure des Fichiers

- `download_videos.sh` : Le script principal pour télécharger les vidéos.
- `listvideo.txt` : Fichier contenant les liens des vidéos à télécharger.
- `download.log` : Fichier de logs pour enregistrer les détails des opérations.
- `echoue.txt` : Fichier contenant les liens des vidéos en échec de téléchargement.
- `termine.txt` : Fichier contenant les liens des vidéos téléchargées avec succès.
- `videos_telechargees` : Dossier où les vidéos téléchargées sont déplacées.

## Personnalisation

- Vous pouvez personnaliser le script en ajoutant des fonctionnalités supplémentaires ou en ajustant les paramètres selon vos besoins.
- Assurez-vous de tester le script avec différents scénarios pour garantir son bon fonctionnement.

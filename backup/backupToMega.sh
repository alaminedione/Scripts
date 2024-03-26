#!/bin/bash

# Dossiers à sauvegarder
folders=("Documents" "Scripts" "Backup" "Dotfiles" "myZsh" "git" "Documentation")

# Répertoire de destination
destination="$HOME/MEGA"

# Boucle pour copier chaque dossier
for folder in "${folders[@]}"
do
    rsync -arv --delete --progress ~/"$folder" "$destination"
done
#sauvegarder le fichier .zshrc dans votre dossier ~/MEGA
rsync -arv --progress ~/.zshrc $HOME/MEGA

# soon !!
# suvegarder appflowy
# suvegarder Anytype

echo "Sauvegarde terminée."

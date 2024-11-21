#!/bin/bash
# cp this file to /etc/profile.d/
# and do this:
# sudo visudo
# add do this (remplace alamine to your username):
# alamine ALL=(ALL) NOPASSWD: /etc/profile.d/run_at_start.sh

#ajouter une touche de composition alt droite pour pouvoir ecrire des lettres accentues
setxkbmap -option compose:ralt

# fix signature from levon (archcraft)
sudo pacman-key --recv-keys F9A6E68A711354D84A9B91637533BAFE69A25079 && sudo pacman-key --lsign-key F9A6E68A711354D84A9B91637533BAFE69A25079

#kvantum theme
current_hour=$(date +'%H')
if [ "$current_hour" -ge 6 ] && [ "$current_hour" -lt 18 ]; then
    config_content="[General]
theme=WhiteSur-opaque"
else
    config_content="[General]
theme=WhiteSur-opaqueDark"
fi
config_file="$HOME/.config/Kvantum/kvantum.kvconfig"
echo "$config_content" > "$config_file"
echo "Le fichier $config_file a été généré avec succès."

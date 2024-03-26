# sauvegarder NvChad
## copier le dossier *config* NvChad
rsync -arv --delete $HOME/.config/NvChad $HOME/Dotfiles/nvim/NvChad/Config
## copier le dossier *share*
rsync -arv --delete $HOME/.local/share/NvChad $HOME/Dotfiles/nvim/NvChad/Share

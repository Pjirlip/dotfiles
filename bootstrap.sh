#!/bin/bash

# Git pull changes
cd ~/.dotfiles >> /dev/null && git pull origin master && cd - >> /dev/null

# Rsync content of .dotfiles dir
rsync -avh --no-perms \
        --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".gitignore" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE.txt" \
		~/.dotfiles/ ~/;

# Set symlink to tmux.conf
ln -sfn ~/.config/tmux/tmux.conf ~/.tmux.conf;

# Install/Upade NVim Plugs
if ! type -P nvim; then
    vim +PlugUpdate +qall > /dev/null
fi

# Install TMUX Plugin Manger if missing
if [ ! -e "$HOME/.config/tmux/plugins/tpm" ]; then
    printf "WARNING: Cannot find TPM (Tmux Plugin Manager) at default location: \$HOME/.tmux/plugins/tpm.\n Downloading now"
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
fi

# Update/Install TMUX Plugins 
source ~/.config/bash/.functions
update_tmux_plugins



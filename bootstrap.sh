cd ~/.dotfiles

# Check for changes
git pull origin master

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

# Source immediately if currently in bash shell
[[ -z "$BASH" ]] && echo "Current Shell is no Bash Shell" || source ~/.bashrc;

if ! type -P nvim; then
    vim +PlugUpdate +qall > /dev/null
fi

if [ ! -e "$HOME/.tmux/plugins/tpm" ]; then
    printf "WARNING: Cannot found TPM (Tmux Plugin Manager) t default location: \$HOME/.tmux/plugins/tpm.\n Dwonloading now"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

update_tmux_plugins

# Go Back to last Dir
cd -



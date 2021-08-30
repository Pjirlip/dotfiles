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

# Go Back to last Dir
cd -



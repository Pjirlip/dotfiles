####################################### INITAL SETUP ##############################################4
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
# but only if not SUDOing and have SUDO_PS1 set; then assume smart user.
if ! [ -n "${SUDO_USER}" -a -n "${SUDO_PS1}" ]; then
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
        function command_not_found_handle {
                # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
                   /usr/lib/command-not-found -- "$1"
                   return $?
                elif [ -x /usr/share/command-not-found/command-not-found ]; then
                   /usr/share/command-not-found/command-not-found -- "$1"
                   return $?
                elif [ -x /usr/bin/command-not-found ]; then
                   /usr/bin/command-not-found -- "$1"
                   return $?
                else
                   printf "%s: command not found\n" "$1" >&2
                   return 127
                fi
        }
fi

###################### SHOPT Settings       #########################################

### Universal Shopts ### {{{
shopt -s cmdhist;                       # Save multi-line hist as one line
shopt -s histappend;                    # Append to the Bash history file, rather than overwriting it
shopt -s checkwinsize;                  # Update col/lines after commands
shopt -sq autocd;                       # Can change dir without `cd`
shopt -s cdspell;                       # Fixes minor spelling errors in cd paths
shopt -s no_empty_cmd_completion;       # Stops empty line tab comp
shopt -sq dirspell;                     # Tab comp can fix dir name typos
shopt -s nocaseglob;                    # Case-insensitive globbing (used in pathname expansion)

###################### LOAD ALIASES etc.    #########################################

# Load the shell dotfiles, and then some:
# * ~/config/bash/.path can be used to extend `$PATH`.
# * ~/config/bash/.extra can be used for other settings you don’t want to commit.
for file in ~/.config/bash/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

###################### FINISH #########################################


# Autoload TMUX Env (and Restore if connection drop)
if [ -z "$TMUX" ] && $(command -v tmux >/dev/null 2>&1) && [ -n "$SSH_TTY" ] && [ -z "$NO_AUTO_TMUX" ] && [[ $- =~ i ]]; then
    tmux attach-session -t $USER || tmux new-session -s $USER
    exit                                                                                                        
elif command -v starship >/dev/null 2>&1; then
    bash_version_major="${BASH_VERSINFO[0]}"
    bash_version_minor="${BASH_VERSINFO[1]}"
    starship_path=$(which starship | head -n 1 | cut -d " " -f 1)

    if (($bash_version_major > 4)) || { (($bash_version_major == 4)) && (($bash_version_minor >= 1)); }; then
        source <($starship_path init bash --print-full-init)
    else
        source /dev/stdin <<<"$($starship_path init bash --print-full-init)"
    fi
fi

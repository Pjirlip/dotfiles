if status is-interactive
    # Commands to run in interactive sessions can go here
end

status --is-interactive; and source (anyenv init -|psub)

source ~/.config/fish/.fish_variables
source ~/.config/fish/.fish_aliases
source ~/.config/fish/.fish_functions

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

set -x EDITOR nvim
set -x VISUAL nvim
set -x ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX YES

set -x NNN_TERMINAL iterm
set -x NNN_PLUG "p:preview-tui;o:fzopen;f:finder"
set -x NNN_FIFO /tmp/nnn.fifo
set -x NNN_OPENER "$HOME/.config/nnn/plugins/nuke"

set fish_greeting

set -x PYENV_ROOT $(brew --prefix openssh)/bin/pyenv
set -x PATH $(pyenv root)/shims:$PATH
set -x PATH $(brew --prefix openssh)/bin:$PATH

set -x GPG_TTY $(tty)
set -x SSH_AUTH_SOCK {$HOME}/.gnupg/S.gpg-agent.ssh

starship init fish | source


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#if test -f /opt/homebrew/anaconda3/bin/conda
#    eval /opt/homebrew/anaconda3/bin/conda "shell.fish" "hook" $argv | source
#end
# <<< conda initialize <<<


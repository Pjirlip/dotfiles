if status is-interactive
    # Commands to run in interactive sessions can go here
end

status --is-interactive; and source (anyenv init -|psub)

source ~/.config/fish/.fish_variables
source ~/.config/fish/.fish_aliases
source ~/.config/fish/.fish_functions

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

set EDITOR nvim
set ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX YES
set fish_greeting

set PYENV_ROOT $(brew --prefix openssh)/bin/pyenv
set PATH $(pyenv root)/shims:$PATH
set PATH $(brew --prefix openssh)/bin:$PATH

set GPG_TTY $(tty)
set SSH_AUTH_SOCK {$HOME}/.gnupg/S.gpg-agent.ssh

starship init fish | source


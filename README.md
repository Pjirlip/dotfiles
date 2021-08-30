# Dotfiles

My personal dotfiles (configuration files). You can also use them if you want.

## Installation

```bash
$ git clone --bare https://github.com/Pjirlip/dotfiles.git ~/.dotfiles
$ chmod +x ~/.dotfiles/bootsrap.sh
$ ~/.dotfiles/bootstrap.sh

```

That's it bootstrap.sh will do the rest. 

! Important !
bootstrap.sh will override existing dotfiles without asking! 
So please backup your dotfiles before running bootstrap.sh


## Update

After .dotfiles repo is "installed" you can either run build-in bash function "update_dotfiles" or run ~/.dotfiles/bootstrap.sh again

## Overview

This dotfiles has configurations for:
- simple vim config (fallback if neovim isn't installed) 
- nvim (with plugins and all) 
- bash setup (incl. functions, aliases, exports)
- wget config
- inputrc config (for history search etc.)
- tmux config (basically just https://github.com/samoshkin/tmux-config)

## Additonal bash config
For additional settings to the .bashrc, a file named ".extra" can be created in the ~/.config/bash/ folder. This file is sourced in the .bashrc and not part of the Git repository, so it will not be overwritten during updates.

```bash
# ~/config/bash/.extra

THIS_WILL_NOT_BE_OVERRIDEN=true

alias somepersonalalias="echo 'hello world'"

...
```

## Auto-TMUX

Since the configuration is mainly used on DEBIAN/UBUNTU servers, there is a feature in .bashrc which automatically starts a TMUX session (and attaches to a lost session) so that no running commands are interrupted in case of an ssh disconnect.

If this behavior is undesirable (e.g.: on a local machine), then simply set the environment variable "NO_AUTO_TMUX" with an arbitrary value to disable the feature. This can be done as explained in the previous point via the file `~/config/bash/.extra`.


```bash
# ~/config/bash/.extra

NO_AUTO_TMUX=1


```

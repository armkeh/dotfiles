bindkey -e

# Fixes an issue with the starship prompt offset being incorrect due to unicode characters
export LC_ALL=C.UTF-8

HISTFILE=~/.zsh-histfile
HISTSIZE=100000000
SAVEHIST=100000000

unsetopt list_beep

zstyle :compinstall filename '/home/markparmstrong/.zshrc'

autoload -Uz compinit
compinit

# Source my alias definitions.
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

# Source my alias definitions.
if [ -f ~/.aliases_local ]; then
  . ~/.aliases_local
fi

if [ -x $(which starship) ]; then
  eval "$(starship init zsh)"
fi

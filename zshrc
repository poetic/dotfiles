# Set VIM as the default editor
export EDITOR="vim"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.poetic_dotfiles/oh-my-zsh

# Path to poetid dotfiles
POETIC_DOTFILES=$HOME/.poetic_dotfiles

ZSH_THEME="jake"

DISABLE_AUTO_UPDATE="true"

DISABLE_AUTO_TITLE="true"
plugins=(git bundler rails ruby brew bower rbenv rails4 vim gem zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# tmuxinator completions
source $POETIC_DOTFILES/tmuxinator.zsh

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Default to standard vi bindings, regardless of editor stringj
# / to do backward search
bindkey -v
bindkey "jj" vi-cmd-mode
bindkey -M vicmd '/' history-incremental-search-backward

# Boxen
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

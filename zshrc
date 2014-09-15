# Set Vim as the default editor
export EDITOR="vim"

# Make sure SHELL is set properly
export SHELL="/bin/zsh"

# Boxen
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.poetic_dotfiles/oh-my-zsh
ZSH_CUSTOM=$HOME/.poetic_dotfiles/zsh_custom

# Path to poetid dotfiles
POETIC_DOTFILES=$HOME/.poetic_dotfiles

ZSH_THEME="poetic"

DISABLE_AUTO_TITLE="true"

plugins=(git git-flow osx rails brew bower bundle gem vim gem meteor npm tmux tmuxinator autojump zsh-syntax-highlighting last-working-dir jsontools)

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

path+=($NODENV_ROOT)
eval "$(nodenv init -)"

# aliases
[[ -f ~/.poetic_dotfiles/aliases ]] && source ~/.poetic_dotfiles/aliases

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

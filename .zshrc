export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="simple"

plugins=(git colored-man-pages colorize pip python brew macos zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete zoxide asdf)

source $ZSH/oh-my-zsh.sh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export EDITOR="vim"

[[ -s ~/.zsh_aliases ]] && source ~/.zsh_aliases
[[ -s ~/.nubank_config ]] && source ~/.nubank_config
[[ -s ~/.lab_config ]] && source ~/.lab_config

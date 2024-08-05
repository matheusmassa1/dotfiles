# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="simple" # set by `omz`

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colored-man-pages colorize pip python brew macos zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete zoxide)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Load aliases
[[ -s ~/.zsh_aliases ]] && source ~/.zsh_aliases

# <-- BEGIN SECTION ADDED BY NUDEV -->

# To handle non-ASCII characters
# ==============================
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8


# Programs
# ========

# Default editor
# --------------
export EDITOR="subl -w -n"

# Homebrew
# --------
if command -v brew >/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  export PATH="${HOMEBREW_PREFIX}/sbin:${PATH}"
elif [[ -f "/opt/homebrew/bin/brew" && $(/usr/bin/uname -sm) == "Darwin arm64" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH="${HOMEBREW_PREFIX}/sbin:${PATH}"
fi

# SDKMAN
# ------
if [[ -f "$HOME/.sdkman/bin/sdkman-init.sh" && $(/usr/bin/uname -sm) == "Darwin arm64" ]]; then
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

# jEnv
# ----
if command -v jenv >/dev/null; then
  export PATH="${HOME}/.jenv/bin:${PATH}"
  eval "$(jenv init -)"
fi

# node
# ----
# https://nodejs.org/api/modules.html
if command -v node >/dev/null && [[ -n "$HOMEBREW_PREFIX" ]]; then
  export NODE_PATH="${HOMEBREW_PREFIX}/lib/node_modules"
fi

# Nu
# --
export NU_HOME="/Users/matheus.massa/dev/nu"
export NUCLI_HOME="${NU_HOME}/nucli"
export PATH="${NUCLI_HOME}:${PATH}"
export NU_COUNTRY="br"
alias dev='cd ${NU_HOME}'
export GITHUB_TOKEN="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"
export SLACK_MEMBER_ID="U02SXE3E90R"



# Autocomplete
# ============

# https://docs.brew.sh/Shell-Completion
if command -v brew >/dev/null && [[ $(ps -p "$$" -o comm=) == *bash ]]; then

  # https://formulae.brew.sh/formula/bash-completion@2
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    . "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" || :
  fi

fi

# nucli
if [[ -r "${NUCLI_HOME}/nu.bashcompletion" ]]; then
  . "${NUCLI_HOME}/nu.bashcompletion" || :
fi

# <-- END SECTION ADDED BY NUDEV -->

# Added by Toolbox App
# export PATH="$PATH:/Users/matheus.massa/Library/Application Support/JetBrains/Toolbox/scripts"

. "$HOME/.asdf/asdf.sh"

# export PATH="/opt/homebrew/bin:/Users/matheus.massa/.asdf/shims:/Users/matheus.massa/.asdf/bin:/Users/matheus.massa/dev/nu/nucli:/Users/matheus.massa/.jenv/shims:/Users/matheus.massa/.jenv/bin:/opt/homebrew/sbin:/Users/matheus.massa/dev/nu/nucli:/Users/matheus.massa/.jenv/shims:/Users/matheus.massa/.jenv/bin:/opt/homebrew/sbin:/Users/matheus.massa/dev/nu/nucli:/Users/matheus.massa/.jenv/shims:/Users/matheus.massa/.jenv/bin:/opt/homebrew/sbin:/Users/matheus.massa/dev/nu/nucli:/Users/matheus.massa/.jenv/shims:/Users/matheus.massa/.jenv/bin:/opt/homebrew/sbin:/Users/matheus.massa/miniforge3/bin:/Users/matheus.massa/miniforge3/condabin:/Users/matheus.massa/dev/nu/nucli:/Users/matheus.massa/.jenv/shims:/Users/matheus.massa/.jenv/bin:/opt/homebrew/sbin:/Users/matheus.massa/dev/nu/nucli:/Users/matheus.massa/.jenv/shims:/Users/matheus.massa/.jenv/bin:/opt/homebrew/sbin:/Users/matheus.massa/dev/nu/nucli:/Users/matheus.massa/.jenv/shims:/Users/matheus.massa/.jenv/bin:/opt/homebrew/sbin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/MacGPG2/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Users/matheus.massa/Library/Application Support/JetBrains/Toolbox/scripts:/Users/matheus.massa/Library/Application Support/JetBrains/Toolbox/scripts:/Users/matheus.massa/Library/Application Support/JetBrains/Toolbox/scripts:/Users/matheus.massa/Library/Application Support/JetBrains/Toolbox/scripts:/Users/matheus.massa/Library/Application Support/JetBrains/Toolbox/scripts:/Users/matheus.massa/Library/Application Support/Coursier/bin"
export PATH="$HOME/.emacs.d/bin:/opt/homebrew/bin:/Users/matheus.massa/.asdf/shims:/Users/matheus.massa/.asdf/bin:/Users/matheus.massa/dev/nu/nucli:/Users/matheus.massa/.jenv/shims:/Users/matheus.massa/.jenv/bin:/opt/homebrew/sbin:/opt/homebrew/sbin:/Users/matheus.massa/miniforge3/bin:/Users/matheus.massa/miniforge3/condabin:/opt/homebrew/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/MacGPG2/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Users/matheus.massa/Library/Application Support/JetBrains/Toolbox/scripts:/Users/matheus.massa/Library/Application Support/Coursier/bin"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/matheus.massa/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/matheus.massa/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/matheus.massa/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/matheus.massa/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# << zoxide
# eval "$(zoxide init zsh)"

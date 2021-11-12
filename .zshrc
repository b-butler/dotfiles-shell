# Configuration files location
export SHELL_CONFIG="${HOME}/.shell"

if [[ -e "~/.shell/local" ]]; then
    export IS_LOCAL="local"
fi

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="bira"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# comment the following line to not display red dots whilst waiting for
# completion.
COMPLETION_WAITING_DOTS="true"

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
plugins=(git keychain)

define-keychain-config () {
    zstyle :omz:plugins:keychain agents ssh
    zstyle :omz:plugins:keychain options --quiet

    local identities=""
    for id_file in id_ed25519 id_github; do
        if [[ -e "${HOME}/.ssh/${id_file}" ]]; then
            identities="${identities+ ${identities}}${id_file}"
        fi
    done
    if [[ -n "${identities+1}" ]]; then
        zstyle :omz:plugins:keychain "$identities"
    fi
}

define-keychain-config

. $ZSH/oh-my-zsh.sh

# User configuration
# Enable tmux titling
export DISABLE_AUTO_TITLE='true'

export PATH=$PATH:$HOME/.local/bin

# Preferred editor for local and remote sessions
if [[ -x "$(command -v nvim)" ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

# set options
export KEYTIMEOUT=10
set -o auto_cd # $ directory is equivalent to $ cd directory
set -o append_history # append history from zsh shells after exiting
set -o auto_continue # automatically continue jobs disowned
set -o PROMPT_SUBST
# unset -o correct

bindkey -v # vim like bindings

# Set up fzf
[[ -f ~/.fzf.zsh ]] && . ~/.fzf.zsh

# conda setup
# source functions to use
. "${SHELL_CONFIG}/conda.sh"

find-conda-path
init-conda 'zsh'


. "${SHELL_CONFIG}/functions.sh"
. "${SHELL_CONFIG}/aliases.sh"

# Set up personal theme
. "${SHELL_CONFIG}/zsh-theme"

# Any private configurations
. "${SHELL_CONFIG}/private-config.sh"

source-private-script

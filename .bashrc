# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# Configuration files location
export SHELL_CONFIG="${HOME}/.shell"

if [[ -e "~/.shell/local" ]]; then
	export IS_LOCAL="local"
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
time_color='\[\033[0;34m\]'
host_color='\[\033[0;32m\]'
dir_color='\[\033[0;34m\]'
command_color='\[\033[0;37m\]'
if [ "$color_prompt" = yes ]; then
	PS1="${time_color}[\t]${host_color}[\h]"
	PS1+="${dir_color}\W${command_color}\$ "
else
    PS1='[\t][\h]\W\$ '
fi
unset color_prompt force_color_prompt

# # If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# set vi like binding must be set before fzf
set -o vi

export PATH="${PATH}:${HOME}/.local/bin"

# set fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

. "${SHELL_CONFIG}/functions.sh"
. "${SHELL_CONFIG}/aliases.sh"


# conda setup
# source functions to use
. "${SHELL_CONFIG}/conda.sh"

find-conda-path
init-conda 'bash'

# private configuration
. "${SHELL_CONFIG}/private-config.sh"

source-private-script

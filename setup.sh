#!/usr/bin/env bash

# Arguments:
#     $1 original file, expects file to be relative to current directory.
#         Do not include ./ in name. This will work but then the symlink will
#         include the ./.
#     $2 new file to link
# Does nothing when $2 exists and is $1. Always symlinks since git will break
# hardlinks.
function symlink-with-warning {
if [[ ! -e "$1" ]]; then
    echo "${1} does not exist to link to."
    return 1
elif [[ -e "$2"  &&  ! "$2" -ef "$1" ]]; then
    echo "${2} exists and is not ${1}. Cannot safely symlink"
    return 1
elif [[ ! -e "$2" ]]; then
    ln -s "$(pwd)/${1}" "$2"
fi
}

symlink-with-warning .zshrc "${HOME}/.zshrc"
symlink-with-warning .bashrc "${HOME}/.bashrc"
symlink-with-warning shell "${HOME}/.shell"

# Set aliases

# A ternary alias like command.
# Creates an alias to the first command if it exists in $PATH and the second
# otherwise.
# $1: alias
# $2: preferred alias command
# $3: failback alias command
# $4: optional options to pass to either command
prefered_alias () {
    if [ -x "$(command -v "$2")" ]; then
        alias "$1"="$2${4:+ ${4}}"
        return
    fi
    alias "$1"="${3}${4:+ ${4}}"
}

# Create an alias only if the executable exists
# $1: alias
# $2: alias command
alias_if_exists () {
    if [ -x "$(command -v "$2")" ]; then
        alias "$1"="$2"
        return
    fi
}

# Neovim and Vim
prefered_alias v nvim vim

# Jupyter Notebook Aliases
alias_if_exists jupyter "${CONDA_PATH}/envs/jupyter/bin/jupyter"

# ls Aliases
prefered_alias l exa ls '-F --color=auto'
prefered_alias ll exa ls -alF
prefered_alias la exa ls -A
prefered_alias lh exa ls -lhA
prefered_alias lha exa ls -lhA

# Setup prefered shell alternatives if present
prefered_alias du dust du
prefered_alias df duf df

# grep Aliases
prefered_alias grep rg grep '--color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# fzf Aliases
alias edo="editor_fuzzy_open"

# cd Aliases
alias cdf="cd **"

# rm Aliases
# remove LaTeX intermediate files
alias rmTex="rm *.{aux,log,synctex.gz,fdb_latexmk,run.xml,toc,bbl,bcf,blg,fls}"

# Simulation work aliases
prefered_alias serror rg grep '\"ERROR\" *.o*'

# git
alias gstai="git stash push --include-untracked"
alias grsp="git restore --patch"
alias grssp="git restore --staged --patch"
alias grss="git restore --staged"

# Python modules
alias signac="python3 -m signac"
alias flow="python3 -m flow"
alias pytest="python3 -m pytest"

# OVITO
alias_if_exists ovito "${HOME}/code/ovito/bin/ovito"
alias_if_exists ovitos "${HOME}/code/ovito/bin/ovitos"

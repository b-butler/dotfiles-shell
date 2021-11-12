# Set functions

mcd(){
    mkdir $1 && cd $1
}

latref(){
    if [ $# -eq 1 ]
    then
        pdflatex $1
        biber $1
        pdflatex $1
    fi
}

rm_tex() {
    local file="$1"
    shift &> /dev/null || echo "Must pass a filename base." >&2 && return 1
    __good_endings=(tex pdf)
    if [[ $# > 0 ]]; then
        __good_endings=("${good_endings[@]}" "$@")
    fi
    for fp in "${file}*"; do
        for end in "__good_endings[@]}"; do
            if [[ "${fp##*.}" == "$end" ]]; then
                rm "$fp"
                break
            fi
        done
    done
    unset __good_endings
}

jlab_server() {
	jupyter lab --no-browser --port=$1
}

open_port() {
	ssh -Nfl localhost:$1:localhost$1 $2
}

if [[ -n "${IS_LOCAL+1}" ]]; then
    sphinx() {
        (. "${HOME}/envs/docs/bin/activate" && python3 -m sphinx "$@")
    }
fi

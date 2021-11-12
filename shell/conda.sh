
find-conda-path () {
    __folder_names=(mambaforge miniforge anaconda)
    for directory in "${__folder_names[@]}"; do
        local local_path="${HOME}/${directory}"
        if [[ -d "$local_path" ]]; then
            export CONDA_PATH="$local_path"
            break
        fi
    done
    unset __folder_names
}

init-conda () {
    if [[ ! -n "${CONDA_PATH+1}" ]]; then
        return 0
    fi
        local setup="$("${CONDA_PATH}/bin/conda" "shell.${1}" 'hook' 2> /dev/null)"
        if [ $? -eq 0 ]; then
            eval "$setup"
        else
            if [ -f "${CONDA_PATH}/etc/profile.d/conda.sh" ]; then
                . "${CONDA_PATH}/etc/profile.d/conda.sh"
            else
                export PATH="${CONDA_PATH}/bin:$PATH"
            fi
        fi
}

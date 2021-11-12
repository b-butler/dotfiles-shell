# Source a private configuation file defaulting to SHELL_CONFIG/private.sh.
# $1: the filename optional
# exits with an error if a filename is passed and file does not exist
source_private_script () {
	local filename="${SHELL_CONFIG}/${1:-private.sh}"
	local file_provided="${1+1}"
	if [[ ! -e "$filename" ]]; then
            if [[ -n "$file_provided" ]]; then
                echo "Could not find private configuration ${filename}" 1>&2
                return 1
            fi
            return 0
	fi
	. "$filename"
}

source-private-script () {
	local filename="${SHELL_CONFIG}/${1:-private.sh}"
	local file_provided="${1+1}"
	if [[ ! -e "$filename" ]]; then
		if [[ -n "$file_provided" ]]; then
			echo "Could not find private configuration ${filename}"
			return 1
		fi
		return 0
	fi
	. "$filename"
}

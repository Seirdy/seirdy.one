#!/bin/sh
# takes an arg for the output dir.
# Runs xhtmlize-single-file.sh on every single html file in the output dir.
# exits if xhtmlize-single-file fails.

set -e -u

output_dir="$1"
script_dir="$(dirname "$0")"

printf '<style>%s</style>\n' "$(htmlq -t style <"$output_dir/index.html")" >"$output_dir/tmp.css"
cleanup() {
	rm -f "$output_dir/tmp.css"
}
trap cleanup EXIT

export XMLLINT_INDENT='	'
export OUTPUT_DIR="$output_dir"
find "$output_dir" -type f -name '*.html' | xargs -n1 sh "$script_dir/xhtmlize-single-file.sh"
# done

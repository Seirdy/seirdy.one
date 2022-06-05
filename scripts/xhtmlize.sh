#!/bin/sh
# takes an arg for the output dir.
# Runs xhtmlize-single-file.sh on every single html file in the output dir.

set -e -u

output_dir="$1"
script_dir="$(dirname "$0")"

printf '\t<style>%s</style>\n' "$(htmlq -t style <"$output_dir/index.html")" >tmp.css
cleanup() {
	rm -f "tmp.css"
}
trap cleanup EXIT

export XMLLINT_INDENT='	'
find "$output_dir" -type f -name '*.html' \
	-exec sh "$script_dir/xhtmlize-single-file.sh" {} \;
# done

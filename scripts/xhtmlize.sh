#!/bin/sh
# takes an arg for the output dir.
# Runs xhtmlize-single-file.sh on every single html file in the output dir.
# exits if xhtmlize-single-file fails.

# no pipefail here since there are no pipes.
set -e -u

output_dir="$1"
script_dir="$(dirname "$0")"

{
	printf '\t' && sed -e '7q;d' "$output_dir/index.html"
} >"$output_dir/tmp.css"
cleanup() {
	rm -f "$output_dir/tmp.css"
}
trap cleanup EXIT

export XMLLINT_INDENT='	'
export OUTPUT_DIR="$output_dir"
find "$output_dir" -type f -name '*.html' -exec sh "$script_dir/xhtmlize-single-file.sh" {} \;
# done

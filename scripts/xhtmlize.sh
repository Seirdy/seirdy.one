#!/bin/sh
# takes an arg for the output dir.
# Runs xhtmlize-single-file.sh on every single html file in the output dir.
# exits if xhtmlize-single-file fails.

# no pipefail here since there are no pipes.
set -e -u

output_dir="$1"
script_dir="$(dirname "$0")"
temp_resume="$(mktemp)"

# I have an alias for a redirect. I also define the redirect in Nginx, but this is there for the envs.net/~seirdy mirror. Hugo aliases don't have trailing slashes; this will trip up xmllint.
sed -i -e 's|<html lang="en-us"|<html xmlns="http://www.w3.org/1999/xhtml" lang="en-us" xml:lang="en-us"|' -E -e 's#<((link|meta) .*)">#<\1" />#' "$output_dir/resume/index.html"
mv "$output_dir/resume/index.html" "$temp_resume"

{
	printf '\t' && sed -e '7q;d' "$output_dir/index.html"
} >"$output_dir/tmp.css"
cleanup() {
	rm -f "$output_dir/tmp.css"
	mv "$temp_resume"  "$output_dir/resume/index.html"
}
trap cleanup EXIT

export XMLLINT_INDENT='	'
export OUTPUT_DIR="$output_dir"
find "$output_dir" -type f -name '*.html' -exec sh "$script_dir/xhtmlize-single-file.sh" {} \;
find "$output_dir" -type f -name '*.xml' -exec xmllint --noblanks --encode UTF-8 --noent {} --output {} \;

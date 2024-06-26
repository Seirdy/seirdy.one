#!/bin/sh
# takes an arg for the output dir.
# Runs xhtmlize-single-file.sh on every single html file in the output dir.
# exits if xhtmlize-single-file fails.

#shellcheck disable=SC3040  # This only sets pipefail if it's available and otherwise does nothing
set -o pipefail 2>/dev/null || true
set -e -u

output_dir="$1"
script_dir="$(dirname "$0")"
temp_resume="$(mktemp)"

# I have an alias for a redirect. I also define the redirect in Nginx, but this is there for the envs.net/~seirdy mirror. Hugo aliases don't have trailing slashes; this will trip up xmllint.
sed -i -e 's|<html lang="en-us"|<html xmlns="http://www.w3.org/1999/xhtml" lang="en-us" xml:lang="en-us"|' -E -e 's#<((link|meta) .*)">#<\1" />#' "$output_dir/resume/index.html"
mv "$output_dir/resume/index.html" "$temp_resume"
# {{ $css.Content | safeCSS }}/*]]>*/-->
{
	sed -e '7q;d' "$output_dir/index.html" \
		| sed -e 's|<style>|<style><\!--/\*--><\!\[CDATA\[/\*><\!--\*/|' -e 's|</style>|/\*\]\]>\*/--></style>|'
} >"$output_dir/tmp.xhtml"
cleanup() {
	rm "$output_dir/tmp.xhtml"
	mv "$temp_resume" "$output_dir/resume/index.html"
}
trap cleanup EXIT

export XMLLINT_INDENT='	'
export OUTPUT_DIR="$output_dir"
find "$output_dir" -type f -name '*.html' -print0 | xargs -0 -n1 sh "$script_dir/xhtmlize-single-file.sh"
find "$output_dir" -type f -name '*.xml' -print0 | xargs -0 -I_ xmllint --noblanks --encode UTF-8 --noent _ --output _

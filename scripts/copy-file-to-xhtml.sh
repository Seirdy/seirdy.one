#!/bin/sh
# Take a single polygot (X)HTML file and make a .xhtml copy of it. Do
# the same for static-compressed versions.

# no pipefail here since there are no pipes.
set -e -u

html_file="$1"
xhtml_file="${html_file%*.html}.xhtml"

cp -p "$html_file" "$xhtml_file"
if [ -f "$html_file.gz" ]; then
	cp -p "$html_file.gz" "$xhtml_file.gz"
fi
if [ -f "$html_file.br" ]; then
	cp -p "$html_file.br" "$xhtml_file.br"
fi

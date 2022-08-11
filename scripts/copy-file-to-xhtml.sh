#!/bin/sh
# Take a single polygot (X)HTML file and make a .xhtml copy of it. Do
# the same for static-compressed versions.

set -e -u

html_file="$1"
xhtml_file="${html_file%*.html}.xhtml"

cp -p "$html_file" "$xhtml_file"
[ -f "$html_file.gz" ] && cp -p "$html_file.gz" "$xhtml_file.gz"
[ -f "$html_file.br" ] && cp -p "$html_file.br" "$xhtml_file.br"

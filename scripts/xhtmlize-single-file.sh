#!/bin/sh
# copies an .html file to an equivalent .xhtml file, but replaces
# the meta charset with an XML declaration for compatibility with some
# XML tooling.
# Expects polygot XHTML(5) markup.
# Formats both the .html and .xhtml file.
# this means that every index.html file has an equivalent index.xhtml file.
# content negotiation allows an agent to pick html or xhtml.

# use xmllint to do the formatting.
# xmllint ruins inline CSS so delete the inline CSS and re-insert it.
# xmllint also adds extra whitespace around <pre><code> which we remove
# with "sd". I chose sd since it handles newlines well.
# It also decreases indents by one level

set -e -u

html_file="$1"
tmp_file="$html_file.tmp"
xhtml_file=${html_file%*.html}.xhtml

cleanup() {
	rm -f "$tmp_file"
}
trap cleanup EXIT

# delete the stylesheet from the html file; we'll re-insert it later.
# Also remove two indentation levels
sed 7d "$html_file" | xmllint --format --encode UTF-8 --noent - | tail -n +2 | sd '^\t(?:\t)?' '' >"$tmp_file"
{
	head -n7 "$tmp_file" | sd -s '/>' ' />'
	cat "$OUTPUT_DIR/tmp.css"
	# shellcheck disable=SC2016 # these are regex statements, not shell expressions
	tail -n +8 "$tmp_file" \
		| sd '<pre(?: tabindex="0")?>\n\t*<(code|samp)( |>)' '<pre tabindex="0"><$1$2' \
		| sd '(?:\n)?</(code|samp)>\n(?:[\t\s]*)?</pre>' '</$1></pre>' \
		| sd '</span>.span itemprop="familyName"' '</span> <span itemprop="familyName"' \
		| sd -f m 'class="u-photo photo"[^<]*<' 'class="u-photo photo"/> <' \
		| sd '([a-z])<(data|time)' '$1 <$2' \
		| sd '</span>(<a[^>]*rel="(?:nofollow ugc|ugc nofollow)"(?:[^>]*)?>liked</a>)' '</span> $1' \
		| sd -s '/>' ' />'
} >"$html_file"

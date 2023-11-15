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
# with sed.
# It also decreases indents by one level

set -e -u

html_file="$1"
tmp_file="$(mktemp)"
xhtml_file=${html_file%*.html}.xhtml

cleanup() {
	rm -f "$tmp_file"
}
trap cleanup EXIT

run_tidy () {
	tidy -asxhtml -config linter-configs/tidy.conf 2>/dev/null || true
}

# delete the stylesheet from the html file; we'll re-insert it later.
# Also remove two indentation levels
sed 7d "$html_file" | xmllint --format --encode UTF-8 --noent - | tail -n +2 | run_tidy >"$tmp_file"
{
	head -n7 "$tmp_file"
	cat "$OUTPUT_DIR/tmp.css"
	# shellcheck disable=SC2016 # these are regex statements, not shell expressions
	sed \
			-e '1,7d' \
			-e 's|\.svg" width="16" /><span|.svg" width="16" /> <span|' \
			-e 's|</span>(&nbsp;)?.span itemprop="familyName|</span>&#160;<span itemprop="familyName"|' \
			-E \
			-e 's|([a-z])<data|\1 <data|' \
			-e 's#</span>(<a[^>]*rel="(nofollow ugc|ugc nofollow)"([^>]*)?>liked</a>)#</span> \1#' \
			-e 's#<pre( tabindex="0")?>\n(\t|\s)*<(code|samp)( |>)#<pre tabindex="0"><\3\4#' \
			"$tmp_file"
} >"$html_file"

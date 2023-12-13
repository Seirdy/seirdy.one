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

#shellcheck disable=SC3040  # This only sets pipefail if it's available and otherwise does nothing
set -o pipefail 2>/dev/null || true
set -e -u

html_file="$1"
tmp_file="$(mktemp)"

cleanup() {
	rm -f "$tmp_file"
}
trap cleanup EXIT

# run_tidy() {
# 	tidy -asxhtml -config linter-configs/tidy.conf 2>/dev/null || true
# }

run_xmllint() {
	xmllint --format --encode UTF-8 --noent - || {
		echo "$html_file"
		exit 1
	}
}

# delete the stylesheet from the html file; we'll re-insert it later.
sed 7d "$html_file" | run_xmllint | tail -n +2 >"$tmp_file"
{
	head -n7 "$tmp_file" | sed -e 's/^\t//'
	cat "${OUTPUT_DIR:?}/tmp.css"
	# shellcheck disable=SC2016 # these are regex statements, not shell expressions
	#shellcheck source=/home/rkumar/Executables/ghq/git.sr.ht/~seirdy/seirdy.one/scripts/xhtmlize.sh
	sed \
		-e '1,7d' \
		-e 's/^\t//' \
		-e 's|</span><span itemprop="familyName"|</span>\&#160;<span itemprop="familyName"|' \
		-e 's|class="u-photo photo"[^<]*<|class="u-photo photo"/> <|' \
		-e 's|<pre>|<pre tabindex="0">|' \
		-E \
		-e 's|([a-z])<data|\1 <data|' \
		-e 's#</span>(<a[^>]*rel="(nofollow ugc|ugc nofollow)"([^>]*)?>liked</a>)#</span> \1#' \
		-e 's#^[\t\s]*<(code|/pre)#<\1#' \
		"$tmp_file" \
		| awk '/(^<\/code>|<pre tabindex="0">)/{printf "%s",$0;next}7'
} >"$html_file"

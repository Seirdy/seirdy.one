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

set -e -u

export html_file="$1"
export tmp_file="${html_file}.tmp"
export xhtml_file=${html_file%*.html}.xhtml

cleanup() {
	rm -f "$tmp_file"
}
trap cleanup EXIT

trap cleanup EXIT
sed 7d "$html_file" | xmllint --format --encode UTF-8 --noent - -o "$tmp_file"
head -n7 "$tmp_file" >> "$xhtml_file"
cat /tmp/css.css >>"$xhtml_file"
tail -n +8 "$tmp_file" \
	| sd '<pre>\n\t*<code ' '<pre><code ' \
	| sd '(?:\n)</code>\n\t*</pre>' '</code></pre>' >>"$xhtml_file"
tail -n +2 "$xhtml_file" > "$html_file"
sed -i 5d "$xhtml_file" # busybox sed supports "-i"

# the "sed 5d" deletes the now-redundant meta charset; it's the first
# thing in the <head>.

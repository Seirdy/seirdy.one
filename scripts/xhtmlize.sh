#!/bin/sh
# takes an arg for the output dir.
# copies every .html file to an equivalent .xhtml file, but replaces
# the meta charset with an XML declaration for compatibility with some
# XML tooling.
# this means that every index.html file has an equivalent index.xhtml file.
# content negotiation allows an agent to pick html or xhtml.
# echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"

find "$1" -type f -name '*.html' \
	-exec sh -c 'echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" >"${0%*.html}.xhtml" && xmlfmt -i "	" -f "$0" | busybox sed -e :a -e "/./,\$!d;/^\n*\$/{\$d;N;};/\n\$/ba" | sd -f m "\n(?:\t*)?</" "</" | sd -f m "<pre>\n\t*<code" "<pre><code" | sd -f m "\(\n\t*<abbr" "(<abbr" | pee "sed 5d >>\"${0%*.html}.xhtml\"" "sponge \"$0\""' {} \;
# done

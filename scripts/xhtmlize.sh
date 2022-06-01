#!/bin/sh
# takes an arg for the output dir.
# copies every .html file to an equivalent .xhtml file, but replaces
# the meta charset with an XML declaration for compatibility with some
# XML tooling.
# this means that every index.html file has an equivalent index.xhtml file.
# content negotiation allows an agent to pick html or xhtml.

find "$1" -type f -name '*.html' \
	-exec sh -c 'echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" | cat - "$0" | grep -Fv "<meta charset=\"UTF-8\" />" >"${0%*.html}.xhtml"' {} \;
# done

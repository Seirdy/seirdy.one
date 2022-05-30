#!/bin/sh
# takes an arg for the output dir.
# copies every .html file to an equivalent .xhtml file.
# does the same for compressed html files.
# this means that every index.html file has an equivalent index.xhtml file.
# content negotiation allows an agent to pick html or xhtml.

# too lazy to DRY this shit
find "$1" -type f -name '*.html' -exec sh -c 'cp "$0" "${0%*.html}.xhtml"' {} \;
find "$1" -type f -name '*.html.gz' -exec sh -c 'cp "$0" "${0%*.html.gz}.xhtml.gz"' {} \;
find "$1" -type f -name '*.html.br' -exec sh -c 'cp "$0" "${0%*.html.br}.xhtml.br"' {} \;
# done

#!/bin/sh
set -e -u
pwd="$(dirname "$0")"
output_dir="$1"

find_files_to_analyze() {
	find "$output_dir" -type f -name '*.xhtml' -o -name '*.svg' \
		| grep -Ev '(bimi\.svg|search/index\.x?html)$'
}

files_to_analyze="$(find_files_to_analyze)"

# we skip the BIMI icon (VNU can't handle SVG 1.2) and the search page (it has raw templates).
vnu \
	--stdout \
	--format json \
	--also-check-svg \
	$files_to_analyze \
	| sh "$pwd/filter-vnu.sh"

#!/bin/sh

# Runs the Nu HTML checker (assumed to be available on your $PATH as `vnu`) on all pages.

#shellcheck disable=SC3040  # This only sets pipefail if it's available and otherwise does nothing
set -o pipefail 2>/dev/null || true
set -e -u
dirname="$(dirname "$0")"
output_dir="$1"

# List all HTML, XHTML, and SVG files we wish to check.
# We test both XHTML and HTML files, despite the fact that they are identical, because we want to validate under both an HTML and XML parser. VNU has some HTML-only checks.
find_files_to_analyze() {
	find "$output_dir" -type f -name '*.html' -o -name '*.xhtml' -o -name '*.svg' \
		| grep -Ev '(bimi\.svg|search/index\.x?html)$'
}

# Force a non-zero exit code for vnu. We'll decide the exit status after filtering out false-posives.
vnu_nofail() {
	xargs vnu --stdout --format json --also-check-svg || true
}

# files_to_analyze="$(find_files_to_analyze)"

# we skip the BIMI icon (VNU can't handle SVG 1.2) and the search page (it has raw templates).
find_files_to_analyze \
	| vnu_nofail \
	| sh "$dirname/filter-vnu.sh"

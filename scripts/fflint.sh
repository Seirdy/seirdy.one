#!/bin/sh

#fflint json --show-tests all --show-detail "$output_dir/**/*.json"
set -e -u
output_dir="$1"

fflint_wrapper() {
	fflint --fail-fast --progress=false --show-tests failing $*
}

cd "$output_dir"
find '.' -type f -name "*.jpg" | fflint_wrapper --height 1-1500 --width 1-1500 jpeg @-
find '.' -type f -name "*.png" | fflint_wrapper --height 1-1500 --width 1-1500 png @-
find '.' -type f -name "*.json" -o -name ".webmanifest" | fflint_wrapper json @-
find '.' -type f -name "*.html" | fflint_wrapper html @-
find '.' -type f -name "*.svg" | fflint_wrapper --height 1-1500 --width 1-1500 svg @-
find '.' -type f -name "*.txt" -o -name "*.gmi" -o -name "*.asc" | fflint_wrapper text @-
find '.' -type f -name "*.xhtml" -o -name "*.xml" | fflint_wrapper xml @-

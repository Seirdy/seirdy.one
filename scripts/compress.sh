#!/bin/sh

# takes three args:
# 1. output dir
# 2. "gzip" or "brotli"
# 3. ECT zopfli compression level

#shellcheck disable=SC3040  # This only sets pipefail if it's available and otherwise does nothing
set -o pipefail 2>/dev/null || true
set -e -u

dirname="$(dirname "$0")"
output_dir="$1"
format="$2"

alias find_compressible='find "$output_dir" -type f \( -name "*.html" -o -name "*.txt" -o -name "*.xml" -o -name "*.webmanifest" -o -name "*.*.svg" -o -name "*.json" \)'

if [ "$format" = "gzip" ]; then
	# compression level should be the third argument
	find_compressible | xargs -n1 sh "$dirname/ect-wrapper.sh" "${3-6}"
elif [ "$format" = "brotli" ]; then
	find_compressible | xargs -n1 sh "$dirname/brotli-wrapper.sh"
fi

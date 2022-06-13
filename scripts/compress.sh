#!/bin/sh

# takes three args:
# 1. output dir
# 2. "gzip" or "brotli"
# 3. ECT zopfli compression level

set -e -u

output_dir="$1"
format="$2"

alias find_compressible='find "$output_dir" -type f \( -name "*.html" -o -name "*.txt" -o -name "*.xhtml" -o -name "*.xml" -o -name "*.webmanifest" -o -name "*.*.svg" \)'

if [ "$format" = "gzip" ]; then
	compress_level="$3"
	find_compressible -exec ect -quiet -"$compress_level" -gzip {} \;
elif [ "$2" = "brotli" ]; then
	find_compressible -exec brotli -Z -- {} \;
fi

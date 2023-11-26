#!/bin/sh
# compress a file with ect and preserve the mtime
# args: compression level and filename.
set -e -u

if [ ! -f "$2.gz" ]; then
	ect -quiet -"$1" -gzip "$2"
	touch -r "$2" "$2.gz"
fi

#!/bin/sh
# compress a file with brotli if it isn't already compressed. 
set -e -u

if [ ! -f "$1.br" ]; then
	brotli -Z -- "$1"
fi


#!/bin/sh

set -e -u
#shellcheck disable=SC3040  # This only sets pipefail if it's available and otherwise does nothing
set -o pipefail 2>/dev/null || true

dirname="$(dirname "$0")"
curl_wrapper="$dirname/curl-wrapper.sh"
bookmarks_file="$dirname/../data/bookmarks.json"

if command -v buku >/dev/null; then
	buku -t public -j >"$bookmarks_file"
elif [ ! -f "$bookmarks_file" ]; then
	"$curl_wrapper" 'https://seirdy.one/data/bookmarks.json' >"$bookmarks_file"
else
	echo 'using cached bookmarks'
fi

#!/bin/sh
#
# Script to authenticate with webmentiond and grab a temporary generated
# bearer token, writing it to .webmentiond-token for Hugo to then read.

set -e

_key() {
	if [ -n "$BUILD_SUBMITTER" ]; then
		cat ~/.webmentiond-key
	else
		pash show webmentiond-ci-key
	fi
}

key="$(_key)"

set -u 

# just a lil curl wrapper I use on seirdy.one
alias ccurl='curl --proto "=https" --proto-default https --tlsv1.3 --cert-status --compressed'

_token() {
	ccurl -sX POST https://seirdy.one/webmentions/authenticate/access-key -d "key=$key"
}

token="$(_token)"

set +u
ccurl -H "Authorization: Bearer $token" 'https://seirdy.one/webmentions/manage/mentions?limit=9999&status=approved' >data/webmentions.json
# printf '%s' "$token" >.webmentiond-token
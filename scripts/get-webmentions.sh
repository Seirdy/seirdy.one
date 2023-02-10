#!/bin/sh
#
# Script to fetch all approved webmentions from webmentiond as a big json response.
# Uses POSIX and cURL in CI, also uses any pass/pash-compatible pwmngr otherwise
# The response is cached for 90 minutes.

set -e -u

auth_url='https://seirdy.one/webmentions/authenticate/access-key'
webmentions_url='https://seirdy.one/webmentions/manage/mentions?limit=9999&status=approved'
webmentions_file="$(realpath data/webmentions.json)"

# just a little curl wrapper I use on seirdy.one
alias ccurl='curl --proto "=https" --proto-default https --tlsv1.3 --cert-status'

# use a long-lived key (password) to fetch a short-lived bearer token.
key() {
	set +u
	if [ -n "$BUILD_SUBMITTER" ]; then
		cat ~/.webmentiond-key
	else
		pash show webmentiond-ci-key
	fi
	set -u
}

token() {
	ccurl -sX POST "$auth_url" -d "key=$(key)"
}

# use that token to fetch all webmentions
fetch_webmentions() {
	ccurl --compressed -H "Authorization: Bearer $(token)" "$webmentions_url"
}

# fetch webmentions if we don't have a fresh copy already.

if [ -f "$webmentions_file" ] \
	&& [ "$(find "$webmentions_file" -mmin +90)" = "" ]; then
	echo 'Using cached webmentions'
else
	echo 'Fetching webmentions'
	fetch_webmentions >"$webmentions_file"
fi

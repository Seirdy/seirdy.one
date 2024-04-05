#!/bin/sh
#
# Script to fetch all approved webmentions from webmentiond as a big json response.
# Uses POSIX and cURL in CI, also uses any pass/pash-compatible pwmngr otherwise
# The response is cached for 90 minutes. If fetching fresh webmentions fails, fall back to the cached version for up to one day (1440 minutes). If cached webmentions are older than a day, error out.

# no pipefail here since there are no pipes.
set -e -u

exit_on_connectivity_failure() {
	echo "You are offline"
	exit 0
}

if [ -z "$JOB_URL" ]; then
	sh scripts/connectivity-check.sh || exit_on_connectivity_failure
fi

dirname="$(dirname "$0")"
curl_wrapper="$dirname/curl-wrapper.sh"
auth_url='https://collector.seirdy.one/webmentions/authenticate/access-key'
webmentions_url='https://collector.seirdy.one/webmentions/manage/mentions?limit=9999&status=approved'
webmentions_file="$dirname/../data/webmentions.json"

stale_after_minutes=90
fallback_stale_after_minutes=1440

skip_check=0
times_run=0

check_cached_webmentions() {
	times_run="$((times_run + 1))"
	if [ "$skip_check" = 0 ]; then
		expires_in="$fallback_stale_after_minutes"
		if [ $# -gt 0 ]; then
			expires_in="$1"
		fi
		exit_status=1
		if [ -f "$webmentions_file" ]; then
			old_webmention_file="$(find "$webmentions_file" -mmin +"$expires_in")"
			if [ "$old_webmention_file" = "" ]; then
				echo 'Using cached webmentions'
				skip_check=1
				exit_status=0
				exit 0
			fi
			return 1
		fi
		if [ "$exit_status" = 1 ] && [ "$times_run" = 2 ]; then
			echo "Webmentions are outdated. failed to fetch for over a day."
			exit "$exit_status"
		fi
	fi
}

trap check_cached_webmentions EXIT

# Grab my long-lived key (password). We will use this to authenticate.
key() {
	set +u
	if [ -n "$JOB_URL" ]; then
		cat ~/.webmentiond-key
	else
		pash show webmentiond-ci-key
	fi
	set -u
}

# Fetch a short-lived access token from my webmention receiver.
token() {
	key_response="$(key)"
	"$curl_wrapper" -sX POST "$auth_url" -d "key=$key_response"
}

# Verify that the webmentions file has downloaded succesfully by ensuring that it starts and ends with a given substring.
# The total number of webmentions should be at least a 3-digit number.
verify_webmentions() {
	grep -E '^\{"items":\[\{"id":".*,"total":[0-9]{3}([0-9]*)?\}$' "$webmentions_file.tmp" >/dev/null
}

# use the token to fetch all webmentions.
fetch_webmentions() {
	echo 'Fetching webmentions'
	token_response="$(token)" || return 1
	"$curl_wrapper" --compressed -H "Authorization: Bearer $token_response" "$webmentions_url" -o "$webmentions_file.tmp" || return 1
	if verify_webmentions; then
		mv "$webmentions_file.tmp" "$webmentions_file"
	else
		echo 'Error: webmentions failed to verify'
		exit 1
	fi
}

# fetch webmentions if we don't have a fresh copy already.
if [ -f "$webmentions_file" ]; then
	if ! check_cached_webmentions "$stale_after_minutes"; then
		fetch_webmentions
	fi
else
	fetch_webmentions
fi

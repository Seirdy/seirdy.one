#!/bin/sh
# Ensure that we can connect to seirdy.one, and print the ipv4/ipv6 addresses used. The latter makes searching through my server logs easier.
# Return a bad exit code if we can't connect over either ipv4 or ipv6.

# no pipefail here since there are no pipes.
set -e -u

ipv6_success=1
ipv4_success=1

curl_wrapper="$(dirname "$0")/curl-wrapper.sh"

"$curl_wrapper" -6 'https://seirdy.one/ip' || ipv6_success=0
echo
"$curl_wrapper" -4 'https://seirdy.one/ip' || ipv4_success=0
echo

if [ "$ipv6_success" = 0 ] && [ "$ipv4_success" = 0 ]; then
	echo "Failed to connect"
	exit 1
fi

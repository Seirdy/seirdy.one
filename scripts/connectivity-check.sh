#!/bin/sh
set -e -u

alias curl_cmd=curl --proto "=https" --proto-default https --http2 -siSL --tlsv1.3 --cert-status

ipv6_success=1
ipv4_success=1

curl_cmd -6 'seirdy.one/ip' || ipv6_success=0
echo
curl_cmd -4 'seirdy.one/ip' || ipv4_success=0
echo

if [ "$ipv6_success" = 0 ] && [ "$ipv4_success" = 0 ]; then
	echo "Failed to connect"
	exit 1
fi

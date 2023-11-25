#!/bin/sh
# a curl wrapper for seirdy.one
curl --proto "=https" --tlsv1.3 --cert-status -sS -m${SEIRDYONE_CURL_TIMEOUT-10} "$@"

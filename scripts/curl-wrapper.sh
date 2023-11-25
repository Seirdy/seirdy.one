#!/bin/sh
# a curl wrapper for seirdy.one
# no pipefail here since there are no pipes.

set -e -u
curl --proto "=https" --tlsv1.3 --cert-status -sS -m"${SEIRDYONE_CURL_TIMEOUT-10}" "$@"

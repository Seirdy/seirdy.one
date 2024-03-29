#!/bin/sh
# filters the Nu HTML Validator's JSON output. Operates on stdin.
# no pipefail here since there are no pipes.
set -e -u

root_dir="$(dirname "$0")/.."
vnu_output="$(jaq --from-file "$root_dir/linter-configs/vnu_filter.jq")"
if [ "$vnu_output" = '' ]; then
	echo "All markup is valid"
	exit 0
fi
echo "Markup errors found!" 1>&2
echo "$vnu_output"
exit 1

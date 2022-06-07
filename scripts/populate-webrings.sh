#!/bin/sh

# Get webring links to append to the CSV before building

# Some webrings require an iframe or scripts, but I want a plain static
# first-party HTML+CSS page. This script fetches webring links by
# parsing the iframes and appends appropriate values to my webrings.csv file.

set -e -u


# the name of this program
progname="$(basename "$0")"
dirname="$(dirname "$0")"

webrings_src="$dirname/../csv/webrings.base.csv"
webrings_dest="$dirname/../csv/webrings.csv"

help_text="Usage: $progname [OPTION...]

Update webrings.csv with new prev/next links, to avoid iframes/scripts

Options:
  -h            Print this help and exit
  -d            Dry run; just print results, don't update webrings.csv
"

usage() {
	printf '%s' "$help_text"
}

# when the user passess bad args, send a msg to stderr and exit
# usage: bad_option <option> <reason>
bad_option() {
	echo "$progname: option $1: $2" >&2
	usage >&2
	exit 1
}

dry_run='0'

while getopts "hd" flags; do
	case $flags in
		h)
			usage
			exit 0
			;;
		d)
			dry_run='1'
			shift
			;;
		*)
			bad_option "$flags" 'invalid option'
			exit 1
			;;
	esac
done

# values for the GEORGE webring
george() {
	echo GEORGE
	curl -s 'https://george.gh0.pw/embed.cgi?seirdy' | htmlq -a href 'main p a'
}

values_to_csv() {
	tr '\n' ',' && echo
}

print_csv_values() {
	printf %s "$(george)" | values_to_csv
}

if [ -f "$webrings_dest" ]; then
	echo "webrings file already generated"
	exit 0
fi

if [ "$dry_run" = '1' ]; then
	print_csv_values
else
	print_csv_values | cat "$webrings_src" - >"$webrings_dest"
fi

# vi:ft=sh

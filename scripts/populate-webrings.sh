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

trim_trailing_comma() {
	sd ',$' ''
}

values_to_csv() {
	tr '\n' ',' | trim_trailing_comma && echo
}

# values for the GEORGE webring
# Left bc I quit trying to make a good first-party iframe alternative
# that conformed to my site design standards while also imparting the
# message of GEORGE as intended.
# george() {
# 	printf 'GEORGE,'
# 	{
# 		curl -sSL --compressed 'https://george.gh0.pw/embed.cgi?seirdy' \
# 		| htmlq -a href 'main p a' 
# 		echo "null"
# 	} | values_to_csv
# }
#
endless_orbit() {
	printf 'Endless Orbit,'
	{
		curl -sSL --compressed https://linkyblog.neocities.org/onionring/onionring-variables.js \
		| grep -C 1 https://seirdy.one/
		echo "'null',"
	} | sd https://seirdy.one/ https://linkyblog.neocities.org/webring.html \
		| sd "\n|'" '' | trim_trailing_comma
		echo
}

netizens() {
	printf 'Netizens,'
	{
		curl -sSL --compressed https://netizensring.link/onionring-variables.js \
		| grep -C 1 https://seirdy.one/
	} | sd 'https://seirdy.one/,?' 'https://netizensring.link/' \
		| sd "\n|'|\r" '' | trim_trailing_comma 
		echo ',null'
}

print_csv_values() {
	# george
	endless_orbit
	# netizens
}

if [ "$dry_run" = '1' ]; then
	print_csv_values
elif [ -f "$webrings_dest" ]; then
		echo "webrings file already generated"
else
	print_csv_values | cat "$webrings_src" - >"$webrings_dest"
fi

# vi:ft=sh

#!/bin/sh

case "$1" in
	seirdy.one)
		login='deploy@seirdy.one' # user@host
		www_prefix="$login:/var/www/seirdy.one"
		gemini_prefix="$login:/srv/gemini/seirdy.one"
		;;
	envs.net)
		login='seirdy@envs.net'
		www_prefix="$login:/home/seirdy/public_html"
		gemini_prefix="$login:/home/seirdy/public_gemini"
		;;
	localhost)
		www_prefix='/tmp/www/seeirdy.one'
		gemini_prefix='/tmp/gemini/serve/seirdy.one'
		mkdir -p "$www_prefix" "$gemini_prefix"
		;;
	*)
		echo 'must supply hostname' >&2
		exit 1
		;;
esac

rsync -rvzP --exclude "gemini" --exclude "*.gmi" public/ "$www_prefix/"
rsync -rvzP --exclude "*.html" public/gemini/ public/about public/posts "$gemini_prefix/"
rsync -rvzP public/posts/gemini.xml "$gemini_prefix/feed.xml"

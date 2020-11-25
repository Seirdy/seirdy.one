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

find public -type f -name '*.html' -o -name '*.css' -o -name '*.xml' -o -name '*.txt' \
	| grep -v gemini \
	| xargs zopfli
rsync -avzP --exclude 'gemini' --exclude '*.gmi' --exclude 'misc/' --exclude 'music.txt' --exclude '.well-known' public/ "$www_prefix/" --delete
rsync -avzP --exclude '*.html' --exclude 'misc/' --exclude 'music.txt' public/gemini/ public/about public/posts "$gemini_prefix/" --delete
rsync -avzP public/posts/gemini.xml "$gemini_prefix/feed.xml"

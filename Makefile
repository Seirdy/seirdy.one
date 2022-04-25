CSS_DIR = assets/css
DEVSERVER_URL="http://localhost:1313/"

DOMAIN = seirdy.one
HUGO_BASEURL = "https://$(DOMAIN)/"
HUGO_FLAGS = --gc --ignoreCache
USER = deploy@$(DOMAIN)
WWW_ROOT = /var/www/$(DOMAIN)
GEMINI_ROOT = /srv/gemini/$(DOMAIN)

WWW_RSYNC_DEST = $(USER):$(WWW_ROOT)
GEMINI_RSYNC_DEST = $(USER):$(GEMINI_ROOT)

OUTPUT_DIR = public
RSYNCFLAGS += -rlcv --zc=zstd --zl=6
# include br, jxl, and gmi in skip-compress; skip unchanged files.
RSYNCFLAGS += --skip-compress=gz/br/zst/png/webp/jpg/avif/jxl/mp4/mkv/webm/opus/mp3 -c
# compression gets slow for extreme levels like the old "70109"
ECT_LEVEL=9

.PHONY: hugo
hugo: clean
	hugo -b $(HUGO_BASEURL) $(HUGO_FLAGS)

# .hintrc-local for linting local files
# same as regular .hintrc but with a different connector.
.hintrc-local: .hintrc
	jq --tab '.connector .name = "local" | del(.connector .options)' <.hintrc >.hintrc-local

.hintrc-devserver: .hintrc
	jq --tab '.extends = ["development"] | .hints["http-compression","https-only","ssllabs","sri"] = "off"' <.hintrc >.hintrc-devserver

.PHONY: clean
clean:
	rm -rf $(OUTPUT_DIR) .lighthouseci lighthouse-reports mentions.json

.PHONY: lint-css
lint-css:
	pnpx stylelint --di --rd --rdd $(CSS_DIR)/main.css $(CSS_DIR)/dark.css
	csslint --quiet $(CSS_DIR)

.PHONY: hint
hint: hugo .hintrc-local
	hint --config .hintrc-local -f codeframe $(OUTPUT_DIR)
	rm .hintrc-local

.PHONY: lint-local
lint-local: lint-css hint

# dev server
.PHONY: serve
serve:
	hugo serve --disableLiveReload $(HUGO_FLAGS)

.PHONY: hint-devserver
hint-devserver: .hintrc-devserver
	hint --config .hintrc-devserver -f codeframe $(DEVSERVER_URL)
	rm .hintrc-devserver

.PHONY: check-links
check-links: hugo
	lychee --verbose $(find public -type f -name '*.html' -o -name '*.gmi' -o -name '*.txt') content/posts/*.md content/posts/*.gmi

.PHONY: test
test: lint-css hint-devserver check-links

.PHONY: build
build: hugo
ifndef NO_STATIC
	find $(OUTPUT_DIR) -type f -name '*.html' -o -name '*.css' -o -name '*.xml' -o -name '*.webmanifest' -o -name '*.*.svg' \
		| grep -v gemini \
		| xargs ect -$(ECT_LEVEL) -gzip
	find $(OUTPUT_DIR) -type f -name '*.html' -o -name '*.css' -o -name '*.xml' -o -name '*.webmanifest' -o -name '*.*.svg' \
		| grep -v gemini \
		| xargs brotli -q 11 --
endif

# save webmentions to a file, don't send yet
mentions.json: hugo
	# gather old version of the site
	# rsync $(RSYNCFLAGS) --exclude '*.gz' --exclude '*.br' --exclude '*.png' --exclude-from .rsyncignore $(WWW_RSYNC_DEST)/ old
	static-webmentions -f mentions.json.unfiltered find 
	# filter the webmentions a bit; jq offers more flexibility than config.toml
	jq '[ .[] | select(.Dest|test("https://(git.sr.ht/~seirdy/seirdy.one/log/master|seirdy.one|web.archive.org|archive.is|en.wikipedia.org|matrix.to|([a-z]*.)?reddit.com|github.com)") | not) ]' <mentions.json.unfiltered >mentions.json
	rm mentions.json.unfiltered

.PHONY: deploy-html
deploy-html: build
	rsync $(RSYNCFLAGS) --exclude 'gemini' --exclude '*.gmi' --exclude-from .rsyncignore $(OUTPUT_DIR)/ $(WWW_RSYNC_DEST) --delete

.PHONY: deploy-gemini
deploy-gemini: hugo
	rsync $(RSYNCFLAGS) --exclude '*.html' --exclude '*.xml' --exclude '*.gz' --exclude '*.br' --exclude-from .rsyncignore $(OUTPUT_DIR)/gemini/ $(OUTPUT_DIR)/about $(OUTPUT_DIR)/posts $(OUTPUT_DIR)/publickey.* $(GEMINI_RSYNC_DEST)/ --delete
	rsync $(RSYNCFLAGS) $(OUTPUT_DIR)/posts/gemini.xml $(GEMINI_RSYNC_DEST)/feed.xml

.PHONY: deploy
deploy: deploy-html deploy-gemini

## stuff for the staging server
.PHONY: test-staging
test-staging: deploy-html
	yq e '.ci .collect .url | .[]' .lighthouserc.yml | xargs npx hint -f codeframe
	npx lhci autorun

.PHONY: all
all: test deploy

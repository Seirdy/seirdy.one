CSS_DIR = assets/css
SRCFILES = layouts/**/*.html layouts/**/*.xml content/**/*.md $(CSS_DIR)/*.css static/*.svg assets/*.svg config.toml csv/*
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
RSYNCFLAGS += -rlcv --zc=zstd --zl=6 --skip-compress=gz/br/zst/png/webp/jpg/avif/jxl/mp4/mkv/webm/opus/mp3
# compression gets slow for extreme levels like the old "70109"
ECT_LEVEL=9

VNU ?= vnu

.PHONY: hugo
hugo: $(SRCFILES)
	hugo -b $(HUGO_BASEURL) $(HUGO_FLAGS) -d $(OUTPUT_DIR)

# .hintrc-local for linting local files
# same as regular .hintrc but with a different connector.
.hintrc-local: .hintrc
	jq --tab '.connector .name = "local" | del(.connector .options)' <linter-configs/hintrc >.hintrc-local

.hintrc-devserver: .hintrc
	jq --tab '.extends = ["development"] | .hints["http-compression","https-only","ssllabs","sri"] = "off"' <linter-configs/hintrc >.hintrc-devserver

.PHONY: clean
clean:
	rm -rf $(OUTPUT_DIR) .lighthouseci lighthouse-reports mentions.json

.PHONY: lint-css
lint-css: $(CSS_DIR)/*.css
	pnpm -s dlx stylelint --config linter-configs/stylelintrc.json --di --rd --rdd $(CSS_DIR)/*.css
	@#csslint --quiet $(CSS_DIR)

.PHONY: lint-html
lint-html:
	$(VNU) --stdout --format json --skip-non-html --also-check-svg $(OUTPUT_DIR) | jq --from-file linter-configs/vnu_filter.jq

.PHONY: hint
hint: hugo .hintrc-local
	hint --config .hintrc-local -f codeframe $(OUTPUT_DIR)
	rm .hintrc-local

.PHONY: lint-local
lint-local: lint-css lint-html

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

gz:
	find $(OUTPUT_DIR) -type f -name '*.html' -o -name '*.css' -o -name '*.xml' -o -name '*.webmanifest' -o -name '*.*.svg' \
		| grep -v gemini \
		| xargs ect -$(ECT_LEVEL) -gzip

brotli:
	find $(OUTPUT_DIR) -type f -name '*.html' -o -name '*.css' -o -name '*.xml' -o -name '*.webmanifest' -o -name '*.*.svg' \
		| grep -v gemini \
		| xargs brotli -q 11 --

compress: gz brotli

.PHONY: compress gz brotli

# save webmentions to a file, don't send yet
mentions.json: hugo
	# gather old version of the site
	# rsync $(RSYNCFLAGS) --exclude '*.gz' --exclude '*.br' --exclude '*.png' --exclude-from .rsyncignore $(WWW_RSYNC_DEST)/ old
	static-webmentions -f mentions.json.unfiltered find
	# filter the webmentions a bit; jq offers more flexibility than config.toml
	jq '[ .[] | select(.Dest|test("https://(git.sr.ht/~seirdy/seirdy.one/log/master|seirdy.one|web.archive.org|archive.is|en.wikipedia.org|matrix.to|([a-z]*.)?reddit.com|github.com)") | not) ]' <mentions.json.unfiltered >mentions.json
	rm mentions.json.unfiltered

.PHONY: deploy-html
deploy-html:
	rsync $(RSYNCFLAGS) --exclude 'gemini' --exclude '*.gmi' --exclude-from .rsyncignore $(OUTPUT_DIR)/ $(WWW_RSYNC_DEST) --delete

.PHONY: deploy-gemini
deploy-gemini:
	rsync $(RSYNCFLAGS) --exclude '*.html' --exclude '*.xml' --exclude '*.gz' --exclude '*.br' --exclude-from .rsyncignore $(OUTPUT_DIR)/gemini/ $(OUTPUT_DIR)/about $(OUTPUT_DIR)/posts $(OUTPUT_DIR)/publickey.* $(GEMINI_RSYNC_DEST)/ --delete

.PHONY: deploy
deploy: deploy-html deploy-gemini

## stuff for the staging server
.PHONY: test-staging
test-staging: deploy-html
	yq e '.ci .collect .url | .[]' .lighthouserc.yml | xargs npx hint -f codeframe
	npx lhci autorun

.PHONY: all
all: test deploy

.PHONY: deploy-envs
deploy-envs:
	@$(MAKE) NO_STATIC=1 HUGO_FLAGS='--gc' USER=seirdy@envs.net WWW_ROOT=/home/seirdy/public_html GEMINI_ROOT=/home/seirdy/public_gemini HUGO_BASEURL='https://envs.net/~seirdy/' OUTPUT_DIR=public_envs hugo
	@$(MAKE) NO_STATIC=1 HUGO_FLAGS='--gc' USER=seirdy@envs.net WWW_ROOT=/home/seirdy/public_html GEMINI_ROOT=/home/seirdy/public_gemini HUGO_BASEURL='https://envs.net/~seirdy/' OUTPUT_DIR=public_envs lint-local deploy

.PHONY: deploy-prod
deploy-prod:
	@$(MAKE) clean
	@$(MAKE) hugo
	@$(MAKE) compress
	@$(MAKE) deploy


# linting and compression can happen in parallel
.PHONY: deploy-staging
deploy-staging:
	@$(MAKE) HUGO_BASEURL=https://staging.seirdy.one HUGO_FLAGS='--gc' DOMAIN=staging.seirdy.one USER=deploy@seirdy.one OUTPUT_DIR=public_staging clean
	@$(MAKE) HUGO_BASEURL=https://staging.seirdy.one HUGO_FLAGS='--gc' DOMAIN=staging.seirdy.one USER=deploy@seirdy.one OUTPUT_DIR=public_staging hugo
	@$(MAKE) HUGO_BASEURL=https://staging.seirdy.one HUGO_FLAGS='--gc' DOMAIN=staging.seirdy.one USER=deploy@seirdy.one OUTPUT_DIR=public_staging lint-local compress
	@$(MAKE) HUGO_BASEURL=https://staging.seirdy.one HUGO_FLAGS='--gc' DOMAIN=staging.seirdy.one USER=deploy@seirdy.one OUTPUT_DIR=public_staging deploy

.PHONY: deploy-onion
deploy-onion:
	@$(MAKE) WWW_ROOT=/var/www/seirdy.onion HUGO_BASEURL='http://wgq3bd2kqoybhstp77i3wrzbfnsyd27wt34psaja4grqiezqircorkyd.onion/' OUTPUT_DIR=public_onion clean
	@$(MAKE) WWW_ROOT=/var/www/seirdy.onion HUGO_BASEURL='http://wgq3bd2kqoybhstp77i3wrzbfnsyd27wt34psaja4grqiezqircorkyd.onion/' OUTPUT_DIR=public_onion hugo
	@$(MAKE) WWW_ROOT=/var/www/seirdy.onion HUGO_BASEURL='http://wgq3bd2kqoybhstp77i3wrzbfnsyd27wt34psaja4grqiezqircorkyd.onion/' OUTPUT_DIR=public_onion compress
	@$(MAKE) WWW_ROOT=/var/www/seirdy.onion HUGO_BASEURL='http://wgq3bd2kqoybhstp77i3wrzbfnsyd27wt34psaja4grqiezqircorkyd.onion/' OUTPUT_DIR=public_onion deploy-html

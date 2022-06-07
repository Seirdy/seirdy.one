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

csv/webrings.csv:
	sh scripts/populate-webrings.sh

.PHONY: hugo
hugo: csv/webrings.csv $(SRCFILES)
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
	$(VNU) --stdout --format json --skip-non-html --also-check-svg $(OUTPUT_DIR) | sh scripts/filter-vnu.sh

.PHONY: hint
hint: hugo .hintrc-local
	hint --config .hintrc-local -f codeframe $(OUTPUT_DIR)
	rm .hintrc-local

.PHONY: lint-local
lint-local: lint-css lint-html

# dev server, includes future and draft posts
.PHONY: serve
serve:
	hugo serve --disableLiveReload $(HUGO_FLAGS) -FwDb http://localhost:1313/

.PHONY: hint-devserver
hint-devserver: .hintrc-devserver
	hint --config .hintrc-devserver -f codeframe $(DEVSERVER_URL)
	rm .hintrc-devserver

.PHONY: check-links
check-links: hugo
	lychee --verbose $(find public -type f -name '*.html' -o -name '*.gmi' -o -name '*.txt') content/posts/*.md content/posts/*.gmi

.PHONY: test
test: lint-css hint-devserver check-links

gzip:
	sh scripts/compress.sh $(OUTPUT_DIR) gzip $(ECT_LEVEL)
brotli:
	sh scripts/compress.sh $(OUTPUT_DIR) brotli
compress: gzip brotli
.PHONY: gzip brotli compress

.PHONY: xhtmlize
xhtmlize:
	sh scripts/xhtmlize.sh $(OUTPUT_DIR)

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
	rsync $(RSYNCFLAGS) --exclude '*.html' --exclude '*.xml' --exclude '*.xhtml' --exclude '*.gz' --exclude '*.br' --exclude-from .rsyncignore $(OUTPUT_DIR)/gemini/ $(OUTPUT_DIR)/about $(OUTPUT_DIR)/posts $(OUTPUT_DIR)/publickey.* $(GEMINI_RSYNC_DEST)/ --delete

.PHONY: deploy
deploy: deploy-html deploy-gemini

.PHONY: .prepare-deploy
.prepare-deploy:
	@$(MAKE) clean
	@$(MAKE) hugo
	@$(MAKE) xhtmlize

# deploy steps need to happen one at a time
.PHONY: deploy-prod
deploy-prod: .prepare-deploy
	@$(MAKE) compress
	@$(MAKE) deploy

.PHONY: deploy-onion
deploy-onion:
	@$(MAKE) WWW_ROOT=/var/www/seirdy.onion HUGO_BASEURL='http://wgq3bd2kqoybhstp77i3wrzbfnsyd27wt34psaja4grqiezqircorkyd.onion/' OUTPUT_DIR=public_onion deploy-prod

# we only deploy html to the staging site
.PHONY: deploy-staging
deploy-staging:
	@$(MAKE) DOMAIN=staging.seirdy.one USER=deploy@seirdy.one OUTPUT_DIR=public_staging .prepare-deploy
	@$(MAKE) DOMAIN=staging.seirdy.one USER=deploy@seirdy.one OUTPUT_DIR=public_staging compress
	@$(MAKE) DOMAIN=staging.seirdy.one USER=deploy@seirdy.one OUTPUT_DIR=public_staging deploy-html

.PHONY: lint-and-deploy-staging
lint-and-deploy-staging:
	@$(MAKE) HUGO_FLAGS='' DOMAIN=staging.seirdy.one USER=deploy@seirdy.one OUTPUT_DIR=public_staging .prepare-deploy
	@$(MAKE) HUGO_FLAGS='' DOMAIN=staging.seirdy.one USER=deploy@seirdy.one OUTPUT_DIR=public_staging compress lint-local
	@$(MAKE) HUGO_FLAGS='' DOMAIN=staging.seirdy.one USER=deploy@seirdy.one OUTPUT_DIR=public_staging deploy-html

.PHONY: deploy-envs
deploy-envs:
	@$(MAKE) NO_STATIC=1 HUGO_FLAGS='' USER=seirdy@envs.net WWW_ROOT=/home/seirdy/public_html GEMINI_ROOT=/home/seirdy/public_gemini HUGO_BASEURL='https://envs.net/~seirdy/' OUTPUT_DIR=public_envs .prepare-deploy
	@$(MAKE) NO_STATIC=1 HUGO_FLAGS='' USER=seirdy@envs.net WWW_ROOT=/home/seirdy/public_html GEMINI_ROOT=/home/seirdy/public_gemini HUGO_BASEURL='https://envs.net/~seirdy/' OUTPUT_DIR=public_envs lint-local
	@$(MAKE) NO_STATIC=1 HUGO_FLAGS='' USER=seirdy@envs.net WWW_ROOT=/home/seirdy/public_html GEMINI_ROOT=/home/seirdy/public_gemini HUGO_BASEURL='https://envs.net/~seirdy/' OUTPUT_DIR=public_envs deploy

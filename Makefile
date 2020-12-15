CSS_DIR = themes/etch-custom/assets/css

USER = deploy@seirdy.one
WWW_ROOT = /var/www/seirdy.one
GEMINI_ROOT = /srv/gemini/seirdy.one

WWW_RSYNC_DEST = $(USER):$(WWW_ROOT)
GEMINI_RSYNC_DEST = $(USER):$(GEMINI_ROOT)

OUTPUT_DIR = public

RSYNCFLAGS += -rlvz --zc=zstd

# .hintrc-local for linting local files
# same as regular .hintrc but with a different connector.
.hintrc-local: .hintrc
	jq --tab '.connector .name = "local" | del(.connector .options)' <.hintrc >.hintrc-local

clean:
	rm -rf $(OUTPUT_DIR) .hintrc-local

lint-css:
	stylelint $(CSS_DIR)/main.css $(CSS_DIR)/dark.css $(CSS_DIR)/narrow.css
	csslint $(CSS_DIR)

lint: lint-css build .hintrc-local
	hint --config .hintrc-local -f codeframe $(OUTPUT_DIR)

check-links: build
	lychee --verbose $(find public -type f -name '*.html' -o -name '*.gmi' -o -name '*.txt')

test: lint

hugo:
	hugo

build: hugo
# gzip_static + max zopfli compression
ifndef NO_GZIP_STATIC
	find $(OUTPUT_DIR) -type f -name '*.html' -o -name '*.css' -o -name '*.xml' -o -name '*.txt' \
		| grep -v gemini \
		| xargs zopfli --i50 --gzip
endif


deploy: build
	rsync $(RSYNCFLAGS) --exclude 'gemini' --exclude '*.gmi' --exclude-from .rsyncignore $(OUTPUT_DIR)/ $(WWW_RSYNC_DEST) --delete
	rsync $(RSYNCFLAGS) --exclude '*.html' --exclude '*.xml' --exclude-from .rsyncignore $(OUTPUT_DIR)/gemini/ $(OUTPUT_DIR)/about $(OUTPUT_DIR)/posts $(OUTPUT_DIR)/publickey.txt $(GEMINI_RSYNC_DEST)/ --delete
	rsync $(RSYNCFLAGS) $(OUTPUT_DIR)/posts/gemini.xml $(GEMINI_RSYNC_DEST)/feed.xml

all: clean lint deploy

.PHONY: clean lint-css test lint build deploy all

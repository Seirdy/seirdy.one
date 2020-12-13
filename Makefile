CSS_DIR = themes/etch-custom/assets/css

USER = deploy@seirdy.one
WWW_ROOT = /var/www/seirdy.one
GEMINI_ROOT = /srv/gemini/seirdy.one

WWW_RSYNC_DEST = $(USER):$(WWW_ROOT)
GEMINI_RSYNC_DEST = $(USER):$(GEMINI_ROOT)

OUTPUT_DIR = public/

RSYNCFLAGS += -avzP --zc=zstd

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

hugo:
	hugo

build: hugo
ifndef NO_GZIP_STATIC
	find $(OUTPUT_DIR) -type f -name '*.html' -o -name '*.css' -o -name '*.xml' -o -name '*.txt' \
		| grep -v gemini \
		| xargs zopfli --i150 --gzip
endif


deploy: build
	rsync $(RSYNCFLAGS) --exclude 'gemini' --exclude '*.gmi' --exclude-from .rsyncignore public/ $(WWW_RSYNC_DEST) --delete
	rsync $(RSYNCFLAGS) --exclude '*.html' --exclude '*.xml' --exclude-from .rsyncignore public/gemini/ public/about public/posts public/publickey.txt $(GEMINI_RSYNC_DEST)/
	rsync $(RSYNCFLAGS) public/posts/gemini.xml $(GEMINI_RSYNC_DEST)/feed.xml

all: clean lint deploy

.PHONY: clean lint-css lint build deploy all

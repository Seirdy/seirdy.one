# seirdy.one

[![builds.sr.ht status](https://builds.sr.ht/~seirdy/seirdy.one.svg)](https://builds.sr.ht/~seirdy/seirdy.one)

## Repository mirroring

This repository is pushed to the following forges:

- [Sourcehut](https://sr.ht/~seirdy/seirdy.one/)
- [GitLab.com](https://gitlab.com/Seirdy/seirdy.one)
- [GitHub](https://github.com/Seirdy/seirdy.one)
- [Codeberg](https://codeberg.org/Seirdy/seirdy.one)
- [envs.net gitea](https://git.envs.net/Seirdy/seirdy.one)

Code for my personal website, [seirdy.one](https://seirdy.one). Built with Hugo.

Also builds my Gemini capsule: <gemini://seirdy.one/>.

I document [my site design standards](https://seirdy.one/meta/site-design/) on my website.

## Dependencies

### Build-time dependencies

- Hugo. I usually use the most recent version of Hugo at the time of publishing, but it _should_ work with any version of Hugo v0.116.0 or later (v0.116.0 had an improvement to `where` that I might use).
- bmake or GNU Make. OpenBSD make (omake) should work too, but I haven't tested it.
- Git (Hugo uses Git info for features like date last updated)
- curl, for fetching some webring code and all my webmentions. **this requires authentication.** When running locally, it invokes `pash`, my password manager; when running in CI, it reads a file for a secret. You may have to modify `scripts/get-webmentions.sh` to avoid this.
- POSIX utilities: `grep`, `find`, `sed`, POSIX-compliant `/bin/sh`, etc. Tested to work with Busybox and GNU Coreutils.

Before deploying, I use some tools for post-processing:

- `xmllint`, part of libxml2, to format the generated polygot XHTML5 markup.
- a [patched version of html-tidy](https://git.sr.ht/~seirdy/tidy-html5)
- More POSIX utilities.

I also apply static compression at max levels, using the following tools:

- [Efficient Compression Tool](https://github.com/fhanau/Efficient-Compression-Tool) It's like zopfli but more efficient and faster. If you don't have it installed, it should be trivial to edit `scripts/compress.sh` to replace `ect` with `gzip` or `zopfli`.
- Brotli

I package all build-time dependencies _except_ curl as statically-linked binaries in a tarball, available at <https://seirdy.one/pb/binaries.tar.gz>.

### Other dependencies

To deploy, I use rsync with SSH and zstd support.

Further tasks also use additional command-line utilities such as `sd`, `htmlq`, and a version of `xargs` that supports the `-P` flag (nearly all versions of `xargs` do, but it's not POSIX). I run all npm packages using `pnpm -s dlx` (similar to `npx`).

To lint:

- Stylelint
- [html-validate](https://html-validate.org/)
- A very recent build of the W3C's [Nu HTML checker](https://github.com/validator/validator) to validate the HTML and XHTML, available on your `$PATH` as `vnu`. I have a very simple shell-script wrapper for this that invokes `java -jar`.
- [jq](https://stedolan.github.io/jq/), to filter false-positives from the Nu HTML checker and to verify that JSON files parse.
- [HTMLProofer](https://github.com/gjtorikian/html-proofer), version 5 or later. Requires Ruby.

More in-depth local tests:

- Axe-Core, using the CLI and a headless browser (Firefox or Chromium).
- IBM Equal Access Checker, using the CLI and a headless Chromium. Runs on a patched version of the site with a modified stylesheet due to a bug (reported upstream).

Remote tests:

- Lighthouse
- WebHint (might not pass; only informative)
- Feed validator (requires Python)

## Build instructions

- To just build the HTML: `make hugo`
- To build the polygot formatted HTML and XHTML: `make hugo xhtmlize`
- To lint and validate: `make hugo xhtmlize lint-local`
- To build everything and compress: `make hugo xhtmlize compress copy-to-xhtml`
- To deploy the clearnet site and corresponding Tor hidden service: `make deploy-prod deploy-onion`.

`lint-local` and deployment tasks support limited parallelization with `-j`.


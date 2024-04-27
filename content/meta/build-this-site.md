---
outputs:
    - html
title: How to build this site
description: "Instructions for re-building seirdy.one from its source code"
date: "2023-11-24T21:44:00-08:00"
---
Wanna steal this website? You're allowed to! Just remember that it's licensed under the CC-BY-SA (for content) and GNU Affero GPL Version 3 (for code) licenses.

Once you put a few binaries in your `$PATH`, building is just a `make` invocation away.

## Repository mirroring

I push the seirdy.one source code to the following forges:

- [Sourcehut](https://sr.ht/~seirdy/seirdy.one/)
- [GitLab.com](https://gitlab.com/Seirdy/seirdy.one)
- [GitHub](https://github.com/Seirdy/seirdy.one)
- [Codeberg (forgejo)](https://codeberg.org/Seirdy/seirdy.one)
- [envs.net (gitea)](https://git.envs.net/Seirdy/seirdy.one)

Clone the repository from any of those locations.

## Dependencies

### Build-time dependencies

- Hugo. I usually use the most recent version of Hugo at the time of publishing, but it _should_ work with any version of Hugo v0.116.0 or later (v0.116.0 had an improvement to `where` that I might use). I build Hugo with the `nodeploy` build-tag for a smaller binary and faster build-times.

- A `make` implementation. This site works with bmake (from NetBSD and FreeBSD) and GNU Make 4 or later. OpenBSD make ("omake") should work too, but I haven't tested it.

- Git. Hugo uses Git for generating modification timestamps.

- curl, for fetching some webring code and all my webmentions. **Fetching Webmentions requires authentication.** When running locally, it invokes `pash`, my password manager; when running in CI, it reads a file for a secret. You may have to modify `scripts/get-webmentions.sh` to avoid this.

- POSIX utilities: `grep`, `find`, `sed`, POSIX-compliant `/bin/sh`, etc. Tested to work with Busybox and GNU Coreutils. Shell scripts run with Zsh, Busybox `sh`, and the Debian Almquist shell.

Before deploying, I use some tools for post-processing:

- `xmllint`, part of libxml2, to format the generated polygot XHTML5 markup.

- ~~a [patched version of html-tidy](https://git.sr.ht/~seirdy/tidy-html5)~~ (I no longer use HTML-Tidy due to [a major upstream bug requiring a non-trivial fix](https://github.com/htacg/tidy-html5/issues/1094)).

- More POSIX utilities.

I also apply static compression at high levels, using the following tools:

- [Efficient Compression Tool](https://github.com/fhanau/Efficient-Compression-Tool) (`ect`). It's like zopfli but more efficient and faster. If you don't have it installed, it should be trivial to edit `scripts/compress.sh` to replace `ect` with `gzip` or `zopfli`.

- Brotli.

I package `xmllint`, `hugo`, `brotli`, and `ect` as statically-linked binaries in a tarball. You can download this tarball from <https://seirdy.one/pb/binaries.tar.gz>. You'll need to install `make`, `git`, POSIX utilities, and `curl` yourself. These should be fairly ubiquitous; there's a good chance that you already have them.

### Other dependencies

To deploy, I use rsync with SSH and zstd support.

Other lints/checks I run also use additional command-line utilities such as `sd`, `htmlq`, and a version of `xargs` that supports the `-P` flag (nearly all versions of `xargs` do, but it's not POSIX). I run most npm packages using `pnpm -s dlx` (similar to `npx`).

#### Quick linters

- Stylelint

- [html-validate](https://html-validate.org/)

- A very recent build of the W3C's [Nu HTML checker](https://github.com/validator/validator) to validate the HTML and XHTML, available on your `$PATH` as `vnu`. I have a very simple shell-script wrapper for this that invokes `java -jar`. You may have to update the CSS-Validator submodule to its latest commit to avoid false positives.

- [jaq](https://github.com/01mf02/jaq), to filter false-positives from the Nu HTML checker and to verify that JSON files parse. You can replace `jaq` with `jq` without any issues.

- [HTMLProofer](https://github.com/gjtorikian/html-proofer), version 5 or later. Requires Ruby.

- W3C feed validator (requires Python)

#### Slow linters

These linters use headless browsers and take several minutes to validate my whole site.

- Axe-Core, using the CLI and a headless browser (Firefox or Chromium).

- IBM Equal Access Checker, using the CLI and a headless Chromium. Runs on a patched version of the site with all instances of `content-visibility` removed from the stylesheet. I do this to work around [a false-positive, reported upstream](https://github.com/IBMa/equal-access/issues/1008).

#### Testing the deployed site

- WebHint (normally runs on every page in my sitemap with a headless browser. Abandonware but still works.)
- Lighthouse
- redbot

## Build instructions

- To just build the HTML: `make hugo`

- To build the polygot formatted HTML and XHTML: `make xhtmlize`

- To lint and validate: `make xhtmlize lint-local`

- To build everything and compress: `make xhtmlize compress copy-to-xhtml`

- To deploy the clearnet site and corresponding Tor hidden service: `make deploy-prod deploy-onion`.

`lint-local` and deployment tasks support limited parallelization with `-j`.


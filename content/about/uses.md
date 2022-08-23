---
outputs:
    - html
    - gemtext
title: Software I use
description: "All the most noteworthy software and hardware that Seirdy uses every day."
date: "2022-06-16T17:16:18-07:00"
---
Here's the software I use. I've recently started to reduce my use of <abbr title="Textual User Interfaces">TUIs</abbr> in favor of <abbr title="Command Line Interfaces">CLIs</abbr> for a variety of reasons. When possible, I try to use lightweight programs that can run on any machine, from a single-board computer to a giant desktop. I don't ever want to feel like I need to upgrade my hardware to do the same tasks as before: hardware upgrades should only be justified by my use-cases significantly changing, existing hardware being broken beyond repair, or upstream abandonment of security patches.[^1]

Hardware
--------

My main computer is a 2013 HP Elitebook 840 G1. It has an Intel i5-4300U CPU, with simultaneous multithreading disabled.

Environment
-----------


Fedora 36
: Primary OS. Uses Linux, Systemd, GNU libc, GNU coreutils, dnf, firewalld, and SELinux.

Sway
: Dynamic Wayland compositor that focuses on tiling window management but also supports tabbed and stacking layouts.

Zsh
: Login shell. POSIX-compatible and mostly Bash-compatible. Custom static build to skip checking system files and improve startup performance.

Foot
: Primary terminal emulator. Sometimes I use gnome-terminal when I'm using a screen reader.

Basic utilities
---------------


Neovim
: My `$EDITOR` of choice. Supports tree-sitter, uses lua configuration, and has a client for the Language Server Protocol (I only use the gopls, rust-analyzer, and ccls language servers)

ripgrep
: grep alternative that supports multiline regexes, PCRE2, and searching compressed files. Much faster as well.

[sd](https://github.com/chmln/sd)
: For better and faster multi-line regex manipulation than `sed`.

mpd
: My music player daemon, paired with [my mpd scripts](https://sr.ht/~seirdy/mpd-scripts/) and [mpd-mpris](https://github.com/natsukagami/mpd-mpris).

mpv
: My video player. I have three builds of mpv: one normal build, and two with decoder libraries that have profile-guided optimization for different types of video (anime, and live-action that includes heavy filmgrain). Often paired with [yt-dlp](https://github.com/yt-dlp/yt-dlp) and [mpv_sponsorblock](https://github.com/po5/mpv_sponsorblock).
: Also my main image viewer, since FFmpeg recently got support for JPEG-XL and AVIF.

[swayimg](https://github.com/artemsen/swayimg)
: Secondary image viewer; grabs window dimensions from the currently-focused window in Sway.

Tmux
: I typically don't use it for tiling or tabs, except over SSH. Sway has me covered there. I instead use Tmux for session management and for buffer manipulation (regex search, piping the buffer, writing the buffer to a file, etc).

WeeChat
: IRC client. I might use [senpai](https://sr.ht/~taiite/senpai/) eventually, if I can get it to play well with espeak-ng.

Newsboat
: Feed reader for RSS and Atom feeds. I'm thinking of switching to a feed-to-IMAP or Maildir setup eventually so I can get sync and use mblaze, and replace a TUI with a CLI. Ideally something that supports [WebSub.](https://websub.net/draft)

Orca
: Screen reader. Great for when I'm dealing with overstimulation and need to "turn everything off" for a while. I don't actually rely on this to use my machine.

Browsers
--------

I always disable JavaScript and <abbr title="Just-In-Time">JIT</abbr>-compilation unless it's absolutely required.


Firefox
: Default browser for most web pages. Trades some security for convenience. My setup is fingerprintable AF.

Chromium
: Used for web apps, security-sensitive work, and for certain specific web development tasks (Firefox is more than enough for most development tasks). Distribution packages of Chromium typically weaken many of its exploit mitigations (e.g. CFI), so I use [Thorium](https://github.com/Alex313031/Thorium) for now. Eventually, I might switch to [Hexavalent](https://github.com/Hexavalent-Browser/Hexavalent) once it's ready.

Tor Browser
: For anonymity (Safest level, or in Whonix at "Safer").

NetSurf
: When I'm low on battery or want to experiment a bit.

Mail
----

Email sucks but it's the only lightweight, open, federated protocol for subject-delimited threaded discussions that meets my needs. It also makes working with open-source projects easier: it gives me one place to look for patches and issues so I don't have to open GitHub, Codeberg, GitLab, Sourcehut, etc. in different tabs and check each one.[^2]


mbsync
: IMAP mail fetcher

msmtp
: SMTP client, for sending mail

[mblaze](https://github.com/leahneukirchen/mblaze)
: Routine tasks, displaying my inbox or list threads, reading email, organizing my messages

Neomutt
: My mail user agent, for the tasks that mbsync isn't good for (e.g. manual organization)

[w3m-sandbox](https://git.sr.ht/~seirdy/bwrap-scripts/tree/trunk/item/w3m-sandbox)
: Displays HTML mail in a sandboxed environment. Networking and most filesystem access are disabled; using its full unrestricted functionality will involve syscalls I forbid with seccomp and crash the program.

Other tools
-----------


jq
: Interpreter for the jq domain-specific programming language. Indespensible for creating, manipulaitng, and filtering data.

fzf
: A fuzzy-finder that blends the CLI and TUI. Used for my program launcher, tab-completion, shell history search, Neovim menus (with telescope.nvim), and command-line path-completion.

  Pairs nicely with `ls` and `bat` for showing a preview window.

z.lua
: A fast and portable[^3] directory jumper that sorts by frecency.

[msync](https://github.com/Kansattica/msync)
: A store-and-forward client for Fediverse implementations that support the Mastodon API.

[wormhole-william](https://github.com/psanford/wormhole-william)
: Re-implementation of the Magic-Wormhole protocol in Go. The ability to build it as a statically-linked binary makes installing it on all my machines and servers easier, for situations when `rsync` isn't ideal.

[rdrview](https://github.com/eafer/rdrview)
: The Readability algorithm on the command-line. Pairs nicely with Pandoc and/or w3m to extract and manipulate article content.

[Efficient Compression Tool](https://github.com/fhanau/Efficient-Compression-Tool)
: The last word in optimizing gzip or PNG size. Runs circles around ZopfliPNG, oxipng, etc.

[RustScan](https://github.com/RustScan/RustScan)
: A port-scanner that can scan all 65&nbsp;thousand ports in seconds. Don't use it on someone else's server without permission; this thing is brutal.

[scc](https://github.com/boyter/scc)
: Super fast SLOC alternative that shows statistics on code complexity by language.

Pandoc
: Swiss-army chainsaw of document format conversion. Makes writing LaTeX and converting between markup formats much easier. A really big/heavy tool, though; compiling it can take forever and uses a ton of RAM.

bmake
: Much simpler than GNU Make, and good for ensuring that Makefiles are portable.

This website
------------

I use multiple aforementioned tools (Neovim, bmake, sd) for routine tasks when building seirdy.one.

### Make content


Neovim
: My `$EDITOR` for everything, as mentioned before.

ImageMagick
: Inverts images for dark mode, crops them, and switches their color palettes to grayscale when appropriate. I've been considering switching from ImageMagick to [libvips](https://www.libvips.org/); it seems much better.

pngquant, Efficient Compression Tool
: Optimize the size of PNGs using dithering (pngqunat) and lossless ZopfliPNG-like compression (Efficient Compression Tool)

`cwebp`
: I make lossless WebP images from dithered PNGs.

`avifenc`
: Comes with libavif. I use it with libaom to encode AVIF images with lossy compression. I also link libaom against libjxl so that I can get Butteraugli-based quality tuning.

### Deploy the website


[Hugo](https://gohugo.io/)
: Fast static-site generator with a very advanced templating language. Supports nested shortcodes, deserializing remote data, and defining custom output formats.

`xmllint`
: Ensures all XHTML is well-formed, and auto-formats it (with some help from sd). Comes with libxml2.

Efficient Compression Tool, Brotli
: These perform static compression at max settings[^4] for all static content. Reduces payload size and saves server CPU resources.

rsync
: Transfers files to the server

[builds.sr.ht](https://builds.sr.ht/)
: <abbr title="Continuous Integration/Continuous Delivery">CI/CD</abbr> service that has nice features. Production site builds occur in an Alpine VM on builds.sr.ht. Features I like include letting me ssh into failed builds, having an accessible Web UI, and not requiring any JavaScript.

### Test the website

I don't run these utilities every push; they're too heavy for that. I do run them often, though.

I run these tools locally, on every applicable file. A full run takes under <time datetime="PT2M">2 minutes</time>.


[Nu HTML Checker](https://validator.github.io/validator/)
: A Java utility (eww) to validate all my HTML, SVG, and CSS content. I [filter false-positives with a jq script](https://git.sr.ht/~seirdy/seirdy.one/tree/master/item/linter-configs/vnu_filter.jq) after reporting them upstream.

[stylelint](https://github.com/stylelint/stylelint)
: CSS linter that checks for problems like descending specificity or complex selectors.

[axe-core](https://github.com/dequelabs/axe-core)
: I use the axe-core CLI to check every page on my sitemap for accessibility violations. Good for low-hanging fruit; I still do manual testing, of course.

[IBM Equal Access accessibility-checker](https://github.com/IBMa/equal-access/blob/master/accessibility-checker/README.md)
: I use this just like axe-core: as a CLI utility to check every page on my sitemap for basic accessibility violations. I disable "potential-violations" checks because those have false-positives.

jq
: I use jq to ensure that all my JSON is valid. This includes my Web App Manifest file and Webfinger JSON. I also use jq to filter out false positives from the Nu HTML Checker.

[Feed Validator](https://github.com/w3c/feedvalidator)
: I validate my Atom feeds using this tool. Like always, I filter out false positives and report them upstream.

[htmltest](https://github.com/wjdp/htmltest) OR [html-proofer](https://github.com/gjtorikian/html-proofer)
: Two very similar tools. html-proofer is slow but supports more features; I run the faster htmltest more often. They check for broken links, markup errors, and valid icons.

[webhint](https://webhint.io)
: When all the aforementioned tests pass, my staging site deploys and webhint runs on every page in its sitemap. I skip its axe-based tests, since those are already covered by axe-core.

  Webhint checks HTTP headers, validates the Web App Manifest, ensures caching and compression work, checks for compatibility issues, validates compliance with a performance budget, and looks for common HTML/CSS mistakes.

Tools I have yet to add to this section:

* Something to validate my Webfinger JSON against a schema
* A tool to validate microdata and RDFa. structured-data-linter or Schemarama could work.
* A tool to validate microformats.

### Server-side stuff

All my server daemons are statically-linked binaries, which makes sandboxing easier.


Nginx
: Specifically, [nginx-quic.](https://quic.nginx.org/) with the [headers_more](https://github.com/openresty/headers-more-nginx-module) and [ngx_brotli](https://github.com/google/ngx_brotli) modules. Statically linked against zlib-ng, BoringSSL, and musl libc; patched for dynamic TLS records, basic OCSP support, and HPACK compression.

[certbot-ocsp-fetcher](https://github.com/tomwassenberg/certbot-ocsp-fetcher)
: Shell script to manage the OCSP cache for Nginx, since Nginx's own implementation is lacking (and completely non-existent if you build with BoringSSL)

[nginx-rotate-session-ticket-keys](https://github.com/GrapheneOS/nginx-rotate-session-ticket-keys)
: Shell script to manage TLS session tickets, since Nginx's own implementation is really flawed. This replaces its default stateful session cache and also allows 0-RTT (also known as "early data") for idempotent requests. I patched it to use my statically-linked build of BoringSSL (I already had it sitting around after building it for Nginx).

[webmentiond](https://webmentiond.org/)
: Lightweight Webmention receiver.

Agate
: Gemini server. Considering replacing this with a server that doesn't do TLS, and using Nginx with the Stream module as a reverse proxy that adds TLS.

[searchmysite-go](https://git.sr.ht/~seirdy/searchmysite-go)
: Quick program I put together to make the front-end for this site's search page.

[Conduit](https://conduit.rs/)
: Faster and more lightweight Matrix server in a single binary.

What I don't use
----------------

These are tools that I don't use, or avoid using.

* System monitoring TUIs: I just run the appropriate command to view the resource I need to know about.
* File managers: I prefer using the shell with fzf-based tab-completion that also features preview windows.
* Docker. I use Podman for disposable pet development environments, but I never use containers to run things on the server (except as a temporary learning exercise).


[^1]: Honestly: I think upstream abandonment would be less of an issue if hardware vendors made new releases half as often, and had half the models to support.

[^2]: Adding `.patch` to the end of any PR URL on most forges will give you a raw patch file; you can send it to `curl` and pipe the output into `git am` without having to mess with remotes.

[^3]: z.lua runs anywhere Lua runs.

[^4]: Well, I use `-9` for Efficient Compression Tool which is its highest predefined setting. I don't use its advanced 6-digit syntax for static compression; that would be overkill.



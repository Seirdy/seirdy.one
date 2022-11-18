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

My main computer is a 2013 HP Elitebook 840 G1. It has a dual-core Intel i5-4300U CPU (Haswell), with simultaneous multithreading disabled.

Environment
-----------


Fedora 36
: Primary OS. Uses Linux, Systemd, GNU libc, GNU coreutils, dnf, firewalld, and SELinux.

Sway
: Dynamic Wayland compositor that focuses on tiling window management but also supports tabbed and stacking layouts.

Zsh
: Login shell. POSIX-compatible and mostly Bash-compatible. Custom static build to skip checking system files and improve startup performance.

DASH
: Minimal POSIX-compatible shell that I use for non-interactive purposes (e.g. shell scripts). When statically-linked, its startup time is negligible even on the most underpowered hardware. This is really important to me, since many of my most-used commands are shell-script wrappers that I expect to run in a few milliseconds.

Foot
: Primary terminal emulator. Sometimes I use gnome-terminal when I'm using a screen reader.

Basic utilities
---------------


Neovim
: My `$EDITOR` of choice. Supports tree-sitter, uses lua configuration, and has a client for the Language Server Protocol (I only use the gopls, rust-analyzer, and ccls language servers)

ripgrep
: grep alternative that supports multiline regexes, PCRE2, and searching compressed files. Often faster, too.

[sd](https://github.com/chmln/sd)
: For better and faster multi-line regex manipulation than `sed`.

[fd](https://github.com/sharkdp/fd)
: Better parallel execution than `find -exec`. I still use `find` in many situations, though.

mpd
: My music player daemon, paired with [my mpd scripts](https://sr.ht/~seirdy/mpd-scripts/) and [mpd-mpris](https://github.com/natsukagami/mpd-mpris).

mpv
: My video player. I have three builds of mpv: one normal build, and two with decoder libraries that have profile-guided optimization for different types of video (anime, and live-action that includes heavy filmgrain). Often paired with [yt-dlp](#yt-dlp) and [mpv_sponsorblock](https://github.com/po5/mpv_sponsorblock).
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

Networking and penetration testing
----------------------------------

Every administrator needs some tools to test their servers.


[RustScan](https://rustscan.github.io/RustScan/)
: A port-scanner that can scan all 65&nbsp;thousand ports in _seconds_. It optionally integrates with nmap. Don't use it on someone else's server without permission; this thing is brutal.

[q (DNS client)](https://github.com/natesales/q)
: A DNS client that supports DNS-over-TLS, DNS-over-HTTPS, DNS-over-HTTP/3, DNS-over-QUIC, and Oblivious DNS-over-HTTPS. It sports a wide variety of options that aren't present in other `dig` replacements.

[rnp](https://github.com/r12f/rnp)
: A "layer-4 ping tool" that can measure the round-trip time of a plain TCP or QUIC connection, rather than using ICMP.

[cURL](https://curl.se/) OR [xh](https://github.com/ducaale/xh)
: cURL supports a wide variety of features, protocols, TLS libraries, etc. `xh` is more focused on HTTP. I like to use both; when I don't need the features of cURL, I use xh for its simple color output and HTTPie-like syntax. Plus, it's nice to be able to test a server with two different HTTP+TLS implementations.

[wrk2 (fork)](https://github.com/kinvolk/wrk2) OR [bombardier](https://github.com/codesenberg/bombardier)
: Two great HTTP load-testers. wrk2 is mostly abandoned, but this fork has since added some features. When I need to test something like HTTP/2, I reach for bombardier. I haven't yet evaluated different HTTP/3 load-testers; I might have to give h2load+nghttp3 a look.

[ssh-audit](https://github.com/jtesta/ssh-audit)
: I check my SSH config against [this SSH policy](../ssh-policy.txt). It's based on the GrapheneOS infrastructure's SSH configs.

Other tools
-----------

Everyday utilities I can't live without:


jq
: Interpreter for the jq domain-specific programming language. Indispensable for creating, manipulating, and filtering data.

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
: The last word in optimizing gzip or PNG size. Runs circles around Zopfli, ZopfliPNG, oxipng, etc. I use it in combination with `brotli` to compress all static text and PNGs on this site.

[zpaqfranz](https://github.com/fcorbelli/zpaqfranz)
: I use this for my long-term backups. `zpaq` is a journaling archiver, which allows me to compress backup deltas without having to use a journaling filesystem. `zpaqfranz` adds several features related to integrity-checking. The compression ratios are ridiculously good, even without the journaling; it beats every other realistic option, especially when combined with pre-processing offered by [lrzip-next](https://github.com/pete4abw/lrzip-next).

[p7zip](https://p7zip.sourceforge.net/)
: POSIX port of 7-zip. Using it with `m0=PPMd` often yields much better compression ratios than LZMA/LZMA2 on plain-text content while being much faster than zpaqfranz.

[scc](https://github.com/boyter/scc)
: Super fast SLOC alternative that shows statistics on code complexity by language.

Pandoc
: Swiss-army chainsaw of document format conversion. Makes writing LaTeX and converting between markup formats much easier. A really big/heavy tool, though; compiling it can take forever and uses a ton of RAM.

bmake
: Much simpler than GNU Make, and good for ensuring that Makefiles are portable.

[ghq](https://github.com/x-motemen/ghq)
: A tool to manage version-control clones (Git, Mercurial, et al) in the style of `$GOPATH`. I have hundreds of repositories cloned from several different remotes, and this takes care of organizing them in my filesystem.

<a href="https://github.com/yt-dlp" id="yt-dlp">yt-dlp</a>
: Download videos from hundreds of different sites, including YouTube. Integrates with external downloaders like aria2 and downloads DASH chunks in parallel to max out your connection speed. yt-dlp also integrates with Sponsorblock to add skippable chapters for the segments I'd otherwise have to manually skip (sponsored content, subscription-begging, an ending segment featuring other videos, and other useless bullshit). I've forgotten what it's like to watch a video ad.

This website
------------

I use multiple aforementioned tools (Neovim, bmake, sd, etc.) for routine tasks when building seirdy.one.

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

`cjxl`
: The reference JPEG-XL encoder. JPEG-XL won't be enabled-by-default in browsers for a while, but I still offer it via some `<picture>` elements.

### Deploy the website


[Hugo](https://gohugo.io/)
: Fast static-site generator with a very advanced templating language. Supports nested shortcodes, deserializing remote data, and defining custom output formats.

`xmllint`
: Ensures all XHTML is well-formed, and auto-formats it (with some help from sd). Comes with libxml2.

Efficient Compression Tool, Brotli
: These perform static compression at max settings[^4] for all static content. Reduces payload size and saves server CPU resources.

rsync
: Transfers modified files to the server with transparent zstd compression.

[builds.sr.ht](https://builds.sr.ht/)
: <abbr title="Continuous Integration/Continuous Delivery">CI/CD</abbr> service. Production site builds occur in an Alpine VM on builds.sr.ht. Features I like include letting me ssh into failed builds, having an accessible Web UI, and not requiring any JavaScript. I bring most of my own binaries and use portable Makefiles and shell-scripts, so I could easily migrate to another offering if necessary.

### Test the website

I don't run these utilities every push; they're too heavy for that. I do run them often, though.

I run these tools locally, on every applicable file. A full run takes under <time datetime="PT6M">6 minutes</time> on my modest dual-core notebook.


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
: Two very similar tools. html-proofer is slow but supports more features; I run the faster htmltest more often. They check for broken links, markup errors, and valid icons. htmltest's ability to cache links is really useful: instead of testing nearly two thousand links every run, I can spread the load over the course of a week. It's also much easier to build a static binary of htmltest than other link-checkers, like Lychee.

[webhint](https://webhint.io/)
: When all the aforementioned tests pass, my staging site deploys and webhint runs on every page in its sitemap. Webhint checks HTTP headers, validates the Web App Manifest, ensures caching and compression work, checks for compatibility issues, validates compliance with a performance budget, and looks for common HTML/CSS mistakes. I skip its axe-based tests, since those are already covered by axe-core.

Tools I have yet to add to this section:

* Something to validate my Webfinger JSON against a schema
* A tool to validate microdata and RDFa. The W3C structured-data-linter or Google's Schemarama could work.
* A tool to validate microformats.

### Server-side stuff

All my server daemons are statically-linked binaries, which makes sandboxing easier.


Nginx
: Specifically, [nginx-quic](https://quic.nginx.org/) with the [headers_more](https://github.com/openresty/headers-more-nginx-module) and [ngx_brotli](https://github.com/google/ngx_brotli) modules. Statically linked against zlib-ng, BoringSSL, PCRE2 (non-JIT), and musl libc; patched for dynamic TLS records, basic OCSP support, larger buffers for dynamic zlib compression (necessary for zlib-ng), and static HPACK compression. I recommend most people use Caddy instead of Nginx. The only benefits of Nginx are certain modules providing application-server capabilities, the ability to re-load all configs with zero downtime, and better performance on limited hardware (although most sites won't need to handle more than a few hundred requests per second, which Caddy can handle perfectly well).

[certbot-ocsp-fetcher](https://github.com/tomwassenberg/certbot-ocsp-fetcher)
: Shell script to manage the OCSP cache for Nginx, since Nginx's own implementation shouldn't be used without running a trusted resolver (and is completely non-existent if you build with BoringSSL).

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

Services
--------

I generally try to limit my dependence on services, preferring to run software myself. I do make a few compromises.


[Migadu](https://www.migadu.com)
: Managed email hosting for seirdy.one. Running my own mail server and keeping my IP approved by all the entrenched players isn't worth the effort, especially if I ever choose to run something like a Tor exit node in the future. Migadu also offers an API, which I use to generate and list email aliases on the fly. My only gripes are that they still support TLS 1.1 and 1.0 for some reason, and that they don't yet support any open IMAP extensions that allow 2FA.

[deSEC](https://desec.io/)
: Managed DNS name servers. I could run something like PowerDNS or TrustDNS myself, but I'd need to use separate IPs (and ideally a separate server or two) for redundancy. I wanna keep seirdy.one cheap to host, and deSEC was free. It offered DNSSEC along with nice record types like SSHFP, HTTPS/SVCB, and OPENPGPKEY. OPENPGPKEY and SSHFP are especially useful, since keys distribution should have multiple distribution mechanisms with different sources of trust when manual verification isn't ideal.

[Namecheap](https://www.namecheap.com/)
: Domain registrar. I do not endorse Namecheap. I initially picked it since it ticked the right boxes: Whois privacy, domain locking, DNSSEC, custom name servers, decent support, and good prices. Porkbun and Gandi are other options that tick these boxes.

[Digital Ocean](https://www.digitalocean.com)
: My VPS provider. I do not endorse Digital Ocean for most peoples' needs. It's far pricier than equivalent options, and is only worth that price if you need top-tier support and a very good SLA. That being said, it does offer a lot of free credits ($100 if you sign up with someone's referral code; another $100 if you're a student); I started using Digital Ocean for the free credits. Scaleway and BuyVM are much better options if you want to go cheap. If I ever manage to get my hands on a home internet connection with excellent uptime, I might switch to self-hosting.

What I don't use
----------------

These are tools that I don't use, or avoid using.

* System monitoring TUIs: I usually just run the appropriate command to view the resource I need to know about.
* File managers: I prefer using the shell with fzf-based tab-completion that also features preview windows.
* Docker. I use Podman for disposable pet development environments, but I never use containers to run things on the server (except as a temporary learning exercise).


[^1]: Honestly: I think upstream abandonment would be less of an issue if hardware vendors made new releases half as often, and had half the models to support.

[^2]: Adding `.patch` to the end of any PR URL on most forges will give you a raw patch file; you can send it to `curl` and pipe the output into `git am` without having to mess with remotes.

[^3]: z.lua runs anywhere Lua runs.

[^4]: Well, I use `-9` for Efficient Compression Tool which is its highest predefined setting. I don't use its advanced 6-digit syntax for static compression; that would be overkill.



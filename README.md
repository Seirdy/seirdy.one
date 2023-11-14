seirdy.one
==========

[![sourcehut](https://img.shields.io/badge/repository-sourcehut-lightgrey.svg?logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZlcnNpb249IjEuMSINCiAgICB3aWR0aD0iMTI4IiBoZWlnaHQ9IjEyOCI+DQogIDxkZWZzPg0KICAgIDxmaWx0ZXIgaWQ9InNoYWRvdyIgeD0iLTEwJSIgeT0iLTEwJSIgd2lkdGg9IjEyNSUiIGhlaWdodD0iMTI1JSI+DQogICAgICA8ZmVEcm9wU2hhZG93IGR4PSIwIiBkeT0iMCIgc3RkRGV2aWF0aW9uPSIxLjUiDQogICAgICAgIGZsb29kLWNvbG9yPSJibGFjayIgLz4NCiAgICA8L2ZpbHRlcj4NCiAgICA8ZmlsdGVyIGlkPSJ0ZXh0LXNoYWRvdyIgeD0iLTEwJSIgeT0iLTEwJSIgd2lkdGg9IjEyNSUiIGhlaWdodD0iMTI1JSI+DQogICAgICA8ZmVEcm9wU2hhZG93IGR4PSIwIiBkeT0iMCIgc3RkRGV2aWF0aW9uPSIxLjUiDQogICAgICAgIGZsb29kLWNvbG9yPSIjQUFBIiAvPg0KICAgIDwvZmlsdGVyPg0KICA8L2RlZnM+DQogIDxjaXJjbGUgY3g9IjUwJSIgY3k9IjUwJSIgcj0iMzglIiBzdHJva2U9IndoaXRlIiBzdHJva2Utd2lkdGg9IjQlIg0KICAgIGZpbGw9Im5vbmUiIGZpbHRlcj0idXJsKCNzaGFkb3cpIiAvPg0KICA8Y2lyY2xlIGN4PSI1MCUiIGN5PSI1MCUiIHI9IjM4JSIgc3Ryb2tlPSJ3aGl0ZSIgc3Ryb2tlLXdpZHRoPSI0JSINCiAgICBmaWxsPSJub25lIiBmaWx0ZXI9InVybCgjc2hhZG93KSIgLz4NCjwvc3ZnPg0KCg==)](https://sr.ht/~seirdy/seirdy.one) [![GitLab mirror](https://img.shields.io/badge/mirror-GitLab-orange.svg?logo=gitlab)](https://gitlab.com/Seirdy/seirdy.one) [![GitHub mirror](https://img.shields.io/badge/mirror-GitHub-black.svg?logo=github)](https://github.com/Seirdy/seirdy.one) [![Codeberg mirror](https://img.shields.io/badge/mirror-Codeberg-blue.svg?logo=codeberg)](https://codeberg.org/Seirdy/seirdy.one)

[![builds.sr.ht status](https://builds.sr.ht/~seirdy/seirdy.one.svg)](https://builds.sr.ht/~seirdy/seirdy.one)

Code for my personal website, [seirdy.one](https://seirdy.one). Built with Hugo.

Also builds my Gemini capsule: <gemini://seirdy.one/>.

Dependencies
------------

To build:

- Hugo 0.93 or later
- bmake or GNU Make. OpenBSD make (omake) should work too, but I haven't tested it.
- Git (Hugo uses Git info for features like date last updated)
- [htmlq](https://github.com/mgdm/htmlq), to parse HTML when fetching some webring links and for some post-processing.
- POSIX utils: `grep`, `find`, POSIX-compliant `/bin/sh`, etc.

Before deploying, I use some tools to process the output.

- `xmllint`, part of libxml2, to format the generated polygot XHTML5 markup.
- [sd](https://github.com/chmln/sdA) (for advanced multi-line regex operations, much of which exist to fix `xmllint`'s output)
- a patched version of html-tidy

I also apply static compression at max levels, using the following tools:

- [Efficient Compression Tool](https://github.com/fhanau/Efficient-Compression-Tool) It's like zopfli but more efficient and faster.
- Brotli

To deploy:

- rsync, with SSH and zstd support

To lint:

- stylelint, invoked using pnpm.
- [lychee](https://github.com/lycheeverse/lychee), to check broken links.
- A very recent build of the w3c's [Nu HTML checker](https://github.com/validator/validator) to validate the HTML and XHTML.
- [jq](https://stedolan.github.io/jq/), to filter false-positives from the Nu HTML checker.

Build instructions
------------------

- To just build the HTML: `make hugo`
- To build the polygot formatted HTML and XHTML: `make hugo xhtmlize`
- To lint and validate: `make hugo xhtmlize lint-local`
- To build everything and compress: `make hugo xhtmlize compress`
- To deploy the clearnet site and corresponding Tor hidden service: `make deploy-prod deploy-onion`

`make` can parallelize only a little, since many jobs depend on previous jobs.

Compatibility
-------------

I made the site as inclusive as possible. Tested using multiple screen readers (Orca, TalkBack, Apple VoiceOver, Windows Narrator, NVDA), and I regularly test with the following browsers/engines. Testing in a browser does not imply any sort of endorsement; I just want to meet people where they're at and I want my site to be as robust as possible.

For all the listed options, I test "reading mode" whenever it's available. Most of my testing happens on Linux since that's my main OS, but I sometimes test on a Windows machine.

The main compatibility issue is a lack of support for `<details>`; the only non-mainstream engine to support it is Servo. The site is still perfectly usable without support for `<details>`; users will just be annoyed by pre-expanded toggle buttons that don't do anything.

### Desktop

Mainstream engines:

- Gecko: Nightly, Stable, ESR, and sometimes Pale Moon
- the Tor Browser
- Blink: latest Chromium snapshot, stable, and QtWebEngine
- WebKit, via Webkit2GTK3

Non-mainstream engines:

- NetSurf
- [The SerenityOS Browser](https://github.com/SerenityOS/serenity/tree/master/Userland/Libraries/LibWeb) (does not yet support ECDSA-based certs, so I test on my Tildeverse mirror). Known issue: SVG avatar doesn't render unless I view it in a new tab.
- Very old WebKit via rekonq (Qt4 QtWebKit).
- KHTML (KF5), via Konqueror.
- Servo
- Tkhtml, via Hv3 (no TLS 1.2, so I use a terminating proxy or localhost version)

Tested on a provisional basis, when I have access to a Windows machine:

- [Winternight Classic](https://github.com/ClassicNick/Crescent-Vine).
- IE 11.
- Even older WebKit, via Safari 5.1.7. Requires a TLS terminating proxy.
- Ancient Gecko, via NetScape Navigator. Requires a TLS terminating proxy.

Desktop screen readers tested:

- Orca
- NVDA
- Windows Narrator
- TODO: borrow someone's mac and test macOS VoiceOver.

### Mobile

- Android: Blink, Gecko, Tor Browser
- iOS WebKit: latest stable version, iOS 12, iOS 10 on an iPhone 5. Also tested Reader Mode.
- TODO: try a KaiOS device and Samsung Internet's dark mode.

The site should work well even on viewports that are under 240 CSS pixels wide.

Mobile screen readers:

- TalkBack
- VoiceOver
- TODO: test KaiOS Readout

### Smart watches

- Borrowed an Apple Watch to try the embedded browser.
- TODO: test on a Tizen or Wear OS device's browser (Samsung Internet is a popular choice)

## Accessibility

To my knowledge, this site meets all applicable WCAG 2.2 AA requirements.

This site meets all applicable WCAG 2.2 AAA requirements, with the following exceptions:

- SC 1.4.8 Visual Presentation: long article body text for articles should have an average character count per line below 80 characters. Some lines may exceed this limit. Text outside of article bodies has a longer line width.
- SC 2.4.9 Link Purpose (Link Only): I mostly follow this guideline, but there may be some exceptions. Link purpose in context is always clear, though.
- SC 3.1.5 Reading Level: the required reading ability often exceeds the lower secondary education level
- SC 3.1.6 Pronunciation: I do not yet provide pronunciation information.

I have only tested WCAG compliance in mainstream browser engines (Blink, Gecko, WebKit).

I also go further than WCAG in many aspects.

- Rather than follow SC 2.5.5's requirement to achieve a minimum tap target size of 44 by 44 pixels, I follow Google's more strict guidelines. These guidelines mandate that targets are at least 48-by-48 pixels, with no overlap against any other targets in a 56-by-56 pixel range.
- I ensure at least one such 56-by-56 pixel non-interactive region exists on the page, for users with hand tremors or or anyone who wants to tap the screen without clicking something.
- I only set custom colors in response to the `prefers-color-scheme: dark` media query. These custom colors pass APCA contrast ratios, all being close to the ideal lightness contrast of 90. They are also autism- and overstimulation-friendly colors: yellow links are significantly de-saturated to reduce harshness.

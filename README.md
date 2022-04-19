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
- Make
- Git (Hugo uses Git info for features like date last updated)
- [Efficient Compression Tool](https://github.com/fhanau/Efficient-Compression-Tool) It's like zopfli but more efficient and faster.
- Brotli (optional; set `NO_STATIC=1` to disable)
- POSIX utils: grep, find, etc.

To deploy:

- ssh
- rsync
- libzstd

To lint:

- stylelint
- csslint
- pnpm
- [lychee](https://github.com/lycheeverse/lychee)

See the `Makefile` for details.

Design
------

I made the site as inclusive as possible. Tested using multiple screen readers (Orca, TalkBack, Apple VoiceOver, Windows Narrator, NVDA), and I regularly test with the following browsers/engines. Testing in a browser does not imply any sort of endorsement; I just want to meet people where they're at.

Desktop:

- Gecko: Nightly, Stable, ESR, and sometimes Pale Moon
- the Tor Browser
- Blink: latest Chromium snapshot, stable, and QtWebEngine
- WebKit: Webkit2GTK3
- NetSurf
- SerenityOS Browser
- Very old WebKit via rekonq (Qt4 QtWebKit)
- KHTML
- Servo
- Trident, if I have access to a Windows machine that has Edge with "IE Mode".

For all the above options, I test "reading mode" whenever it's available.

Mobile:

- Android: Blink, Gecko, Tor Browser
- iOS WebKit: latest stable version, iOS 12, iOS 10 on an iPhone 5. Also test Reader Mode.
- TODO: try a KaiOS device.

Smart watches:

- Borrowed an Apple Watch to try the embedded browser.
- TODO: test on a Tizen or Wear OS device's browser.

Everything works well in all the above browsers.

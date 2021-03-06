seirdy.one
==========

[![sourcehut](https://img.shields.io/badge/repository-sourcehut-lightgrey.svg?logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZlcnNpb249IjEuMSINCiAgICB3aWR0aD0iMTI4IiBoZWlnaHQ9IjEyOCI+DQogIDxkZWZzPg0KICAgIDxmaWx0ZXIgaWQ9InNoYWRvdyIgeD0iLTEwJSIgeT0iLTEwJSIgd2lkdGg9IjEyNSUiIGhlaWdodD0iMTI1JSI+DQogICAgICA8ZmVEcm9wU2hhZG93IGR4PSIwIiBkeT0iMCIgc3RkRGV2aWF0aW9uPSIxLjUiDQogICAgICAgIGZsb29kLWNvbG9yPSJibGFjayIgLz4NCiAgICA8L2ZpbHRlcj4NCiAgICA8ZmlsdGVyIGlkPSJ0ZXh0LXNoYWRvdyIgeD0iLTEwJSIgeT0iLTEwJSIgd2lkdGg9IjEyNSUiIGhlaWdodD0iMTI1JSI+DQogICAgICA8ZmVEcm9wU2hhZG93IGR4PSIwIiBkeT0iMCIgc3RkRGV2aWF0aW9uPSIxLjUiDQogICAgICAgIGZsb29kLWNvbG9yPSIjQUFBIiAvPg0KICAgIDwvZmlsdGVyPg0KICA8L2RlZnM+DQogIDxjaXJjbGUgY3g9IjUwJSIgY3k9IjUwJSIgcj0iMzglIiBzdHJva2U9IndoaXRlIiBzdHJva2Utd2lkdGg9IjQlIg0KICAgIGZpbGw9Im5vbmUiIGZpbHRlcj0idXJsKCNzaGFkb3cpIiAvPg0KICA8Y2lyY2xlIGN4PSI1MCUiIGN5PSI1MCUiIHI9IjM4JSIgc3Ryb2tlPSJ3aGl0ZSIgc3Ryb2tlLXdpZHRoPSI0JSINCiAgICBmaWxsPSJub25lIiBmaWx0ZXI9InVybCgjc2hhZG93KSIgLz4NCjwvc3ZnPg0KCg==)](https://sr.ht/~seirdy/seirdy.one)
[![GitLab
mirror](https://img.shields.io/badge/mirror-GitLab-orange.svg?logo=gitlab)](https://gitlab.com/Seirdy/seirdy.one)
[![GitHub
mirror](https://img.shields.io/badge/mirror-GitHub-black.svg?logo=github)](https://github.com/Seirdy/seirdy.one)

[![builds.sr.ht
status](https://builds.sr.ht/~seirdy/seirdy.one.svg)](https://builds.sr.ht/~seirdy/seirdy.one)

Code for my personal website, [seirdy.one](https://seirdy.one). Built with Hugo.

Dependencies
------------

To build:

- Hugo 0.75 or later
- Make
- Git (Hugo uses Git info for features like date last updated)
- [Efficient Compression Tool](https://github.com/fhanau/Efficient-Compression-Tool)
  with patches from
  [MegaByte](https://github.com/MegaByte/Efficient-Compression-Tool/tree/iterations)
  (optional; set `NO_STATIC=1` to disable). It's like zopfli but more efficient and faster.
- Brotli (optional; set `NO_STATIC=1` to disable)
- POSIX utils: grep, find, etc.

To deploy:

- ssh
- rsync
- zstd

To lint:

- stylelint
- csslint
- [webhint CLI](https://github.com/webhintio/hint)
- [lychee](https://github.com/lycheeverse/lychee)

To test in CI, after deploying to the staging environment:

- webhint CLI
- [lighthouse-ci](https://github.com/GoogleChrome/lighthouse-ci)

CI also runs [static-webmention](https://github.com/nekr0z/static-webmentions) to
gather a list of WebMentions for me to send and review manually.

See the `Makefile` for details.

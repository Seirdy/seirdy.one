---
title: "Partial credit for CSS Naked Day"
date: 2024-04-09T00:00:01-04:00
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AghSP3X5WSt51T4cwC'
    - title: 'IndieNews'
      url: 'https://news.indieweb.org/en'
---

For [CSS Naked Day](https://css-naked-day.github.io/), I decided to do something a little different. I didn't want to actually disable my stylesheet: very long lines of small text aren't terribly accessible, and fingerprinting-averse readers of my Onion site may not wish to zoom in (I know for a fact that these people exist; I've spoken to them, and I don't like reducing my readers to numbers in an analytics dashboard).

Instead, I made CSS Naked Day participation opt-in with a new a query parameter to the URLs: Just add `?sandbox=broken` to the end of any URL on `seirdy.one`. This query parameter sets a maximally-restrictive Content-Security-Policy header, instructing your browser to block CSS, images, media, and more from loading. The only thing that the CSP will allow is submitting forms (Webmentions). See [my CSP Bug Reproduction page]({{<relref "/meta/csp-bug-reproduction/">}}) for other values you can give the `sandbox` parameter on `seirdy.one` and its Onion location.

This does not apply to mirrors of my site, such as the `envs.net` mirror.

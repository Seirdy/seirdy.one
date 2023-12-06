---
title: "Firefox focus ring regression"
date: 2023-10-31T05:11:06-07:00
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AbKRMDqztwWekHX4qG'
    - title: 'IndieNews'
      url: 'https://news.indieweb.org/en'
---
Firefox 120 appears to have regressed to its older WebKit-like blue focus outlines; it briefly had dual-color white-and-blue outlines.

I'd previously advised certain sites (sites with background colors that have poor contrast against the focus-ring's blue color) to override the default focus indicators. I planned to temper that advice since Chromium and Firefox adopted focus indicators that appeared visible on a variety of background colors; I suppose I should cancel those plans.

As long as people have to use defaults they didn't choose (e.g. Tor Browser users are stuck with default settings), we have to override them when they're inaccessible. We can't count on users to always have the means to do this: fingerprinting concerns and device-borrowing are facts of life.

<ins datetime="2023-12-06T05:53:35+00:00">Update <time datetime="2023-12-06T05:53:35+00:00">2023-12-06</time>: it appears that as of Firefox 121, the issue only appears in forced-colors mode (e.g. when toggling color overrides in the color settings of `about:preferences`). Input elements are unaffected. With forced-colors disabled, Firefox uses the better two-tone indicator.</ins>


---
title: "Targeting secure browser profiles"
date: 2023-08-28T19:10:31-07:00
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AZCzMm4B8YAIFBqXNw'
---
It's hard to target browsers' secure profiles. Safari's Lockdown Mode disables a dozen or so APIs and a handful of other features; the Tor Browser disables another handful of features; Microsoft Edge will likely land more changes to Enhanced Security mode in the coming years. Barely any of this is documented.

[I filed a bug in MDN's BCD tracker](https://github.com/mdn/browser-compat-data/issues/20619) to fill this gap, listing what I knew. We can't expect developers to navigate the dozens of WebKit blog posts and Tor Browser JSM files to figure out which features are disabled. Of course, progressive enhancement should be the norm, but it's helpful to have a real baseline.


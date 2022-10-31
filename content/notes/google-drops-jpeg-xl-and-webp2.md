---
title: "Google drops Webp2 and JPEG-XL"
date: 2022-10-31T09:57:27-07:00
---
Earlier this month, Google re-branded its WebP2 repository to clarify that [<q>WebP 2 will not be released as an image format.</q>](https://chromium.googlesource.com/codecs/libwebp2/+/1251ca748c17278961c0d0059b744595b35a4943%5E%21/). This week, Google [deprecated Chromium's off-by-default JPEG-XL support](https://bugzilla.mozilla.org/show_bug.cgi?id=jpeg-xl), citing a lack of interest and improvement over existing formats. Most commits to [libjxl](https://github.com/libjxl/libjxl), the reference JPEG-XL implementation, are from "google.com" email addresses; I imagine that this decision could impact libjxl development.

I doubt we'll be seeing new image formats on the Web for the next few years: there's [very incomplete JPEG-XL support in Firefox](https://bugzilla.mozilla.org/show_bug.cgi?id=jpeg-xl) and Safari only just got AVIF support

JPEG-XL and WebP2 would have been great for lossless compression. The best lossless compression we currently have is WebP-lossless, which doesn't support e.g. higher color depths. For that, we're stuck with PNG.

[POSSE](https://indieweb.org/POSSE) note from <https://seirdy.one/notes/2022/10/31/google-drops-jpeg-xl-and-webp2/>

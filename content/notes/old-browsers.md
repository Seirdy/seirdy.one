---
title: "Old browsers"
date: 2022-08-23T12:00:00-07:00
---

I added [a section on supporting older browsers]({{<relref "/posts/website-best-practices.md#old-browsers">}}) to my web best practices article.

I explain why old browsers are more prevalent than we think, and how to most easily support them.

I think the simplest way to do this well is to subset modern standards, not to explicitly use older standards. That is: we should target the subset of the HTML Living Standard that appears in e.g. HTML 5.1, so we get the important corrections in the Living Standard while still having a slower-moving target. Recent additions are totally fine if they're strictly-optional, progressive enhancements.

I think requiring a modern TLS cipher suite is fine (TLS 1.3 and the secure subset of TLS 1.2), since even 90s-era hardware can do TLS 1.3's ChaCha20-Poly1305 well enough. My personal rule of thumb is that if I support computers older than I am (22+ years old), I'm not contributing to planned obsolescence and consumerism in the hardware market.

I find a lot of overlap between supporting non-mainstream engines and supporting older browsers. Both benefit from ignoring new additions to the HTML Living Standard unrelated to accessibility, security, and performance. Catching up with a moving target is hard.

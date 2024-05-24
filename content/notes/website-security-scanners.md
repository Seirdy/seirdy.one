---
title: "Website security scanners"
date: 2022-11-02T11:56:02-07:00
replyURI: "https://pleroma.envs.net/notice/APB6Va7FFvgXN801L6"
replyTitle: "why does hardenize still check for Expect-CT when the header is deprecated"
replyType: "SocialMediaPosting"
replyAuthor: "r3g_5z"
replyAuthorURI: "https://girlboss.ceo/"
lastMod: 2022-11-26T19:20:46Z
---

Speaking generally: I think most website security scanners (Webbkoll, Observatory, et al) lend themselves to cargo-cults. You don't need [most Content Security Policy directives](https://w3c.github.io/webappsec-csp/#csp-directives) for a PNG file, for instance. Warning against a missing `X-Frame-Options` feels wrong: even the latest version of iOS 9---the oldest iOS release to support secure TLS 1.2 <abbr>ECDSA</abbr> ciphers---seems to support `frame-ancestors` (correct me if I'm wrong).

[Internet.nl](https://internet.nl/) is a bit better: it doesn't penalize you for not using security headers. Instead, it just educates you about why you should consider them. Internet.nl only penalizes you for lacking features that universally apply, like proper TLS. I also like the approach of [ssh-audit](https://github.com/jtesta/ssh-audit): it lets you set a policy that works for your endpoint, and validate against that policy.

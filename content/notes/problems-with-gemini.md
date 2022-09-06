---
title: "Problems with Gemini"
date: 2022-09-05T21:43:11-07:00
replyURI: "https://nya.social/notes/818310555359e1292a5f9b15"
replyTitle: "Hey what if we remade Gopher but closed it off to older machines by forcing usage of TLS?"
replyType: "SocialMediaPosting"
replyAuthor: "@allison@nya.social"
replyAuthorURI: "https://nya.social/@allison"
---
You can [run TLS 1.2 and 1.3 on plenty of 90s-era setups](https://oldvcr.blogspot.com/2022/07/crypto-ancienne-20-now-brings-tls-13-to.html). A typical Gemini page is small, so you might have to blink twice while ChaCha-POLY1305 does its thing. TLS might exclude retro servers, but not clients.

If Gemini had these changes, I'd be happy:

- Use something better than TOFU-based TLS for transit encryption (Tor, Yggdrasil, DANE-based-TLS, etc.)

- If using TLS: use a small subset of TLS 1.3. Maybe just stick to ECDSA + ChaCha-POLY1305.

- Drop ASCII art: overloading programming-language indicators and ASCII-art alt-text is an accessibility hazard

- Add some sort of "download finished without aborting early" indicator (e.g. something like Content-Length)

- Add some way to reliably work with a larger page, e.g. using compression or range-requests with pagination. My full-text Atom feed is almost 1&nbsp;mb uncompressed, but under 200&nbsp;kb with Brotli compression. Downloading a full-text export of my Gemini capsule without a content-length header or compression sounds bad.

The main thing I like about Gemtext is links on their own lines. This gets people to use longer/descriptive link text and also makes them serve as navigational aids better than their HTML counterparts.

Honestly, I'm less interested in the technology than the community. Gemini Space is a comfy change of pace.

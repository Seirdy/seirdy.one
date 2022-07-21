---
title: "DoH in Android"
date: 2022-07-20T19:46:29-07:00
replyURI: "https://vulpine.club/@KitRedgrave/108682844888729785"
replyTitle: "Thread on concerns about DoH in Android"
replyType: "SocialMediaPosting"
replyAuthor: "vx. redgrave"
replyAuthorURI: "https://vulpine.club/@KitRedgrave"
---
IMO: the main benefit of DNS-over-HTTPS (DoH) is that it's a stepping stone to [Oblivious DNS over HTTPS (RFC 9230)](https://www.rfc-editor.org/rfc/rfc9230.html).

> i distrust how much more this encourages centralization

I don't see how it's more centralized than DNS-over-TLS (DoT). On the client side, QUIC is already present on just about every Android phone.

On the server side: I don't think this update forces you to use any given provider, nor does it remove DoT. The default provider is whatever your phone vendor puts in (otherwise the default is Google DNS, just like before). They're even adding DDR so you can switch to DoT if your preferred resolver doesn't support DoH.


---
title: "Re: Privacy Guides email security"
date: 2022-10-20T00:35:50-07:00
replyURI: "https://www.privacyguides.org/en/basics/email-security/"
replyTitle: "Email Security"
replyType: "TechArticle"
replyAuthor: "Privacy Guides"
replyAuthorType: "Organization"
replyAuthorURI: "https://www.privacyguides.org/"
---
Key management guides should also cover key distribution.

Secure distribution happens over at least two bands with two different sources of trust. Having my own domain name lets me combine DANE (trust the DNS trust anchors) and Web Key Directory (trust the WebPKI and CA system). Clients can fetch keys both ways and ensure they match. Prospective senders may also request public keys over modern encrypted messengers.

This guide covers the client side. Users need providers and name servers to adopt email security standards (DKIM, SPF, DMARC, ARC, DANE, MTA-STS).


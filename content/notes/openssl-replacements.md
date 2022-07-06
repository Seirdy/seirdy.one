---
title: "OpenSSL replacements"
date: 2022-07-06T09:31:42-07:00
replyURI: "https://social.treehouse.systems/@ariadne/108601160601729437"
replyTitle: "I am going to…write an OpenSSL wrapper for BearSSL and just make OpenSSL die in Alpine entirely"
replyType: "https://schema.org/SocialMediaPosting"
replyAuthor: "Ariadne Conill"
replyAuthorURI: "https://ariadne.space"
---
Are you referring to making an OpenSSL-compatible API, so OpenSSL-only programs can link against BearSSL?

I really like BearSSL for TLS 1.2: it's tiny, runs well on old hardware, and has no dynamic memory allocation. I do have serious doubts for making it the default TLS library when it doesn't support TLS 1.3. Looking at commit logs, I doubt it'll get 1.3 anytime soon.

mbedTLS, LibreSSL, WolfSSL, s2n-tls, MatrixSSL, GnuTLS (eww), BoringSSL, picotls, NSS, even Fizz and Rustls (just including these two for completeness) all support 1.3 and can be linked in C programs; picking the one high-profile implementation lacking it seems like a bad idea. Perhaps wrapping BearSSL and a TLS 1.3 implementation (like picotls) could work?

Personally, I'd like to see adoption of more 1.3 extensions to reduce information leakage, such as Encrypted Client Hello or random padding.


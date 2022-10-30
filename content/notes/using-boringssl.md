---
title: "Using BoringSSL"
date: 2022-10-30T13:10:29-07:00
replyURI: "https://lobste.rs/s/9eas9d/you_should_prepare_for_openssl_3_x_secvuln#c_sk5f3v"
replyTitle: "“BoringSSL…is not intended for general use”"
replyType: "Comment"
replyAuthor: "AJ Jordan"
replyAuthorURI: "https://strugee.net/"
---

Despite BoringSSL's "not intended for general use" warning, it's used by many projects:

- The "ring" rust crate's crypto primitives (used by Rustls)
- Cloudflare: used everywhere, including Quiche.
- Apple's Secure Transport (it's in both major mobile OSes!)
- Optionally: Nginx, libcurl

I use nginx-quic with BoringSSL without issue, although I did have to use [a separate script](https://github.com/tomwassenberg/certbot-ocsp-fetcher) to manage the OCSP cache. The script manages the cache better than Nginx ever did, so I recommend it; it should be trivial to switch it from OpenSSL to LibreSSL.

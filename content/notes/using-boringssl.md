---
title: "Using BoringSSL"
date: 2022-10-30T13:10:29-07:00
lastMod: 2023-05-27T03:57:41Z
replyURI: "https://lobste.rs/comments/sk5f3v/reply"
replyTitle: "“BoringSSL…is not intended for general use”"
replyType: "Comment"
replyAuthor: "AJ Jordan"
replyAuthorURI: "https://strugee.net/"
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AUjf1wCr0xk0yCVpKK'
    - title: 'Lobsters'
      url: 'https://lobste.rs/comments/lreowa/reply'
---

Despite BoringSSL's "not intended for general use" warning, it's used by many projects:

- The "ring" rust crate's crypto primitives (used by Rustls)
- Cloudflare: used everywhere, including Quiche.
- Apple's Secure Transport (it's in both major mobile OSes!)
- Optionally: Nginx, libcurl
- <ins datetime="2023-04-24">(Update <time>2023-04-24</time>) [Apple's SwiftNIO SSL](https://github.com/apple/swift-nio-ssl)</ins>
- <ins datetime="2023-04-24">(Update <time>2023-04-24</time>) [AWS libcrypto](https://github.com/aws/aws-lc) is based on BoringSSL</ins>
- <ins datetime="2023-05-26">(Update <time>2023-05-26</time>) the Envoy proxy [uses BoringSSL](https://www.envoyproxy.io/docs/envoy/latest/faq/build/boringssl)</ins>

I use nginx-quic with BoringSSL without issue, although I did have to use [a separate script](https://github.com/tomwassenberg/certbot-ocsp-fetcher) to manage the OCSP cache. The script manages the cache better than Nginx ever did, so I recommend it; it should be trivial to switch it from OpenSSL to LibreSSL.

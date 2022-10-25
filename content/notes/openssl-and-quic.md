---
title: "OpenSSL and QUIC"
date: 2022-10-24T18:01:26-07:00
---
A rough timeline of QUIC support in OpenSSL-like libraries:

1. BoringSSL implements QUIC.

2. Quiche, a QUIC library, requires BoringSSL. Nginx can be patched to use Quiche for HTTP/3.

3. Nginx's experimental QUIC branch (nginx-quic) is released. It requires BoringSSL.

4. Some organizations (mostly Akamai) fork OpenSSL to implement the BoringSSL QUIC API, calling their fork QuicTLS. They plan to upstream changes.

5. nginx-quic supports building with QuicTLS too.

6. [OpenSSL decides against the BoringSSL API](https://daniel.haxx.se/blog/2021/10/25/the-quic-api-openssl-will-not-provide/) and declines QuicTLS patches, preferring to write their own incompatible implementation.

7. LibreSSL implements the BoringSSL QUIC API.

8. [nginx-quic can link against LibreSSL](https://hg.nginx.org/nginx-quic/rev/79cd6993a3e3) as well as BoringSSL and QuicTLS; they all use similar APIs.

(I _believe_ wolfSSL is mostly compatible with the BoringSSL QUIC API, but I might be wrong.)

Developers will have a harder time supporting multiple TLS implementations, hurting the viability of e.g. LibreSSL-based distributions.


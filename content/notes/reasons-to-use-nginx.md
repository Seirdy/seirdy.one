---
title: "Reasons to use Nginx"
date: 2022-09-09T13:52:55-07:00
replyURI: "https://news.ycombinator.com/item?id=32770766"
replyTitle: "Nginx…is legacy software being run into the ground"
replyType: "DiscussionForumPosting"
replyAuthor: "nginxlegacy"
replyAuthorURI: "https://news.ycombinator.com/user?id=nginxlegacy"
---
I generally recommend Caddy over Nginx, but Nginx does still have certain advantages:

- Nginx supports OpenSSL commands that enable features like TLS record padding.

- Performance: better latency and scalability to more connections. Not everyone uses a CDN for static/cached content

- Kernel-accelerated TLS offload on Linux and FreeBSD

- Many existing modules provide unique functionality. The many modules for live video streaming and image processing are good examples.

- An ecosystem of patches with features like HPACK static dictionaries, dynamic TLS record sizing, etce

> …has terrible language integration.

Generally, "language integration" isn't really a use-case for vanilla Nginx; it's a use-case for Nginx Unit, an Nginx language-specific module, or OpenResty. I personally prefer the reverse-proxy route since it lets me use whatever language I want regardless of server support: Go, Rust, Python, C, etc.

If none of these are that important then I absolutely would not recommend Nginx; Caddy would be the better tool.

> People aren't writing internet scale software in lua for a reason.

I'd include Itch.io, much of Taobao, and some of the most popular API gateways (including Kong) in the category of "Internet-scale software written by 'people'".


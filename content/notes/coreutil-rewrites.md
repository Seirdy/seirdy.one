---
title: "Coreutil rewrites"
date: 2022-12-10T14:03:18-08:00
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AQTdDi1kRXfigMWBPc'
---

<ins datetime="2022-12-10T22:13:50+00:00">This was originally a reply to another post. That post has been deleted.</ins>

> Can we agree to rewrite all the GNU utilities in Rust

The advantage of POSIX coreutils is their portability and universality; I can expect them to be present on any POSIX system. If re-writing will sacrifice portability, _we might as well do a clean break from POSIX and seek to improve upon existing coreutils_ rather than replace them. I listed some on [my "uses" page]({{<relref "/about/uses.md">}}): Zsh+DASH, ripgrep, sd, and fd. Three of those are written in Rust.

> release them with a better licence

I actually do like copyleft for more substantial works. However, POSIX shell utilities have been implemented many times over: Busybox, Toybox, and FreeBSD utilities come to mind. The specific free license they use is no longer important.


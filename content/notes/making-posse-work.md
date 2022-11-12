---
title: "Making POSSE work"
date: 2022-11-11T16:42:21-08:00
replyURI: "https://front-end.social/@hdv/109327126168122994"
replyTitle: "strange to talk to my social network [without] a dedicated client"
replyType: "SocialMediaPosting"
replyAuthor: "Hidde de Vries"
replyAuthorURI: "https://hidde.blog/"
---

I just learned that dedicated IndieWeb clients do exist! Sharing for those less familiar:

[Social readers](https://indieweb.org/social_reader) fetch your feeds (RSS, Atom, h-feed, WebSub) from a MicroSub server and post replies to your site with MicroPub. Your site sends Webmentions. The result resembles the pre-ActivityPub, OStatus-based Fediverse but with single-user instances. RSS/Atom feeds for Fediverse accounts and [<abbr>POSSE</abbr>](https://indieweb.org/POSSE) connect the IndieWeb and Fediverse; alternatively, your site can implement both. <abbr>POSSE's</abbr> advantage over [PESOS](https://indieweb.org/PESOS) is directing people towards your site, where they can see Webmentions from places besides their silo. It allows interoperability.

[I prefer the classic static site approach]({{<relref "meta/site-design.md#static-indieweb">}}). I only need a static file server and a Webmention receiver; a post-push git hook sends Webmentions and semi-automatically <abbr>POSSEs</abbr> to the Fediverse. When I finally set up WebSub, it'll ping my publisher. My approach slows me down enough to think through what I say. I want my site to feature my _best_ content; my non-<abbr>POSSE</abbr> silo content _should_ be more disposable or context-specific.

> I don't have the context of everyone else's tweets

[Reply-contexts](https://indieweb.org/reply-context) help, but I prefer combining one-sentence titles with interleaved quoting.

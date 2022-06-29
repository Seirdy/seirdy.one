---
title: "Feed-based social media"
date: 2022-06-28T17:33:14-07:00
---
The core elements of a people-focused (as opposed to a community-focused) social network are subscribing to people for content and interacting with their content. Atom (and RSS) feeds already provide "subscription" functionality; what if we went further?

Atom feeds can serve as the foundation for distributed social media. The [OStatus protocol suite](https://en.wikipedia.org/wiki/OStatus) describes how Salmon, ActivityStreams, and threading extensions can turn an Atom feed into a "social media feed" that people can interact with. Throw in [WebSub](https://www.w3.org/TR/websub/) for real-time push-based updates. This OStatus + WebSub system was the precursor to the current ActivityPub-based [Fediverse](https://en.wikipedia.org/wiki/Fediverse).

[The IndieWeb](https://indieweb.org/) has similar concepts. The IndieWeb community uses [microformats](https://microformats.org/wiki/microformats2) for metadata, including the `h-feed` feed format. It also uses [Webmentions](https://webmention.net/) for interaction between sites.

Just out of curiosity, I implemented everything except for the Salmon protocol and WebSub. I prefer Webmentions to Salmon, though [extensions to the former seem to overlap with the latter](https://indieweb.org/Salmention). I've tried and failed to get WebSub working in the past; I might have to run my own hub (perhaps using [the websub-server Go package](https://github.com/tystuyfzand/websub-server)).

The best part of this approach is the simplicity. Besides a Webmention receiver and a WebSub hub, all you need is a static server to deliver markup files. A separate program on your machine (i.e. not necessarily your server) can ping your WebSub hub and send Webmentions; I happen to like the command-line program [Pushl](https://github.com/PlaidWeb/Pushl/). Once all the pieces come together, you start to wonder why we let social media companies flourish instead of lowering the barrier to join something like the IndieWeb. This is what the Web is made for.

I wrote more about this site's social features in [a section of the site design page]({{<relref site-design.md>}}#static-indieweb).


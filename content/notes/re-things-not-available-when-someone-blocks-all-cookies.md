---
title: "Re: things not available when someone blocks all cookies"
date: 2022-08-31T20:36:30-07:00
replyURI: "https://blog.tomayac.com/2022/08/30/things-not-available-when-someone-blocks-all-cookies/"
replyTitle: "Things not available when someone blocks all cookies"
replyType: "BlogPosting"
replyAuthor: "Thomas Steiner"
replyAuthorURI: "https://blog.tomayac.com/about/"
---
Client-side storage (cookies, cache, etc.) is one of many things worth disabling during site testing. The Tor Browser's "safest" level blocks SVG, remote fonts, JS, and other features; many textual browsers don't support anything besides a subset of (X)HTML. Most [non-mainstream search engines]({{<relref "/posts/search-engines-with-own-indexes.md">}}) are similar.

Personally, I try to keep sites [<dfn>curlable</dfn>](https://indieweb.org/curlable). It should be possible to use a plain <code>curl <var>URL</var></code> command to get all the necessary markup, complete with visible contents. If the main content of the page is text, then *everything else should be a progressive enhancement.*

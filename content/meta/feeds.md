---
date: "2022-08-12T00:00:01-07:00"
evergreen: true
title: "Feeds"
outputs:
    - html
description: "Full-text Atom and RSS feeds for this site and its sub-sections."
---
This site has multiple feeds for different sections. I offer both Atom and RSS feeds; I strongly recommend using the Atom feeds, as I don't really make an effort to validate my RSS feeds. I only keep the RSS feeds around for compatibility with legacy clients.

They contain the full-text of their entries; this means that the "Combined" feed doubles as a single-file archive of all my content. It's also rather big, weighing almost a megabyte before compression (under 200&#160;kb after Brotli compression). Don't refresh more often than you need to.

Once the compressed size of an Atom feed crosses half a megabyte, I'll consider setting up paginated feeds.

Atom feeds
----------

Enjoy!

- [Combined feed](../../atom.xml)
- [Articles feed](../../posts/atom.xml)
- [Notes feed](../../notes/atom.xml)

RSS feeds
---------

If you experience issues with Atom feeds, try an RSS feed:

- [Legacy combined RSS feed](../../index.xml)
- [Legacy articles feed](../../posts/index.xml)
- [Legacy notes feed](../../notes/index.xml)

Compatibility notes
-------------------

I tested the feeds to work well in Newsboat, Pale Moon, Vivaldi's feed reader, and a few Firefox-extension-based feed readers. I do not necessarily endorse all these clients.

Surprisingly, Microsoft Outlook supports feeds; however, it can't parse un-escaped XHTML entry contents in my Atom feeds. I escape entry contents in the legacy RSS feeds for broken clients like Outlook.


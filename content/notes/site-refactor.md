---
title: "Site refactor"
date: 2022-05-27T17:18:08-07:00
---

I just made a massive internal overhaul of my website, [seirdy.one](https://seirdy.one/).
I prettified all the URLs to remove the trailing "`.html`" suffixes. I added re-directs from the old locations to the new ones, so your links won't break.

The reason I did this was because I plan on making alternative content types share the same index URL, except for the suffix. So `seirdy.one/notes/` could have an `index.html`, `index.xml` (RSS), `index.md`, `index.gmi`...you get the picture.

I removed the RSS feed from my Gemini capsule in favor of just supporting gmisub.

I also added Atom feeds to keep my existing RSS feed company:

- [Posts feed](https://seirdy.one/posts/atom.xml)
- [Notes feed](https://seirdy.one/notes/atom.xml)

Those make for the first step towards supporting WebSub. I'll have to look into ActivityStreams documentation to figure out which markup to add to my Atom feeds first. I'll probably add a `curl` command to my CI job to get a WebSub endpoint to re-read my Atom feeds whenever I push a change.

I need to figure out how to get Hugo to do a "combined" feed for everything.

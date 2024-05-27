---
title: "WAI-Adapt fallbacks to equivalent microformats"
date: 2022-09-13T11:28:15-07:00
replyURI: "https://github.com/w3c/adapt/wiki/Comparison-of-ways-to-use-vocabulary-in-content"
replyTitle: "Comparison of ways to use vocabulary in content"
replyAuthor: "WAI-Adapt Task Force"
replyAuthorType: "Organization"
replyAuthorURI: "https://www.w3.org/WAI/APA/task-forces/adapt/"
---

I noticed that the <cite>[Comparison of ways to use vocabulary in content](https://github.com/w3c/adapt/wiki/Comparison-of-ways-to-use-vocabulary-in-content)</cite> page on the personalization-semantics wiki didn't mention Microformats. Microformats add semantic meaning to individual HTML elements; this is in contrast to document-level semantic formats like Microdata, RDFa, and JSON-LD.

There's a 1-1 mapping between many microformats and values in [the WAI-Adapt Content Module](https://w3c.github.io/adapt/symbols/index.html). Several values under section 4.3.4 (values for "purpose") are already specified in [`h-card` microformats2](https://microformats.org/wiki/h-card), for instance. You can find plenty of live `h-card` implementations on [the IndieWeb Webring directory](https://🕸💍.ws/directory).

[w3c/coga Issue 69](https://github.com/w3c/coga/issues/69) also references overlap between "destination" vocabulary and `rel` values. Microformats leverage `rel` attributes like [`rel="license"`](https://microformats.org/wiki/rel-license) and [`rel="home"`](https://microformats.org/wiki/rel-home); these seem equivalent to the "terms" and "home" values for destination attributes.

I propose the addition of microformats2 to the comparison wiki page, and would support either merging the content module with microformats or specifying a mapping for fallback.

Syndicated to <a href="https://github.com/w3c/adapt/issues/221" class="u-syndication" rel="syndication">the GitHub w3c/adapt bug tracker</a>.

<ins>Update <time>2022-10-31</time>: the Content module has since been re-named to the Symbols module; I've updated the link in the this post.</ins>

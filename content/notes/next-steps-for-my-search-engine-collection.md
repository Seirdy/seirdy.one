---
title: "Next steps for my search engine collection"
date: 2024-05-24T08:48:41-04:00
replyURI: "https://seirdy.one/posts/2021/03/10/search-engines-with-own-indexes/"
replyTitle: "A look at search engines with their own indexes"
replyType: "BlogPosting"
replyAuthor: "Seirdy"
replyAuthorURI: "https://seirdy.one/"
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AiDUlrCthb1fPcvSgi'
---

My search engine article blew up recently, as [yet another major publication linked it](https://arstechnica.com/gadgets/2024/05/bing-outage-shows-just-how-little-competition-google-search-really-has/2/) (yay! /gen), so I made some fixes:

- Moved a couple engines to the graveyard. h/t to {{<indieweb-person url="https://dequbed.space/" name="dequbed" itemprop="mentions">}} for telling me about moose.at's demise, and to my broken link checker for telling me about Siik being down for a while now.
- Updated my methodology section to emphasize how I now use word-substitutions to fingerprint an engine's source. Queries that lend themselves to word-substitution are now **my primary approach to uncovering which provider an engine uses for search results,** followed by some long-tail queries and search operator support.

The full list of changes is in [the Git log](https://git.sr.ht/~seirdy/seirdy.one/log/master/item/content/posts/search-engines-with-own-indexes.md). Things I should add in the future:

- I ought to add a section to describe why I don't personally like metasearch engines as much as I used to. TLDR: each engine has its own quirks and search operators that I learn to use, and throwing them all on one page forces me to use whatever quirks they have in common. This is really bad for long-tail queries.
- I should put more effort into categorizing engines by strength as well as index size. I'll have to come up with appropriate terms for things like "ability to find specific pages with specific topics" (less aggressive word substitutions, less focus on semantic search: Mojeek is one of the best at this, Yep is terrible), or "ability to discover pages about a given broad topic" (Yep is good at this once you learn to use it well, but Mojeek isn't).

That second bullet point is really important. Part of the point of this article is to show that **nobody can beat Google at being Google** (except perhaps Bing), but we can beat Google at more specific niches.

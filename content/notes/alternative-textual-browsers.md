---
title: "Alternative textual browsers"
date: 2022-08-06T19:00:03-07:00
---
I've used [many textual browsers]({{<relref "/meta/site-design.md#compatibility-statement">}}), but I'm interested in more hardened options. Browsers parse untrusted content from the Internet but no textual browsers employ sandboxing, continuous fuzzing, or other security measures. Check CVEs for Lynx or w3m and you'll see what I mean.

I'm also looking at alternatives to [my w3m-sandbox script](https://git.sr.ht/~seirdy/bwrap-scripts/tree/trunk/item/w3m-sandbox) to show HTML emails. Pandoc with `commonmark-raw_html` output is an option; Haskell seems like a better choice than un-fuzzed C for this. I'd like a more battle-hardened library for networking, like libcurl (used in Edbrowse).

I considered [Offpunk](https://sr.ht/~lioploum/offpunk/), which uses Readability to extract articles. I'd rather pipe [rdrview](https://github.com/eafer/rdrview) output to w3m-sandbox. rdrview does some sandboxing, and sanitizes input to a subset of HTML.


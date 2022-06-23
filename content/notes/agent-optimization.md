---
title: "Agent optimization"
date: 2022-06-23T16:12:13-07:00
---
I'm thinking about coining a term to reflect a non-toxic alternative to "search engine optimization" (SEO). Working name: "agent optimization".

[MDN has SEO guidelines](https://developer.mozilla.org/en-US/docs/MDN/Contribute/Howto/Write_for_SEO) because people often find MDN articles through general-purpose search engines. I noticed that a subset of their advice is directly beneficial to readers.

For example: imagine two pages have almost the same content (e.g. pages on the `width` and `height` CSS properties). Nearly-identical pages confuse search engines. To avoid duplicate content, authors are encouraged to differentiate the pages by using different examples. This is actually great for readers: when a reader navigates from one page to the next, it'd be unhelpful to present the same example again. Perhaps the `width` example could describe adaptation to a narrow viewport, while the `height` example could describe the trick for handling image aspect ratios with `height: auto`.

Lots of SEO is actually just basic design and accessibility guidelines: use good link names, remember alt-text, be mobile-friendly, use headings, don't require tons of JS to display content, prefer semantic HTML, etc. Stuff like structured data also helps improve reader-mode implementations and makes content-blocking easier.

SEO gets toxic when it veers into copywriting guidelines, tricks like adding the current year to your heading ("Best products to buy in <var>CURRENT_YEAR</var>"), backlink-building, etc. Much of this does include so-called "white-hat SEO". I think that I should distinguish "agent optimization" from "search engine optimization" by making it about accommodating the tools people use to find information, rather than about ranking high in search results or getting clicks. Once I finish my current <abbr title="Work In Progress">WIP</abbr> blog post (it's about how to make privacy recommendations for different audiences), I think I'll write about this. In the meantime, any ideas you have are welcome; please share them.


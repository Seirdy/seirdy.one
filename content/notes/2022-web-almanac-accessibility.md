---
title: "Reflections on the 2022 Web Almanac’s accessibility findings"
date: 2022-10-10T21:37:52-07:00
replyURI: "https://almanac.httparchive.org/en/2022/accessibility"
replyTitle: "Accessibility: The 2022 Web Almnac"
replyType: "TechArticle"
replyAuthor: "HTTP Archive"
replyAuthorURI: "https://httparchive.org/"
replyAuthorType: "Organization"
---

I have a few thoughts on these findings:

1. The Almanac says skip links commonly skip to the `<main>` element; I consider [large focusable containers an anti-pattern]({{<relref "/posts/website-best-practices.md#against-focusable-containers">}}) since they ruin keyboard navigability, and recommend skipping to a heading instead.

2. The Almanac identifies accessible live regions by `role="live"`. I'd suggest also looking into `role="feed"`, which represents a common type of live region.

Some common accessibility issues I'd be interested in for future editions:

- Contrast that's too high
- Setting custom foregrounds but not custom backgrounds, and vice versa
- Removing link underlines
- Focusable containers
- Using icon fonts without accessible names

Overall, it's a good look at the small subset of accessibility issues that are automatically detectable (most of which are far less critical than manually-detectable issues).

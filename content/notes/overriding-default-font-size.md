---
title: "Overriding default font size"
date: 2022-10-27T11:18:25-07:00
replyURI: "https://mastodon.social/@mathew/109236592585774225"
replyTitle: "why override the user's choice of base font size?"
replyType: "SocialMediaPosting"
replyAuthor: "mathew"
replyAuthorURI: "https://meta.ath0.com/"
---
Three reasons to declare a font size in a page's CSS:

1. Not all browsers support all types of zoom (standard, pinch-to-zoom, and text-only zoom). Some mobile browsers still don't support _any_ type of zoom.

2. Different use-cases call for different sizes. Long-form text should be bigger than text in user-interface controls.

3. WCAG guidelines recommend sizing tap-targets to at least 44-by-44 CSS pixels, with the exception of inline links. Google recommends 48-by-48 CSS pixels, with no overlap across a 56-by-56 pixel range. Increasing my root font size makes non-inline links and buttons bigger.

Combining the first and second points, we see that the base font size on the Web is not a "one-size-fits-all" solution. It's now a reference point for relative font sizes (e.g. `em`, `rem`, percents). Relative font sizes scale with the base font instead of "overriding" it.

My browser's default size is perfect for a typical Fediverse microblog or information-dense discussion-forum, not for reading an article. My website's stylesheet defines a font that is 9.375% larger than default, whatever that may be.


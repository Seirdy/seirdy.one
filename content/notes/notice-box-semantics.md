---
title: "Notice box semantics"
date: 2022-09-22T09:10:41-07:00
replyURI: "https://tdarb.org/blog/notice-box.html"
replyTitle: "RE: Creating a Simple HTML/CSS Notice Box"
replyType: "BlogPosting "
replyAuthor: "Bradley Taunt"
replyAuthorURI: "https://tdarb.org/about.html"
---

I'd rather make a notice a `<section>` with a heading, or an `<aside>` if it's not related to the surrounding content.

You could even add a more specific ARIA  (or DPUB-ARIA) role like `role="note"`, `role="doc-pullquote"`, `role="doc-tip"`, etc. But don't use them unless you have multiple kinds of `aside` elements and need to help people skim.

Most of these roles actually map to the `section` superclass rather than the `complementary` role of `aside`, which isn't always a problem: the `aside` element tells reader-mode implementations to remove the element, but the `role` tells assistive technologies more useful information. I use a similar hack for my in-page section permalinks.

If the notice is important to the surrounding content and reader-mode shouldn't remove it, use a `section`.

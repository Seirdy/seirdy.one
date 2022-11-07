---
title: "Assistive technology support versus textual browsers"
date: 2022-11-06T22:04:08-08:00
replyURI: "https://mastodon.cisti.org/@GustavinoBevilacqua/109300551030058031"
replyTitle: "many screen readers for blind people are based on lynx"
replyType: "SocialMediaPosting"
replyAuthor: "Gustavino Bevilacqua"
replyAuthorURI: "https://mastodon.cisti.org/@GustavinoBevilacqua"
---

This is an idea I've seen repeated before. I need to push back on it.

Assistive technology (<abbr>AT</abbr>) interfaces with an operating system's accessibility APIs. A browser converts the Document Object Model (<abbr>DOM</abbr>) into an assistive tree, and sends that to the OS accessibility API.

Now, some screen readers actually do hook into the browser; NVDA does this with Firefox and Chromium. But this isn't always the case. ATs need to crawl an accessibility tree for the entire desktop environment, and the browser is one of many windows present. They don't just convert markup to text.

A semantic screen-reader friendly site may look awful in Lynx. A Lynx-friendly site may have terrible semantics and navigate poorly in a screen reader. To work well in both scenarios, deliver content with semantic markup and make non-markup resources optional.

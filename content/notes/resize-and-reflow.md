---
title: "Resize and reflow"
date: 2022-06-07T23:38:39-07:00
replyURI: "https://yatil.net/blog/resize-text-reflow"
replyTitle: "WCAG SC 1.4.4 Resize Text and 1.4.10 Reflow"
replyType: "BlogPosting"
replyAuthor: "Eric Eggert"
replyAuthorURI: "https://yatil.net"
---

This is a good article on the difference between SC 1.4.4 and 1.4.10. However, I don't think these criteria go far enough:

Even narrower viewports exist. KaiOS devices tend to have 240&nbsp;px viewports; smartwatches tend to have half the width of a phone while emulating a phone width (Apple Watches can be instructed not to do this with a proprietary `meta` tag). Of course, making sites watch-compatible is a stretch, but support for feature phones running KaiOS should be reasonable. I wrote about this more in <cite>[Best practices for inclusive textual websites]({{<relref "/posts/website-best-practices">}})</cite>.

Another thing worth remembering is that users can change default fonts or override sire-set fonts. Don't just test with default default fonts; test with something wider. These criteria should specify some font metrics or (royalty free) representative wide fonts to use for testing.

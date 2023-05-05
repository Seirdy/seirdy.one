---
title: "Approaches to speculative preloading"
date: 2023-05-05T00:00:04-07:00
replyURI: "https://social.treehouse.systems/@felipe/110185148285133305"
replyTitle: "there must be a whole research area for “speculative human interaction”"
replyType: "SocialMediaPosting"
replyAuthor: "Felipe Tavares"
replyAuthorURI: "https://felipetavares.com/"
---
instant.page (mentioned in another response) is popular, but it's not the only game in town. Google Chrome Labs made an alternative called [quicklink](https://github.com/GoogleChromeLabs/quicklink) which also attempts to optimize CPU time by preloading in-viewport pages during idle time. instant.page generally expects you to be using a mouse; results on touchscreens are pretty minimal and probably not worth the extra JS.

[Speculation rules](https://wicg.github.io/nav-speculation/speculation-rules.html) are being standardized for a JavaScript-free alternative. Figuring out which pages to preload will be the hard part. I like this because it'll be easy to globally disable the behavior if I need to save data (or if it helps reduce fingerprinting).

If your backend isn't too slow and your payload is small, simpler optimizations are probably better.

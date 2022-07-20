---
title: "Hugo microformats"
date: 2022-07-20T11:17:11-07:00
replyURI: "https://github.com/gohugoio/hugo/issues/10108"
replyTitle: "Support h-feed h-entry (Hugo issue 10108)"
replyType: "DiscussionForumPosting"
replyAuthor: "Schimon Jehuda"
replyAuthorURI: "https://github.com/sjehuda"
---
I think `h-feed` and `h-entry` should be implemented manually by Hugo theme and/or site authors. Microformats add class names to a page, but someone still has to design a page. There's way more diversity in h-feed design than RSS, Atom, or JSON-feed design because h-feeds are webpages meant for humans first, machines second. Providing built-in h-feed templates would be akin to providing a default incomplete theme.

That being said, I could imagine other microformats getting shortcodes and templates. A shortcode and/or partial for `h-cite`, `h-card`, etc. could work. [I've made a few microformats shortcodes](https://git.sr.ht/~seirdy/seirdy.one/tree/master/layouts/shortcodes) and could upstream simplified versions if there is sufficient interest.

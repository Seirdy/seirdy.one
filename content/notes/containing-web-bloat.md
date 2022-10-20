---
title: "Containing web bloat"
date: 2022-10-20T13:20:11-07:00
replyURI: "https://mastodon.sdf.org/@khm/109201860585444737"
replyTitle: "Web technology has gotten bigger because web engineers just don’t care"
replyType: "SocialMediaPosting"
replyAuthor: "khm"
replyAuthorURI: "https://sciops.net/"
---
Here is how I propose browsers address web bloat:

1. [Stop adding features](https://seirdy.one/notes/2022/06/18/browser-development-moratorium/) unrelated to accessibility, security, privacy, and internationalization.

2. Adopt a default [document policy](https://github.com/wicg/document-policy/blob/main/document-policy-explainer.md) that [restricts oversized assets and download size](https://github.com/WICG/document-policy/issues/44).

3. Make JIT-compilation a per-site opt-in permission. That should rein in over-reliance on JS.

This should mostly contain the bloat problem without significantly inconveniencing most users, which is why it will never happen.


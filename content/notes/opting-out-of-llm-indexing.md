---
title: "Opting out of LLM indexing"
date: 2023-04-21T22:40:04-07:00
replyURI: "https://chriscoyier.net/2023/04/21/the-secret-list-of-websites/"
replyTitle: "“the secret list of websites”"
replyType: "BlogPosting"
replyAuthor: "Chris Coyier"
replyAuthorURI: "https://chriscoyier.net/"
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AUttq9kpOmeYZDHRTc'
---
I added an entry to [my robots.txt](https://seirdy.one/robots.txt) to block ChatGPT's crawler, but blocking crawling isn't the same as blocking indexing; it looks like Google chose to use the [Common Crawl](https://commoncrawl.org/) for this and sidestep the need to do crawling of its own. That's a strange decision; after all, Google has a much larger proprietary index at its disposal.

A "secret list of websites" was an ironic choice of words, given that this originates from the Common Crawl. It's sad to see Common Crawl (ab)used for this, but I suppose we should have seen it coming.

I know Google tells authors how to qualify/disqualify from rich results, but I don't see any docs for opting a site out of LLM/Bard training.

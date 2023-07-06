---
title: "Blocking certain bots"
date: 2023-07-06T10:36:32-07:00
replyURI: "https://gist.github.com/dangovorenefekt/b187b30e59ed1b827515cdbc833bc1bf?permalink_comment_id=4611496#gistcomment-4611496"
replyTitle: "You miss the point"
replyType: "DiscussionForumPosting"
replyAuthor: "DanGovorenEfekt"
replyAuthorURI: "https://govorenefekt.com/"
syndicatedCopies:
    - title: 'GitHub'
      url: 'https://gist.github.com/dangovorenefekt/b187b30e59ed1b827515cdbc833bc1bf?permalink_comment_id=4621262#gistcomment-4621262'
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AXQOGKrOajCIX9XgEC'
---

> I don't want my content on those sites in any form and I don't want my content to feed their algorithms. Using robot.txt assumes they will 'obey' it. But they may choose not to.

So you'd like to block the scrapers used by some large companies, most of which appear well-behaved (i.e. they observe `robots.txt` and `noindex` directives). Some organizations disclose IPs they use, but you are banking on their honesty.

If we assume that trillion-dollar organizations are dishonest about how they scrape: they can spoof their user-agent, TLS fingerprint, IPs, etc. and use a headless browser very easily. There isn't really a way to protect yourself from this without also excluding real users (e.g. invasive/inaccessible CAPTCHAs for which workarounds exist).

They can get your content without scraping by downloading other data sets like the Common Crawl (Google did this for Bard), purchasing data sets from other vendors, or acquiring other companies with their own indexes.

The alternative is to assume they're at least somewhat honest about scraping content. If you use a `noindex` robots directive in your markup and HTTP headers but allow crawling, their crawlers will visit but won't index your site no matter what user-agent or data set they use. Check their webmaster documentation to double-check their support for these features.

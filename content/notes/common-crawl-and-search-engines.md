---
title: "Common Crawl and search engines"
date: 2024-07-24T14:23:35-04:00
replyURI: "https://corteximplant.net/objects/994acaa1-dd50-44b0-bb50-43211521a779"
replyTitle: "We really fucking need a community owned search engine index that fucks the corporate rules (but still respects personal websites' indexing preferences)"
replyType: "SocialMediaPosting"
replyAuthor: "Marta Sokolska"
replyAuthorURI: "https://me.pionaiki.com/"
#syndicatedCopies:
#    - title: 'The Fediverse'
#      url: ''
---
Common Crawl is the closest thing we have to an open index, though it doesn't meet your requirement of ignoring robots.txt for corporate websites while obeying it for personal sites. Unfortunately, being open and publicly available means that people use it to train LLMs. ([Google did this for initial versions of Bard]({{<relref "/notes/opting-out-of-llm-indexing.md">}})), so a lot of sites block its crawler. Most robots.txt guides for blocking GenAI crawlers include an entry for it now.

[Common Crawl powers Alexandria Search and was the basis of Stract's initial index]({{<relref "/posts/search-engines-with-own-indexes.md#smaller-indexes-or-less-relevant-results">}}), both of which are upstart FOSS engines.

A similar EU-focused project is [OpenWebSearch/Owler](https://openwebsearch.eu/common-goals-with-common-crawl/).

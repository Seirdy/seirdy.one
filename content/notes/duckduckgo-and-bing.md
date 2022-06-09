---
title: "DuckDuckGo and Bing"
date: 2022-06-02T20:59:38-07:00
replyURI: "https://www.librepunk.club/@penryn/108411423190214816"
replyTitle: "how would html.duckduckgo.com fit into this?"
replyType: "SocialMediaPosting"
replyAuthor: "@penryn@www.librepunk.club"
replyAuthorURI: "https://www.librepunk.club/@penryn"
---

I was referring to crawlers that build indexes for search engines to use. DuckDuckGo does have a crawler---DuckDuckBot---but it's only used for fetching favicons and scraping certain sites for infoboxes ("instant answers", the fancy widgets next to/above the classic link results).

DuckDuckGo and other engines that use Bing's commercial API have contractual arrangements that typically include a clause that says something like "don't you dare change our results, we don't want to create a competitor to Bing that has better results than us". Very few companies manage to negotiate an exception; DuckDuckGo is not one of those companies, to my knowledge.

So to answer your question: it's irrelevant. "html.duckduckgo.com" is a JS-free front-end to DuckDuckGo's backend, and mostly serves as a proxy to Bing results.

For the record, Google isn't any different when it comes to their API. That's why Ixquick shut down and pivoted to Startpage; Google wasn't happy with Ixquick integrating multiple sources.

[More info on search engines](https://seirdy.one/posts/2021/03/10/search-engines-with-own-indexes/).

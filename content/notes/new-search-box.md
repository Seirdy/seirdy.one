---
title: "New search box"
date: 2022-05-26T17:42:09-07:00
---

I decided my site had enough content to warrant a search form, so I added one to the footer. I kanged the CSS from [gov.uk](https://www.gov.uk/); I liked how their search box was adaptive yet compatible with legacy browsers. This is a static site so I made it point to [Search My Site](https://searchmysite.net/), which regularly crawls my whole website.

Eventually I'll add a dynamic page for search results (probably using the Search My Site API), and add an ATOM feed for posts and notes (I currently have an RSS feed for posts, and that's not going anywhere). If I get those two, I'll be ready for the next step of setting up [WebSub](https://www.w3.org/TR/websub/) and starting on [IndieMark 4](https://indieweb.org/IndieMark) (I've decided not to <abbr title="Publish on Own Site, Syndicate Elsewhere">POSSE</abbr> *all* my microblog posts, to maintain some separation between my identities).

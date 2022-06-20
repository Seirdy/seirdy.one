---
title: "Welcome to the IndieWeb"
date: 2022-06-20T14:30:24-07:00
replyURI: "https://www.miriamsuzanne.com/2022/06/04/indiweb/"
replyTitle: "Am I on the IndieWeb Yet?"
replyType: "BlogPosting"
replyAuthor: "Miriam Suzanne"
replyAuthorURI: "https://www.miriamsuzanne.com/who/"
---
Welcome to the IndieWeb, Miriam!

> I've struggled to categorize what on my wite is a "post" worth syndicating vs a "page" vs ???

I had this struggle too, and solved it with per-section and combined feeds. [My combined feed](https://seirdy.one/atom.xml) contains every page on my site that includes a publication date in its metadata; my sections for articles and notes have their own respective feeds.

> If I want live updates (this is a static site) there’s still more to learn.

Remember that pretty much all IndieWeb features are optional. You only have to implement what interests you. You can get really far when it comes to bringing a static site to the IndieWeb, so I'd suggest against jumping onto a dynamic site immediately.

You can also push live updates using WebSub. Your main site can still be static, but you can pint a (first- or third-party) WebSub hub to push content as soon as you update your site. I plan on using this approach soon.

I like the "static site with ancillary services" model: it keeps the core fast and simple, and makes extra modules easy to add and replace.

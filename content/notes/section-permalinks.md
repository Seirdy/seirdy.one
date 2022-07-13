---
title: "Section permalinks"
date: 2022-07-13T14:47:30-07:00
replyURI: "https://programist.ro/@walter/108641672090578574"
replyTitle: "I would show that permalink everywhere."
replyType: "SocialMediaPosting"
replyAuthor: "Walter S."
replyAuthorURI: "https://programist.ro/@walter"
---

> IMHO, your implementation seems just right.

Thanks! I based my approach off of [Amber Wilson's section permalinks](https://amberwilson.co.uk/blog/are-your-anchor-links-accessible/)

One key difference: I wanted CSS to be an optional cosmetic enhancement, and not something that changes the content that people see (except for print media). I want my markup to only define structure/semantics, when possible (i.e. ideally no cosmetic `div` wrappers). That meant displaying the section permalink as a readable link. I used `aria-labelledby` to give each section permalink a unique accessible name.

I've heard positive feedback from both screen-reader and textual-browser users.

As for how this relates to reading mode implementations:

The point of reading-mode tools is to reduce clutter and focus on reading an article, without the author's supplied user-interface. Section permalinks feel like a part of a "user interface" and should be removed; the interface should only be provided by the reading-mode. On the other hand, most reading modes don't provide a document outline or a way to get a link to the current section, and users might want that functionality without having to leave reading-mode. On a third hand: if I include section permalinks in reading mode, then it'd end up looking almost identical to the un-distilled page. That'd make reading mode almost useless.

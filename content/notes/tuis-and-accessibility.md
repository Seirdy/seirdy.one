---
title: "TUIs and accessibility"
date: 2022-06-11T13:13:15-07:00
replyURI: "https://floss.social/@alcinnz/108460252689906224"
replyTitle: 'My understanding so far has been limited to "use Gettext…avoid NCurses"'
replyType: "SocialMediaPosting"
replyAuthor: "Adrian Cochrane"
replyAuthorURI: "https://adrian.geek.nz/"
---
ncurses is fine for certain specific purposes, like querying terminal characteristics.

I think if you're building a <abbr title="textual user interface">TUI</abbr> it should generally be one of multiple options that share a library/backend or it should be something with many alternatives that are at least equivalent, given the poor accessibility of TUIs in general. If one of those things is true, then it should be fine to use ncurses for the TUI.

There's a [Python library called "Textualize"](https://www.textualize.io/) for building TUIs and CLI shells. They're working on a web target which [they claim can get much better accessibility.](https://news.ycombinator.com/item?id=31151158)

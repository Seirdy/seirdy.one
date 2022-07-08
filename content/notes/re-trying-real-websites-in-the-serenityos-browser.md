---
title: "Re: trying real websites in the SerenityOS browser"
date: 2022-07-08T14:53:39-07:00
replyURI: "https://linus.dev/posts/trying-real-websites-in-the-serenityos-browser/"
replyTitle: "Trying Real™ Websites in the SerenityOS Browser"
replyType: "BlogPosting"
replyAuthor: "Linus Groh"
replyAuthorURI: "https://linus.dev/"
---

Most of these are pages that blur the line between "document" and "app", containing many interactive controls. Being concerned about them is valid; however, I think the concern is misplaced at this stage.

*For an independent engine,* I'm more interested in simple "web documents". Those need to work well before tackling "Web 2.0" territory. Specifically: articles progressively enhanced with images, stylesheets, and maybe a script or two. Understanding how well Web 2.0 sites render isn't really useful to me without first understanding how well documents render.

When testing my site, my main pain points are: a lack of support for `<details>`, misplaced `<figcaption>` elements, my SVG profile photo not rendering (it renders when I open it in a new tab), and occasional overlapping text. The only non-mainstream independent engine I know of that supports `<details>` is Servo.

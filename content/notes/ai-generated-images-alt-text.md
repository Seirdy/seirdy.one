---
title: "Re: AI-Generated Images from AI-Generated Alt Text"
date: 2022-08-05T23:50:16-07:00
replyURI: "https://adrianroselli.com/2022/08/ai-generated-images-from-ai-generated-alt-text.html"
replyTitle: "AI-Generated Images from AI-Generated Alt Text"
replyType: "BlogPosting"
replyAuthor: "Adrian Roselli"
replyAuthorURI: "https://adrianroselli.com/"
---

This is a great post to illustrate the utility of detailed alt-text when an image is the primary content. I think it's less relevant for the more common use of images: as illustrative examples or supplements to surrounding text.

Take an image embedded in an article. Sighted users are capable of viewing a detailed image and instantly filtering for the information that's relevant to the surrounding content. It's harder to do this with a blurb of text, so this situation would call for more a more brief description.

The opposite extreme: the most detailed textual alternatives I work with are image transcripts (e.g. for comics). Flat text is a poor fit; semantic HTML works better. I'm hoping aria-details gains traction in the future and settling for [short alt + long `aria-describedby` text](https://seirdy.one/posts/2020/11/23/website-best-practices/#image-transcripts) in the meantime.

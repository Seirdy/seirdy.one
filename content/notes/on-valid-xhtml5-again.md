---
title: "On valid XHTML5 again"
date: 2024-06-23T16:15:06-04:00
replyURI: "https://snug.moe/notes/9uv9x9r9tqq1pcxu"
replyTitle: "what if I put in a bunch of effort to make my website valid XHTML5"
replyType: "SocialMediaPosting"
replyAuthor: "LunarEclipse"
replyAuthorURI: "https://lunareclipse.zone/"
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/objects/4660408b-41dc-4850-9197-9ce6585fceb7'
---

Switching a site to XHTML5 is only a lot of work at first, because it may have latent bugs. For instance, you may have a stray tag that the HTML parser auto-closes but an XHTML parser won't. I find this effort worthwhile because [some of these bugs will eventually visibly manifest]({{<relref "/notes/polygot-xhtml5.md">}}).

One thing I've noticed is that some tools are incompatible with an XHTML5 MIME type. Site auditors like Lighthouse are only provisionally compatible, and some browser extensions are rather buggy. You can compare them yourself on seirdy.one: switch the MIME type by appending `/index.xhtml` to a URL. You may have to disable the CSP sandbox by [appending `?sandbox=off` to the URL]({{<relref "/meta/csp-bug-reproduction.md#how-to-use-this-page">}}) to get Lighthouse to work. I keep my site polygot and serve with the `text/html` MIME type by default for maximum compatibility.

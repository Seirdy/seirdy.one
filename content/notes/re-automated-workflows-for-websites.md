---
title: "Re: automated workflows for websites"
date: 2023-04-20T14:36:16-07:00
replyURI: "https://blog.lea.lgbt/posts/2023-04-20-automated-workflows-for-websites/"
replyTitle: "Automated workflows for websites"
replyType: "BlogPosting"
replyAuthor: "Lea Rosema"
replyAuthorURI: "https://blog.lea.lgbt/"
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AUr8PE6SK6jXl3XaE4'
---
This is so similar to [my setup!]({{<relref "/meta/_index.md">}}) I run Stylelint and v.Nu too. I [send v.Nu output through a JQ filter](https://git.sr.ht/~seirdy/seirdy.one/tree/master/item/linter-configs/vnu_filter.jq) to filter out false-positives (after reporting them upstream); you might eventually do something similar, since there are a _lot_ of these. Your blog post reminds me that I need something better than regex substitutions for customizing footnote and section links; Hugo's parallel nature prevents it from doing post-processing of fully-assembled pages. Other tools I use:

- `xmllint` to validate that the markup is well-formed XHTML5 syntax; it runs much more quickly than v.Nu and does light auto-formatting, but is also more limited.

- There's also [a W3C feed validator](https://github.com/w3c/feedvalidator) written in Python worth checking out; I send my Atom feeds through that.

- I run `axe-core`, IBM Equal Access checker, and Webhint on every page with headless browsers.

- In the future: I'll need to figure out a good workflow for easily validating JSON according to a schema, and adding some Microformats + Microdata validation too (maybe using Schemara?).

The whole thing takes several minutes to run, so I don't run it every commit; just building my site (no linting or validation) requires only a tarball with some statically-linked binaries. It's more in line with the ["built to last"](https://jeffhuang.com/designed_to_last/) philosophy; I'm curious if you have any thoughts about it.

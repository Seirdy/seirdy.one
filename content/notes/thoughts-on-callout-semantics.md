---
title: "Thoughts on callout semantics"
date: 2023-08-29T22:54:38-07:00
replyURI: "https://toast.al/posts/softwarecraft/2023-08-29_semantic-markup-for-callouts"
replyTitle: "Semantic Markup for Callouts: A Not-Quite-RFC for Admonitions in HTML"
replyType: "BlogPosting"
replyAuthor: "toastal"
replyAuthorURI: "https://toast.al"
syndicatedCopies:
    - title: 'Lobsters'
      url: 'https://lobste.rs/s/ehzhcw/semantic_markup_for_callouts#c_ddiqt8'
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AZFO77yIoQhSicea1I'
---

Interesting proposal! Some thoughts:

- I'd suggest looking into the `doc-notice`, `doc-tip`, and `doc-example` [DPUB-ARIA](https://w3c.github.io/dpub-aria/) roles. I'm a big fan of DPUB-ARIA and I do not think it is used enough. I believe Google's Talkback has the most robust support for it put of any AT I'm familiar with.

- I'm not convinced that a `cot` element is necessary. I think a heading with `aria-labelledby` would work better as a way to name a callout, and an attribute (or DPUB-ARIA role) could better specify the type of callout.

Funnily enough, I'm thinking about my own proposal for a `spoiler` element which also has similar structure to—but different semantics from—the `details` element.

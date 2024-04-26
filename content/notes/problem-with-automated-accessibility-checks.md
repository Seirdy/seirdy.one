---
title: "The problem with automated accessibility checks"
date: 2022-12-22T09:52:09-08:00
lastmod: 2022-12-24T16:27:09Z
replyURI: "https://web.archive.org/web/20230201213609/https://a11y.info/@todd/109552097339472503"
replyTitle: "I run Lighthouse and WAVE as…a baseline of sorts"
replyType: "SocialMediaPosting"
replyAuthor: "Todd Libby"
replyAuthorURI: "https://toddl.dev/"
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AQs97KWObcsL5o0flw'
---

> I run Lighthouse and WAVE as a "Hey, let's see what I have ahead of me" kind of thing. A baseline of sorts. Then I go into manual testing 

I strongly disagree with running automated tests *first* if you have the means to do manual tests. People get too hung up on automated tests revealing only <var>N</var> percent of issues; the reality is that they end up encouraging people to spend their time fixing those issues instead of more critical errors.

Less than a minute with the "inspector" tool in most browser DevTools (not even the Accessibility Inspector!) will quickly reveal poor use of semantic HTML, poorly-written alt-text, site titles that shouldn't be headings, non-descriptive names, and conflation of semantics with presentation. Fixing these is probably a better use of your time than hunting down every duplicate link name in a page that an automated checker finds.

I prefer running an automated checker after catching low-hanging fruit manually.

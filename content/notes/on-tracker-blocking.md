---
title: "On tracker blocking"
date: 2022-06-06T16:37:57-07:00
replyURI: "https://madaidans-insecurities.github.io/browser-tracking.html"
replyTitle: "Browser Tracking"
replyType: "TechArticle"
replyAuthor: "madaidan"
replyAuthorURI: "https://madaidans-insecurities.github.io/"
---

I think this post is correct, strictly speaking. I also feel like it misses the point of tracker blocking (or at least, what I think the point *should* be). *Many people have a relatively casual threat model* when they do their typical browsing.

Lots of people are less concerned with avoiding identification than they are with reducing the amount of data collected about them. For example, if they sign into an account that's linked to their real identity, they fully expect to be identified by the site. However, if the site contains Facebook and Google trackers, they would rather not run those because they harm the user rather than help.

To say that this is not a perfect solution would be an understatement. But when it comes to meeting the goals of such a user, content blocking isn't useless. It straddles the gray area between quality-of-life improvements (blocking content makes pages less unpleasant and heavy) and slight unobtrusive privacy improvements (most nowadays sites outsource most of their tracking to known well-known third parties).

The ideal approach is obviously to use something like the Tor Browser's "Safest" mode (or perhaps the "safer" mode in a Whonix VM), which doesn't rely on badness enumeration. On that I agree. I personally switch between the Tor Browser for anonymous browsing (anonymity), Chromium for Web apps (security), and Firefox for general non-anonymous browsing (convenience and quality-of-life). Blocking trackers would not make sense for browsing anonymously, but is a slight improvement for non-anonymous browsing. Badness enumeration is of course counterproductive when trying to be fully anonymous.

In practice, content blocking reduces someone's online footprint. It doesn't prevent it from being created in the first place, and it can be circumvented. But footprint reduction is all that many are interested in, especially when it also offers unrelated perks like less ads and lighter pages.

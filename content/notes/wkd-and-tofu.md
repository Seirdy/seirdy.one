---
title: "WKD and TOFU"
date: 2023-01-08T14:04:22-08:00
replyURI: "https://tilde.zone/@ryan/109655653939080034"
replyTitle: "WKD is still TOFU so you should still verify out of band"
replyType: "SocialMediaPosting"
replyAuthor: "Ryan Heywood"
replyAuthorURI: "https://ryansquared.pub/"
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/ARRkGdJTzZpLF8Bz04'
---
I encourage people who fetch my keys to verify over multiple bands; for instance, they can fetch it over both Web Key Directory and DANE. They can also use something like Keyoxide to verify that it is associated with many other online accounts, perhaps including the account I was using when I first met that person. The later isn't exactly verifying "out of band", but it's super helpful.

If you're willing to do some of that (a _big_ "if": good communication protocols should make key exchange easier than this), then I'd argue that the initial leap of faith associated with Trust-On-First-Use (TOFU) is mostly a non-issue. However, PGP has its own larger set of issues that make it a poor candidate for communication protocols (complexity/configuration-hell with too many footguns, no forward secrecy, long-lived secrets, etc).

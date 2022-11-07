---
title: "Supporting alternative browser engines"
date: 2022-11-06T21:13:47-08:00
replyURI: "https://fosstodon.org/@caughtquick/109300199609421021"
replyTitle: "It’s not my job to make sure my website works on a browser from 2008 that’s missing half of [w3c] standards"
replyType: "SocialMediaPosting"
replyAuthor: "Abhijit Sipahimalani"
replyAuthorURI: "https://fosstodon.org/@caughtquick"
---

Progressive enhancement is a wonderful thing. I try to make sites usable in browsers of that era (with a TLS terminator) despite using several HTML&nbsp;5 and bleeding-edge CSS features. Every feature possible should be progressive.

[Here's the compatibility statement for seirdy.one]({{<relref "/meta/site-design.md#compatibility-statement">}})

I'm not asking anything too radical: when you want to use a feature, just try to make support optional. If there are two ways to do something, have a bias towards the older way. Without trying, you'll get good support for these browsers and for extensions that modify pages.

As a baseline, I recommend starting with the [subset of the HTML Living Standard that appears in the abandoned HTML 5.1 standard]({{<relref "/posts/website-best-practices.md#how-to-support-old-browsers">}}). CSS should be optional. This tends to progressively degrade fairly well.

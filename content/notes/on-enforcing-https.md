---
title: "On enforcing HTTPS"
date: 2022-08-03T21:31:09-07:00
replyURI: "https://1mb.club/blog/https-redirects/"
replyTitle: "Consider Disabling HTTPS Auto Redirects"
replyType: "BlogPosting"
replyAuthor: "Bradley Taunt"
replyAuthorURI: "https://tdarb.org/"
---
One thing this article misses is the fact that webpages are delivered over the Web to Web browsers.

The vast majority of browsers are application runtime environments. Serving pages to users' browsers creates a software distribution platform. Serving pages in cleartext is a way to give permission to users' ISPs, network administrators, and governments to serve _their_ malware instead, under _your_ name, whether or not your page includes any scripts of your own.

People can't always choose their networks, service providers, or governments. They aren't always equipped to deal with content injection and page alteration.

This isn't a "fear-based tactic". It's an acknowledgement of our reality: networks are hostile. There are no robust measures to stop an intermediary from altering unencrypted traffic, yet there are strong incentives for all able parties to do so. That makes malware injection a perfectly reasonable concern. Moreover: multiple ISPs, including Comcast and Vodafone, have been caught [injecting JavaScript apps into unencrypted pages](https://www.infoworld.com/article/2925839/code-injection-new-low-isps.html). [Governments are no stranger to content injection](https://www.eff.org/deeplinks/2015/04/china-uses-unencrypted-websites-to-hijack-browsers-in-github-attack) either.

If you want to serve in cleartext, pick a protocol that's _not_ part of an application delivery platform. Gopher is a popular option.

---
title: "Route authorization and TLS"
date: 2022-10-29T23:24:50-07:00
replyURI: "https://community.mojeek.com/t/bgp-hijacking/400"
replyTitle: "BGP Hijacking"
replyType: "DiscussionForumPosting"
replyAuthor: "Mike"
replyAuthorURI: "https://community.mojeek.com/u/mike/"
---

Assuming we have transit encryption, the main result of Border Gateway Patrol (<abbr>BGP</abbr>) errors is mass downtime. Downtime for a typical service is a headache; downtime for a CA can be disastrous. <abbr>BGP</abbr> hijacking also enables certificate mis-issuance by messing with weak domain control validation. Route authorization is an important mitigation!

That said: <abbr>TLS</abbr> is our last line of defense against <abbr>BGP</abbr> attacks that *re-direct* HTTPS requests.

Users wouldn't have been robbed if Celer Bridge used [<abbr>HSTS</abbr> preloading](https://hstspreload.org). Victims were greeted by a <abbr>TLS</abbr> error and chose to add a security exception; a payment platform shouldn't offer that choice. <abbr>HSTS</abbr> instructs browsers to remove this option, and <abbr>HSTS</abbr> preloading prevents <abbr>HSTS</abbr> stripping (and <abbr>TLS</abbr> stripping).

HTTP Public Key Pinning (<abbr>HPKP</abbr>) makes such attacks even harder, but <abbr>HPKP</abbr> had its own list of issues preventing adoption.

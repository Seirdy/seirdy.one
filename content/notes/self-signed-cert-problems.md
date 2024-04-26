---
title: "Self signed certificate problems"
date: 2022-10-17T11:41:38-07:00
lastmod: 2022-10-17T11:41:38-07:00
replyURI: "https://web.archive.org/web/20230422173223/https://snowdin.town/notice/AOevybwoSx4xW4lX3w"
replyTitle: "self-signatures should have been treated as something normal"
replyType: "SocialMediaPosting"
replyAuthor: "Luna Saphira Dragofelis"
replyAuthorURI: "https://buff.tomboyfan.club/users/LunaDragofelis"
---
> in my opinion, self-signatures should have been treated as something normal, with a warning only triggered if the site has been visited before and the signing key has changed

Two problems with self-signed Trust On First Use (<abbr>TOFU</abbr>):

1. Long-lived secrets without a revocation mechanism. Current approaches---[<abbr>OCSP</abbr>](https://en.wikipedia.org/wiki/Online_Certificate_Status_Protocol) and [client-side <abbr>CRL</abbr> checking](https://letsencrypt.org/2022/09/07/new-life-for-crls.html)---all use the certificate authority (<abbr>CA</abbr>) system.

2. Zero defense against TLS stripping attacks during the initial connection. You need to know the connection is authentic without taking the response at its word.

You could implement revocation with your own server, but stripping attacks make it absolutely trivial for an intermediary to compromise a connection. Your initial connection is as authentic as an HTTP site, and all subsequent connections are only as secure as your initial connection. Hostile networks are increasingly the norm, so this isn't a solid foundation.

A key-pinning system only works when backed by a separate source of trust. Examples include a <abbr>CA</abbr> or <abbr title="Domain Name System Security Extensions">DNSSEC</abbr> trust anchor (for <abbr title="DNS-based Authentication of Named Entities">DANE</abbr>).

Unfortunately, HTTP Public Key Pinning never took off since admin errors could irrevocably nuke a site, and browser devs don't want <abbr>DANE</abbr> without pinning.

> banks and other sites needing higher-than-usual trust would still use authority-signed certificates

I disagree that good security should be limited to "big important players" rather than being the default behavior. "Normal" sites often feature popular interception targets such as donation links, contact methods, log-ins, etc.

If we're going to get rid of the <abbr>CA</abbr> system, we should replace it first. Tor and Yggdrasil seem like interesting alternatives, though lacking domain names.


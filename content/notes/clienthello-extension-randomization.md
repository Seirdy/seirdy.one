---
title: "ClientHello extension randomization"
date: 2023-04-02T22:20:24-07:00
---

To limit ossification, Mozilla and Google have begun randomizing the order of TLS ClientHello extensions (as of [Chromium 110](https://chromestatus.com/feature/5124606246518784) and [NSS 3.84](https://bugzilla.mozilla.org/show_bug.cgi?id=1789436)).

I see this as a nice temporary solution to limit ossification introduced by corporate (in)security measures and middleboxes, but I'm not too optimistic about its impact on the CAPTCHA hell brought about by TLS fingerprinting. Increasingly, it looks like hosting providers will just treat any statistical anomalies in their logs as hostile traffic; any variance is a cause for suspicion, when it should be treated as an invitation to make sites more robust and compatible with different user agents. I don't see Google rolling out more aggressive measures since it likely leverages similar approaches for click-fraud detection.

Current approaches to click-fraud- and bot-detection encourage homogeneity, and thus [user domestication]({{<relref "/posts/whatsapp-and-the-domestication-of-users.md">}}).

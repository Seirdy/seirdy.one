---
title: "In defense of QUIC"
date: 2022-10-24T21:58:32-07:00
replyURI: "https://deadinsi.de/@cybertailor/109226380700850932"
replyTitle: "useless standard, couldn’t care less"
replyType: "SocialMediaPosting"
replyAuthor: "jan Anja"
replyAuthorURI: "https://sysrq.in/en/"
---

I face lossy connections, and QUIC noticeably improves latency: connections establish in just one or zero round-trips and loss doesn't cause as much re-transmission. Add forward error correction and QUIC makes lossy connections *much* less painful. This isn't just for "adtech websites streaming video": the biggest beneficiaries are networks like Matrix and XMPP.

There are much bigger things to worry about regarding Google's control of standards: advertising identifiers, high-entropy client hints, etc. all rolling out *before* the Privacy Budget is what I'd rather focus on. I think there's a lot of misplaced negative attention on a transport protocol that gives tangible benefits to people with worse connections.

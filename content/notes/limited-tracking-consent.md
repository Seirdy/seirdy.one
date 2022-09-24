---
title: "Limited tracking and consent"
date: 2022-09-24T11:28:34-07:00
replyURI: "https://indieweb.social/@Chronotope/109054613809239268"
replyTitle: "if the initial collection is very limited it doesn't run afoul of the issues that should require consent"
replyType: "SocialMediaPosting"
replyAuthor: "Aram Zucker-Scharff"
replyAuthorURI: "https://aramzs.github.io/aramzs/"
---

Assuming data is a liability, how limited should data collection be to not require consent?

I think temporary storage (a week or less) of access logs combined with low-entropy binary information (dark mode, is viewport narrower than what I test with, etc) is reasonable for a small operation. This holds if the data collection is clearly documented in a privacy policy, is Tor-friendly, and obeys signals like GPC. These access logs should exclude high-entropy headers like client hints.

Larger operations should store even less since they have the means to correlate information from many sources. [ipscrub](https://github.com/masonicboom/ipscrub) comes to mind.

The only long-term storage that should happen without consent is of bot traffic.

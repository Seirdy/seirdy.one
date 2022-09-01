---
title: "Comparing screen readers"
date: 2022-09-01T09:28:07-07:00
replyURI: "https://mastodon.social/@modulux/108923799270415125"
replyTitle: "NVDA is the one to try on Windows"
replyType: "SocialMediaPosting"
replyAuthor: "David P A"
replyAuthorURI: "https://mastodon.social/@modulux"
---

On Windows, NVDA is more capable but Narrator + Edge is more secure. Narrator and Edge were designed to work without giving Narrator access to the content process, using the UI Automation API (UIA). Edge’s UIA was merged into upstream Chromium but it was only enabled in Edge. Matt Campbell wrote about it [on the orange site in January 2021](https://news.ycombinator.com/item?id=25667055); I don’t know if the situation has changed since then.

Try both. If Narrator works for you I’d stick to that. My main issue isn’t the lack of functionality, but the speech synthesizer delays (when it starts reading, the first words get dropped).

Mobile screen readers (Android TalkBack, iOS VoiceOver, KaiOS Readout) are more beginner-friendly but also much more limited.

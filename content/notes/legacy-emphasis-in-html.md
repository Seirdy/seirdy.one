---
title: "Legacy emphasis in HTML"
date: 2023-01-11T14:44:50-08:00
replyURI: "https://octodon.social/@jalefkowit/109672348277053943"
replyTitle: "who decided it would be a good idea to teach beginning web developers that &lt;B&gt; is the “Bring Attention To” tag and &lt;I&gt; is the “Idiomatic Text” tag"
replyType: "SocialMediaPosting"
replyAuthor: "Jason Lefkowitz"
replyAuthorURI: "https://jasonlefkowitz.net/"
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/ARY1Lj1vvf2mlUPbHM'
---
Going forward, the [CSS Speech Module](https://www.w3.org/TR/css3-speech/) seems like a better place for auditory tonal indicators. The CSS we've already had for years should be a better place for visual presentation.

This leaves only a minuscule semantic difference between `<i>` and `<em>`, or `<b>` and `<strong>`, as outlined in the HTML Living Standard. I don't think that difference warrants extra elements in the HTML standard: the extra elements likely create more confusion than actual benefit. Over the past decade, I'm unaware of any user-agents treating them differently enough, in a way that aligns with author intent, to matter.

I personally just avoid `<i>` and `<b>` when authoring. The complexity is more trouble than it's worth.


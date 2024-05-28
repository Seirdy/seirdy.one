---
title: "User choice and progressive enhancement"
date: 2022-06-27T14:31:21-07:00
lastMod: 2022-06-27T14:31:21-07:00
replyURI: "https://lobste.rs/s/mvw7zd/details_as_menu#c_lxwjcc"
replyTitle: "These browsers are mostly used by tech-savvy people"
replyType: "SocialMediaPosting"
replyAuthor: "Matt Campbell"
replyAuthorURI: "https://mwcampbell.us/blog/"
---
Many users who need a significant degree of privacy will also be excluded, as JavaScript is a major fingerprinting vector. Users of the Tor Browser are encouraged to stick to the "Safest" security level. That security level disables dangerous features such as:

- Just-in-time compilation
- JavaScript
- SVG
- MathML
- Graphite font rendering
- automatic media playback

Even if it were purely a choice in user hands, I'd still feel inclined to respect it. Of course, accommodating needs should come before accommodation of wants; that doesn't mean we should ignore the latter.

Personally, I'd rather treat any features that disadvantage a marginalized group as a last-resort. I prefer selectively using `<details>` as it was intended---as a disclosure widget---and would rather come up with other creative alternatives to accordion patterns. Only when there's no other option would I try a progressively-enhanced JS-enabled option. I'm actually a little ambivalent about `<details>` since I try to support alternative browser engines (beyond Blink, Gecko, and WebKit). Out of [all the independent engines I've tried](https://seirdy.one/site-design/#compatibility-statement), the only one that supports `<details>` seems to be Servo.

JavaScript, CSS, and---where sensible---images are optional enhancements to pages. For "apps", progressive enhancement still applies: something informative (e.g. a skeleton with an error message explaining why JS is required) should be shown and overridden with JS.

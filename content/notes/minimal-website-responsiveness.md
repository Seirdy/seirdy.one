---
title: "Minimal website responsiveness"
date: 2022-06-11T13:00:26-07:00
replyURI: "https://social.treehouse.systems/@ayushnix/108460135741971671"
replyTitle: "Can anyone explain why someone would want to scale font size using multiple media query breakpoints using different device widths or by using fluid typography?"
replyType: "SocialMediaPosting"
replyAuthor: "Ayush Agarwal"
replyAuthorURI: "https://microblog.ayushnix.com/"
---
My current approach to "responsiveness" is to increase the font sizes on screens. User interfaces should generally have smaller text while article bodies should prioritize readability and be larger. Default stylesheets are take a (literal) one-size-fits-all approach, trying to optimize for both. But I only use percentages for font sizes, to respect user preferences.

I also increase the default font size to make it easier to increase tap target sizes to Google's recommended 48x48&nbsp;px sizes, without overlapping other targets in a 56x56&nbsp;px radius. A size of 108.75% was the minimum necessary to achieve my goals in all combinations of major browsers and their default stylesheets across operating systems. Since scrollbars and screen edges are often tap targets, I also set minimum margin sizes.

I reduce the font size to the default 100% and eliminate the extra margins on extremely narrow screens (think KaiOS devices and smartwatches) where the screen is too small to fit several touch-friendly elements. I do the same on print.

My rationale:

- If you use a smart feature phone, then you navigate with a keypad. The interface does not need to be touch-friendly.

- If you use a smartwatch (like the Apple Watch) it should auto enable reading mode for long-form text, so compromising a _little_ on readability might be worth improving navigation.

- If you want to read in a sidebar then you are likely reading the article alongside some other text. My page's text should match most other content instead of "sticking out".

- If you print it out then font sizes are already optimized for readability rather than for user interfaces.


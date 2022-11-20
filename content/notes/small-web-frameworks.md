---
title: "Small web frameworks"
date: 2022-06-19T13:16:46-07:00
replyURI: "https://herd.bovid.space/@garbados/108505876815467986"
replyTitle: "i’m using preact like a horrible little goblin"
replyType: "SocialMediaPosting"
replyAuthor: "Diana"
replyAuthorURI: "https://garbados.github.io/my-blog/"
---
Preact is better than React for most use cases IMO. I think its small size can make it really powerful when you combine it with something like partial rehydration to make a view load instantly but reduce the time it takes to load the "interactivity" atop the static components.

When the delay between loading the static components and interactivity is small, the app feels fast. When the delay is long, it would have been better to just block the rendering in the first place. Small frameworks like Preact and Svelte shine here.

People used to think that shrinking payload sizes would become less of an issue as infrastructure improved, but the opposite thing happened with hydration-related technologies. Heh.

I still think Vanilla is the least bad option for a good chunk of web apps.

<ins datetime="2022-11-20">Update: this post was originally a reply to a Fediverse post by [@garbados@herd.bovid.space](https://herd.bovid.space/@garbados), which has since been deleted.</ins>


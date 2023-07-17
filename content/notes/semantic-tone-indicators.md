---
title: "Semantic tone indicators"
date: 2023-07-17T14:50:50-07:00
replyURI: "https://kitty.town/@gingerrroot/110713923558139130"
replyTitle: "why are people so against just using tone indicators? /g"
replyType: "SocialMediaPosting"
replyAuthor: "ginger"
replyAuthorURI: "https://kitty.town/@gingerrroot"
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AXnYXHG8hUmMSwuZRA'
---
We need semantic markup for sarcasm for the best of both worlds! Style sarcasm with <abbr>CSS</abbr> and have your client/browser indicate it to you however you prefer.

{{<mention-work itemtype="TechArticle">}}The <span itemscope="" itemtype="https://schema.org/Organization" itemprop="publisher"><abbr title="Web Accessibility Initiative">WAI</abbr>-Adapt task force</span> at the <abbr>W3C</abbr> is working on the {{<cited-work name="Help and Support Module" url="https://w3c.github.io/adapt/help/" extraName="headline">}}{{</mention-work>}} to, among many other things, annotate in markup the literal interpretation of metaphorical statements, jokes, and sarcasm so you can style and switch between them. Lots of planning, vocabulary, and proof-of-concept work is done. It'll take some years for real implementations to roll out and for it to mature; implementation-wise, they're focused on really basic stuff like adding an attribute to <abbr>HTML</abbr>.

Spending time on an <abbr>HTML</abbr> attribute sounds petty but this is the <abbr>HTML</abbr> Standard we're talking about! Every browser, e-reader, screen reader, tutorial, course, Samsung Smart Fridge (ok that last one was a joke), etc. will have to support it forever. It takes time to figure out what to do so it doesn't have to get re-done.

Once that happens, we'll need authoring tools to let people annotate sarcasm and such before posting. We'll need to normalize a "write then edit" workflow, where "edit" includes adding alt-text, semantic tone indicators, content-warnings, etc.


---
title: "Accessibility and search indexes"
date: 2022-08-02T18:06:26-07:00
---

Search engine indexes like Google, Yandex, and Bing now favor mobile-friendly sites. This has encouraged many sites to invest in mobile-friendliness. If we overlook toxic developments like Google AMP and Yandex Turbo pages, this is an example of search engines creating incentives to improve the state of the Web. Smaller indexes like Teclis and Marginalia create different incentives: they penalize tracking and toxic forms of <abbr title="Search Engine Optimization">SEO</abbr>.

I wonder how this could apply to accessibility. Currently, Google rewards the use of alt-text and penalizes small text, small tap-targets, bad link text, and missing language metadata. Rewarding alt-text has created perverse incentives to be overly descriptive, but on the whole these incentives have been helpful. Can we do better?

For starters: on searches with many results, search engines could stick to keywords that show up in both the DOM *and* significant landmarks of the accessible tree. They could gently penalize easily-detectable accessibility issues such as missing labels, landmarks, or heading-levels. Search engines that use these heuristics should develop or endorse tools to detect issues using the same logic. Automated tools only detect a tiny fraction of issues; saying "we plan to roll out more accessibility checks in the future" could get people to do more than merely meet current checks.

I also think it's worth exposing some metadata in search results to describe fixable issues. Something as simple as "This result has detectable accessibility issues: missing landmarks" with a "more info" link could go a long way.

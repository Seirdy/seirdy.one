---
title: "Accessibility audits and forced colors"
date: 2022-11-15T14:54:01-08:00
replyURI: "https://adrianroselli.com/2022/11/your-accessibility-claims-are-wrong-unless.html"
replyTitle: "Your Accessibility Claims Are Wrong, Unless…"
replyType: "BlogPosting"
replyAuthor: "Adrian Rosell"
replyAuthorURI: "https://adrianroselli.com/"
---
I love this blog post. Thank you for writing it. I must add one thing: every accessibility audit needs to **test with forced colors.** Countless sites claim to be accessible but fail this basic check.

For those less familiar: <dfn>forced colors</dfn> is a standard feature [defined in the CSS Color Adjustment Module Level 1](https://w3c.github.io/csswg-drafts/css-color-adjust-1/#forced). It overrides colors with a user-preferred palette. Implementations include Windows High Contrast Mode and Firefox on all supported desktop platforms (I'm not sure about mobile).

Forced colors reveals violations of the Web Content Accessibility Guidelines level A [success criterion 1.4.1, Use of Color](https://w3c.github.io/wcag/understanding/use-of-color.html). I use forced colors in Firefox every day, and often face issues. For examples: see [Can I Use issue 6527](https://github.com/Fyrd/caniuse/issues/6527), or [this Kagi search feedback](https://kagifeedback.org/d/611-focus-indicators-are-invisible-when-using-forced-colors)

[Section 2.3 of the CSS Color Adjustment Module](https://drafts.csswg.org/css-color-adjust/#color-scheme-override) leaves much room for non-standard user-agent-specific behavior beyond the standard forced colors. Chromium, mobile Firefox, and Samsung Internet have their own "auto dark modes" which intelligently and selectively adjust colors on light-themed websites. Testing on all these configurations is hard; forced colors is a simpler, predictable place to get started.


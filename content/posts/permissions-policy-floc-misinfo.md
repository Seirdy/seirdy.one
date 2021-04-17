---
date: "2021-04-16T17:28:06-07:00"
description: Recently, people have been telling webmasters to add a Permissions-Policy
    header to their sites to opt out of FLoC; these people don't seem to understand
    how the Permissions-Policy header works.
outputs:
  - html
  - gemtext
footnote_heading: Notes
title: "Misinformation about Permissions Policy and FLoC"
---
This post was [written in a hurry](https://www.goodreads.com/quotes/219878-a-lie-can-run-round-the-world-before-the-truth) in response to some misinformation about Google's newest Web antifeature, Federated Learning of Cohorts (FLoC). Google's FLoC is an attempt to track users even when their browsers (rightly) block third-party cookies.

A lot of misleading online discussion stems from one not-very-misleading [blog post](https://paramdeo.com/blog/opting-your-website-out-of-googles-floc-network)[^1] that's been making rounds, instructing webmasters everywhere to add the following HTTP response headers to all their pages:

```
Permissions-Policy: interest-cohort=()
```

Strictly speaking, this advice is correct; including this header will prevent your page form using Google's FLoC. What the advice misses is that the header isn't always necessary and isn't even the ideal way to prevent your page from doing nefarious things.

That advice comes from a [post by Plausible Analytics](https://plausible.io/blog/google-floc#how-to-opt-out-of-floc-as-a-web-developer-set-a-permissions-policy); the author of that post concluded that FLoC is an "opt-out" antifeature by reading the ["Opting Out of Computation" section](https://github.com/WICG/floc#opting-out-of-computation) of the WICG's FLoC README.

If you check that README yourself, you'll notice the following statement one (1) paragraph above the mention of the HTTP permission policy (emphasis mine):

> A site should be able to declare that it does not want to be included in the user's list of sites for cohort calculation. This can be accomplished via a new `interest-cohort` [permissions policy](https://www.w3.org/TR/permissions-policy-1/). This policy will be default allow. Any frame that is not allowed `interest-cohort` permission will have a default value returned **when they call `document.interestCohort()`.** If the main frame does not have `interest-cohort` permission then the page visit will not be included in interest cohort calculation.

If your website does not include JS that calls `document.interestCohort()`, it will not leverage Google's FLoC. Explicitly opting out will not change this.

As per a [post](https://web.dev/floc/) on Google's web development blog, web.dev, FLoC also will be enabled during an origin trial if the page "loads ads or ads-related resource"; i.e., anything that Chromium's [ad tagger](https://chromium.googlesource.com/chromium/src/+/master/docs/ad_tagging.md) classifies as an ad. If your website loads third-party ads, it might end up getting opted-in even if those ads don't call `document.interestCohort()`.

What explicitly opting out actually entails
-------------------------------------------

What it does do is exclude your website from being used when calcualting a user's cohort. Cohorts are calculated locally from browsing history; sites that send this header will be excluded from this calculation. This may or may not reduce the entropy gained by a FLoC ID, depending on how well or poorly your site serves as an identifier. Given this marginal improvement, I don't think it's right to place a burden or blame on webmasters that should rightfully be directed at those responsible for rolling this antifeature out in Chromium. We shouldn't expect webmasters to add a tag or header every time Google advances the war against its own users.

How Permissions Policy works
----------------------------

I don't think that every webmaster should have to read every single W3C spec. I do, however, think that people who offer prescriptive advice and interpretations of a spec should be expected to read the relevant spec first.

Here's [a copy](https://www.w3.org/TR/permissions-policy-1/) of the Permissions Policy spec. Essentially, the `Permissions-Policy` header allows a webmaster to whitelist which parties (if any) are allowed to leverage certain APIs. If I make a website that doesn't perform any geolocation directly but I load a third-party widget that does, I can forbid all parties from using Geolocation APIs by setting the following Permissions-Policy:

```
Permissions-Policy: geolocation=()
```

In other words, it provides a global override for any page contents requesting too many permissions. It's ideal for situations in which authors aren't in control of what content is being loaded.

Better advice: how not to opt-in
--------------------------------

Here's how not to opt-in to Google's FLoC:

- Don't load untrusted third-party content that might get classified as an ad (only applies during the origin trial)
- Don't call `document.interestCohort()`, and don't load third-party scripts that might call it either.

If you have to resort to adding a Permissions-Policy header to opt your site out of FLoC, it means that you've accidentally opted yourself in by including a tracking script (malware) on your page. I'd wager that opting into FLoC wasn't the only nefarious thing those scripts do; chances are they bundle a host of other fingerprinting measures.

To be extra safe, you can whitelist exactly what scripts can run with a [Content Security Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP) (CSP); seirdy.one, for instance, has a CSP that blocks all scripts, forms, frames, and third-party resources from loading.

If you're concerned about Google breaking the spec and opting you in even after you've not done so yourself, what reason do you have to believe that they'll stop there? There's nothing preventing Google from ignoring your `Permissions-Policy` header, either.

Don't tack a new header onto every request because someone read a post by someone else who read part of a GitHub README.

Take a breath
-------------

Please, don't spam maintainers of web server/backend software to tell them to include this header by default when it may or may not actually reduce user fingerprints. Don't tell webmasters that they have a _moral obligation_ to add a Permissions Policy header either.[^2] You don't need to add this permission policy to every request, just as you don't need to wear a helmet for every form of physical activity.


[^1]: This isn't the only post making rounds, but it did hit the front page of a certain orange-colored website. I'm not blaming the author; if I hadn't encountered the Permissions Policy spec earlier, I probably would have also taken the advice the author read at face-value.

[^2]: I've noticed both of these behaviors on several threads online. I've decided against linking to them because I think the discourse there has heated past the point of reason.


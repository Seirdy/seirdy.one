---
date: "2021-04-16T17:28:06-07:00"
lastmod: "2021-06-11T15:08:29-07:00"
description: Recently, people have been telling webmasters to add a Permissions-Policy
    header to their sites to opt out of FLoC. The reality of the situation isn't so
    simple.
outputs:
  - html
  - gemtext
footnote_heading: Notes
title: "Misinfo about Permissions Policy and FLoC"
---
_Update: I've amended this post with a valid reason to use the header. More info at the bottom._

This post was [written in a hurry](https://www.goodreads.com/quotes/219878-a-lie-can-run-round-the-world-before-the-truth) in response to some misinformation about Google's newest Web antifeature, Federated Learning of Cohorts (FLoC). Google's FLoC is an attempt to track users even when their browsers (rightly) block third-party cookies. The initial blog posts about this issue were quite benign, but online discussions quickly devolved into panic and support for building flawed work-arounds into upstream software. I had to write this before things got out of hand.

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

What adding this header does is exclude your website from being used when calcualting a user's cohort. A cohort is an identifier shared with a few thousand other users, calculated locally from browsing history; sites that send this header will be excluded from this calculation. The EFF estimates that a cohort ID can add up to 8 bits of of entropy to a user's fingerprint.

Being excluded from cohort calculation has a chance to place a user in a different cohort, altering a user's fingerprint. This new fingerprint may or may not have more entropy than the one derived without being excluded. Excluding some portion of sites from a user's cohort calculation doesn't necessarily make a user less unique if a nontrivial number of sites doesn't opt out.

Given this marginal improvement, I don't think it's right to place a burden or blame on webmasters when the burden and blame should rightfully be directed at those responsible for rolling this antifeature out in Chromium. We shouldn't expect webmasters to add a tag or header every time Google advances the war against its own users.

How Permissions Policy works
----------------------------

I don't think that every webmaster should have to read every single W3C spec. I do, however, think that people who offer prescriptive advice and interpretations of a spec should be expected to read the relevant spec first.

Here's [a copy](https://www.w3.org/TR/permissions-policy-1/) of the Permissions Policy spec. Essentially, the `Permissions-Policy` header allows a webmaster to whitelist which parties (if any) are allowed to leverage certain APIs. If I make a website that doesn't perform any geolocation directly but I load a third-party widget that does, I can forbid all parties from using Geolocation APIs by setting the following Permissions-Policy:

```
Permissions-Policy: geolocation=()
```

In other words, it provides a global override for any page contents requesting too many permissions. It's ideal for situations in which authors aren't in control of what content is being loaded.

Using the Permissions Policy to opt out of cohort calculation isn't really what the Permissions Policy was intended for. That doesn't seem like a big deal until you consider the history of HTTP headers being used to protect privacy.

This has happened before
------------------------

Google's non-standard usage of the Permissions Policy header to opt a site out of cohort calculation is reminiscent of the [Do Not Track (DNT) header](https://en.wikipedia.org/wiki/Do_Not_Track).

Do Not Track was a non-standard client header used to request websites not to track users. This ended up getting ignored by almost all sites it was intended to target, as adtech companies had no incentive to comply. Several websites initially obeyed the header until eventually dropping support; Reddit is a notable recent example.

Given that non-standard header usage has failed in the client-side fight against surveillance capitalism before, I'm not too optimistic about trying this again from the server side.

Better advice: how not to opt-in
--------------------------------

Here's how not to opt-in to Google's FLoC:

- Don't load untrusted third-party content that might get classified as an ad (only applies during the origin trial)
- Don't call `document.interestCohort()`, and don't load third-party scripts that might call it either.

If you have to resort to adding a `Permissions-Policy` header to opt your site out of FLoC, it means that you've accidentally opted yourself in by including a tracking script (malware) on your page. I'd wager that opting into FLoC wasn't the only nefarious thing those scripts do; chances are they bundle a host of other fingerprinting measures.

To be extra safe, you can whitelist exactly what scripts can run with a [Content Security Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP) (CSP); seirdy.one, for instance, has a CSP that blocks all scripts, forms, frames, and third-party resources from loading.

If you're concerned about Google breaking the spec and opting you in even after you've not done so yourself, what reason do you have to believe that they'll stop there? There's nothing preventing Google from ignoring your `Permissions-Policy` header, either.

Take a breath
-------------

If you want to be extra safe, you're free to add this header to your site. Just manage your expectations. However:

Please, don't spam maintainers of web server/backend software to tell them to include this header by default when it may or may not actually reduce user fingerprints. Don't tell webmasters that they have a _moral obligation_ to add a Permissions Policy header either.[^2] You don't need to add this permission policy to every request, just as you don't need to wear a helmet for every form of physical activity. Knee-jerk reactions like patching upstream software only galvanize Google to start ignoring this non-standard usage of the Permissions Policy header.

Update: a valid reason to add this header
-----------------------------------------

Some IRC discussions and a Hacker News commenter have helped me understand a valid reason to add a `Permissions-Policy` header: making a statement. Opting your site out of FLoC might not significantly improve user privacy, but it does send a clear message that you're against it.

I was initially skeptical of this justification for two reasons:

1. Google is unlikely to care if most of the non-adtech Web disabled FLoC, since they aren't Google's customers. If you work at Google, feel free to prove me wrong.
2. Most websites won't include the header, so it's unlikely to make a big difference.

However, I've changed my mind for one reason: if enough people implement this header, then anyone looking at HTTP headers will be reminded of the existence of FLoC. Making a statement like this will help spread awareness. I do maintain that effort is better spent getting users off Chromium and Chromium-dependent browsers, though.

Normally, I'd be against making a statement in response header fields; messages meant to be parsed by humans should be sent in the body instead. I'm making an exception because `interest-cohort` will likely become an official addition to the Permissions-Policy standard.

In short: FLoC is a terrible idea partly because "opting out" your site won't significantly improve users' privacy. Opt out of FLoC with the suggested header if you want to make a statement, not because you think you think you're fulfilling your moral obligation to protect your visitors. If you want to fulfill that obligation, **get them off of Chrome and Google.**


[^1]: This isn't the only post making rounds, but it did hit the front page of a certain orange-colored website. I'm not blaming the author; if I hadn't encountered the Permissions Policy spec earlier, I probably would have also taken the advice the author read at face-value.

[^2]: I've noticed both of these behaviors on several threads online. I've decided against linking to them because I think the discourse there has heated past the point of reason.


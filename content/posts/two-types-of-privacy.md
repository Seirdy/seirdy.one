---
title: "Two types of privacy"
date: 2022-06-25T15:25:14-07:00
techarticle: true
outputs:
    - html
    - gemtext
description: "\"Privacy\" can mean different things in different contexts. Tracking-reduction and tracking-evasion represent different goals with some conflict and overlap."
---
<section role="doc-preface">

<h2 id="preface">Preface</h2>

Threat modelling provides important context to security and privacy advice. Measures necessary to protect against an advanced threat are different from those effective against unsophisticated threats. Moreover, threats don't always fall along a simple one-dimensional axis from "simple" to "advanced". I appreciate seeing communities acknowledge this complexity.

When qualifying privacy recommendations with context, I think we should go further than describing threat models: we should acknowledge different types of privacy. "Privacy" means different things to different people. Even a single person may use the word "privacy" differently depending on their situation. Understanding a user's unique situation(s), _including their threat models,_ can inform us when we select the best of approach. How do we choose between reducing a footprint's _spread_ and _size?_

</section>

{{<toc>}}

<section role="doc-introduction">

Intro&shy;duction {#introduction}
-----------------

I highlight two main approaches to privacy: "tracking reduction" and "tracking evasion".


<dfn itemprop="teaches">Tracking reduction</dfn> (<abbr title="Tracking Reduction">TR</abbr>)
: TR aims to reduce the amount of data collected about an exposed user. It reduces a footprint's _spread_ primarily by blocking trackers. Sometimes this can increase the size of a footprint.

<dfn itemprop="teaches">Tracking evasion</dfn> (<abbr title="Tracking Evasion">TE</abbr>)
: TE reduces the amount of data exposed by a user. Rather than eliminating data collection itself, TE prevents useful data from being made available in the first place. In other words, it reduces a footprint's _size._[^1]

There is gray area between these two extremes, and not every privacy measure falls neatly into one of these two categories. I'll address that later in this article.

<p role="note">Note: this article focuses primarily on Web browsers; however, its concepts can apply to any software capable of tracking users.</p>

Let's get started:

</section>

Tracking reduction (TR)
-----------------------

<abbr title="Tracking Reduction">TR</abbr> is suitable for casual threat models. These techniques typically aim to remove trackers or to block malicious traffic.

If someone just wants to browse the web with less tracking, they're probably not expecting a "nuclear option" that removes all their personalization. That user is more likely to concerned with manipulation by personalized ads, or something vague such as being "followed around" as they browse websites while signed out.

These users are likely okay with being identified by a site; several of their accounts are probably linked to the same identity. However, when they log into "example.com", they'd rather not ping trackers from "facebook.com" or "amazon-adsystem.com".

Of course, data-sharing could happen on the backend. Users may accept that there's little they can do about this beyond reading a privacy policy and filing suit upon violations.

In other words, TR falls closer to "wants" on the (somewhat contrived) "wants versus needs" spectrum. It addresses the gray area between personal preferences and real present threats. Our goal is to reduce tracking where we can, without significantly degrading the user experience.

### Sample TR techniques

- Badness enumeration: content-blocking and firewalls.

- Sending headers such as [Global Privacy Control](https://globalprivacycontrol.org/) or [Do Not Track.](#dnt)

- Opting out of tracking when given the choice.

- Exercising legal rights (e.g., rights granted under the [GDPR](https://en.wikipedia.org/wiki/General_Data_Protection_Regulation) or [CCPA](https://en.wikipedia.org/wiki/California_Consumer_Privacy_Act)) to remove information.

- Having a preference for services whose privacy policies indicate less data collection and/or sharing.

- Turning off telemetry.

### Attack surface

I mentioned content-blocking, which typically happens through browser extensions and/or third-party filter lists. These can add attack surface; be mindful of the trade-off. Even [trusted extensions like uBlock Origin are no exception;](https://portswigger.net/research/ublock-i-exfiltrate-exploiting-ad-blockers-with-css) exercise restraint when adding third-party filter lists.

I covered this topic a bit more in {{<mention-work itemtype="BlogPosting">}}{{<cited-work name="A layered approach to content blocking" url="../../04/layered-content-blocking/">}}{{</mention-work>}}. Safe yet limited approaches to content filtering should lay a foundation, topped off by risky yet powerful approaches that users selectively enable.

Tracking evasion (TE)
---------------------

<abbr title="Tracking Evasion">TE</abbr> prevents an adversary from collecting meaningful information tied to one's identity. Unlike "opting-out" and blocking known well-known third-party trackers, tracking evasion _distrusts all parties by default._ This approach assumes that tracking is equally likely to happen through both first-party and third-party trackers.

Therefore, a list of known third-party trackers is irrelevant to tracking evasion. Users following this approach in its purest form _treat every party capable of tracking as a hostile tracker._

TE techniques typically revolve around minimizing the size of one's fingerprint, either through fingerprint normalization or randomization.[^2]

### Sample TE techniques

- Using the Tor Browser.

- Avoiding identifiable browser extensions.

- Randomizing typing behavior (A good example is [kloak, a keystroke anonymizer used by Whonix](https://github.com/Whonix/kloak)).

- [Using a coarse scroll interval.](https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/40704)

### Half-measures are ineffective

If an adversary employs multiple fingerprinting vectors, then normalizing or randomizing a small subset of those vectors might make a user stand out even more.

{{< transcribed-image type="comic" id="xkcd-1105" >}}

#### <span itemprop="name">xkcd comic: license plate</span> {#infinite-scrolling}

{{< transcribed-image-figure id="xkcd-1105" has-transcript="true" >}}

{{< picture name="xkcd_1105" alt="Comic: a license plate that's hard to read will be read more carefully by an adversary." >}}

<figcaption itemprop="caption">

A difficult-to-read licence plate number will stand out, putting the owner at risk. Similarly, TE half-measures could make users more easily identifiable. From <a itemprop="url" href="https://xkcd.com/1105/">xkcd</a>

</figcaption>
{{< /transcribed-image-figure >}}
{{< transcribed-image-transcript >}}

Cueball is walking in from the right holding a license plate up with both hands for an off-panel Megan to see. It is possible to see the plate, but here it looks like all I's (or 1's).


Cueball
: Check out my personalized license plate!

Megan (off-panel)
: "1I1-III1"?

Cueball
: It's perfect!

Cueball
: No one will be able to correctly record my plate number!

Cueball
: I can commit any crime I want!

Megan
: Sounds foolproof.

Soon, at a crime scene:


Witness
: The thief's license plate was all "1"s or something.

Police officer 1
: Oh. <i>That</i> guy.

Police officer 2
: His address is on a post-it in the squad car.

<p role="doc-credit">Transcript based on the <a href="https://explainxkcd.com/1105/#Transcript">explain xkcd wiki entry for xkcd #1105</a>.</p>

{{< /transcribed-image-transcript >}} {{< /transcribed-image >}}

TE carries the risk of "springing a leak". While TR presents an incremental solution, TE is much harder: it's only a slight exaggeration to describe TE as a binary "all-or-nothing" approach.

#### Other relevant discussions worth reading

- [Arkenfox user.js issue 1274: Effort towards a common browser fingerprint](https://github.com/arkenfox/user.js/issues/1274)
- [PrivacyGuides discussion 374: Great browser re-write-reboot](https://github.com/privacyguides/privacyguides.org/discussions/374)

Conflicts between TR and TE
---------------------------

Good approaches to TR often weaken TE. Conflating the two can have harmful consequences.

### Badness enumeration: content blocking

While content blocking through badness enumeration is useful for TR, it's generally antithetical to TE. A website can use a first-party script and/or inspect server logs to determine information such as:

- Which network requests succeed or fail.

- Whether certain elements (e.g. certain images) load successfully.

- Whether injected content (e.g. from an ad-blocker) is present.[^3]

- Whether content-blocking changes which elements are in or near the viewport.[^4]

These pieces of information (and others I haven't included) can tell a website if a browser has a content-blocker, and which filters a user has enabled. The latter piece of information can uniquely identify a user; this compromises TE. Nonetheless, these techniques aren't in widespread use. I think that sharing first-party fingerprinting data between different organizations is the exception rather than norm. As long as this is the case, content-blocking remains a viable technique for TR.

Badness enumeration shouldn't be applied in a TE context. The [Tor Browser's design philosophy](https://2019.www.torproject.org/projects/torbrowser/design/#philosophy) explicitly includes a "no filters" directive and recommends against their use, to reduce fingerprinting. As of mid-2022, the version of the Tor Browser included in [Tails](https://tails.boum.org/) includes a content-filtering extension anyway. The entire point of using the Tor Browser Bundle is to maximize TE; Tails compromises this goal.

Brave has a similar problem. Its content-blocker allows users to create custom filters or activate additional filter lists. Brave also tries to enable TE through fingerprint-randomization. Combining the two likely makes users even more unique. Brave could mitigate this flaw by having its "advanced" level of fingerprinting protection also normalize the content-blocking filters applied.[^5]

### Do Not Track (DNT) {#dnt}

<abbr title="Do Not Track">DNT</abbr> was an HTTP request header indicating that a user does not wish to be tracked. Unfortunately, unlike [Global Privacy Control](https://globalprivacycontrol.org/), there was no legal obligation to obey DNT. The DNT header ended up being used as a fingerprinting vector to track users instead of a way for them to avoid tracking.

[WebKit removed DNT support](https://webkit.org/tracking-prevention/#anti-fingerprinting) because it was antithetical to TE, and its utility for TR was too low to justify these harms.

Exceptions and overlap
----------------------

There is grey area between TE and TR. Some techniques don't neatly fit into one of the two categories. Here's an incomplete list of those techniques, for illustrative purposes:


Disabling browser features
: The fingerprintability of disabling JavaScript, the [Reporting API](https://w3c.github.io/reporting/), and [hyperlink auditing](https://html.spec.whatwg.org/multipage/links.html#hyperlink-auditing) is typically dwarfed by the the fingerprinting made possible by enabling them. I struggle to categorize this technique. On one hand, feature-toggles represent uncommon browser configuration that may prevent some trackers from running (TR); on the other, it treats all external parties equally and can reduce fingerprinting vectors (TE). I'm inclined to say that feature-disabling is closer to TE than TR only if enough people share the same configuration.[^6]

Goodness enumeration
: Assuming that all actors are actively hostile might be overkill. A user may follow a TE approach and/or disable browser features, while also maintaining a list of trusted exceptions. Trusted sites may use disabled features or have access to a larger fingerprint. This represents a "middle ground" of sorts between the convenience of TR and the effectiveness of TE.

Amnesia
: The most common amnesiac technique is clearing cookies. A more thorough technique is [using a disposable VM](https://www.whonix.org/wiki/Qubes/Disposables) that's erased and re-created between sessions. Rather than reduce or evade tracking, these measures reduce the persistence of trackers (and/or malware) that slip through other defenses.

The list goes on. "TR versus TE" is an important perspective to have, but it isn't the only lens through which we should view privacy-enhancing techniques. Let's be mindful the TR/TE framework's limitations.

How to make privacy recommen&shy;dations {#how-to-make-privacy-recommendataions}
----------------------------------------

Privacy-enhancement recommendations need to account for whether a preference for TR over TE exists. Whenever applicable, please do the following:

- Clarify if a privacy-enhancing technique has a focus on TR or TE.
- When discussing TR techniques, mention any compromises made from a TE perspective.

Most importantly: recognize that different people need to make different trade-offs. Someone with special needs might require some fingerprintable personalizations. If non-negotiable personalizations make tracking-evasion too difficult, you might need to steer the person towards tracking-reduction and explain the trade-offs involved.[^7]

A single solution isn't enough for everyone. In fact, it's not usually enough for an individual. An individual may switch between multiple tasks, each with a different list of acceptable trade-offs.

For example, you can encourage people to use multiple browsers and browser-profiles for different needs. Users could use a "TR browser" to sign into their school or work accounts, but use a "TE browser" to browse anonymously.

Personally: my "main" browser is a heavily personalized Firefox that trades away some security and privacy; where possible, it employs TR. I browse anonymously in the Tor Browser with "Safest" mode enabled to achieve TE, or using the "Safer" mode in Whonix. Finally, I use certain web apps in Chromium without any privileged extensions: this trades both convenience and privacy for some forms of security.

### Threat modelling

Threat modelling is critical when deciding whether <abbr title="Tracking Reduction">TR</abbr> or <abbr title="Tracking Evasion">TE</abbr> is relevant, and how far one must go to achieve TE. It's slightly less relevant when it comes to deciding which TR techniques are effective. This is because TR involves less advanced threat models and addresses needs that blur the lines between security, privacy, and convenience.

Rather than framing discussions explicitly in terms of threats, it makes more sense to frame a TR technique in terms of what the technique improves and worsens regarding privacy, security, and convenience. Take what you can get until things get annoying; save extreme measures for a different browser or browser-profile.

Threat modelling does make sense whenever security trade-offs come into play. It's relevant when evaluating security trade-offs of TR techniques involving privileged extensions.

Conclusion
----------

Communities are starting to understand that recommendations should be made in the context of threat models, and that security- and privacy-related goals are different despite having significant overlap.

People are complex creatures. When recommending techniques to improve privacy, we should remember that different people have different goals. Moreover, an individual's goals may vary depending on the situation.

Our recommendations need to take into account the fact that "privacy" means different things to different people. Techniques that aid in tracking-reduction might weaken tracking-evasion. The latter is much more powerful, but it's also not necessarily what everyone is looking for.

<section role="doc-acknowledgments">

Ack&shy;nowledge&shy;ments {#acknowledgements}
--------------------------

My article could be considered a "derivative work" of {{<mention-work itemtype="Article" itemprop="citation" role="doc-credit">}}{{<cited-work name="Recommending Tools" url="https://sec.eff.org/articles/recommending-tools">}} by <span itemscope="" itemtype="https://schema.org/Organization" itemprop="publisher">the EFF</span>{{</mention-work>}}. That article laid the foundations for my thought process.

This article is an expansion of the ideas I presented in the microblog entry {{<mention-work itemtype="SocialMediaPosting">}}{{<cited-work name="On tracker blocking" url="../../../../../notes/2022/06/06/on-tracker-blocking/">}}{{</mention-work>}}. That microblog entry was a response to the article {{<mention-work itemtype="Article" itemprop="citation" role="doc-credit">}}{{<cited-work name="Browser Tracking" url="https://madaidans-insecurities.github.io/browser-tracking.html">}} by {{<indieweb-person name="Madaidan" url="https://madaidans-insecurities.github.io/">}}{{</mention-work>}}; this article's coverage of TE draws from that article.

</section>


[^1]: I'd have liked to call this "Tracking prevention". Unfortunately, that name is taken by a Firefox feature aiming to achieve tracking reduction. Naming things is difficult.

[^2]: I haven't seen much research comparing these two approaches, but I'm not convinced they're in conflict. Normalizing all vectors that can be normalized but randomizing the rest sounds like a decent strategy. At least, as long as users don't significantly adjust _which_ vectors are normalized or randomized.

[^3]: Sites can detect injected content even without scripts by using Content-Security-Policy reporting APIs. For this reason, uBlock Origin includes a preference to disable all CSP reports. That being said, sites can still use first-party scripts to do the same.

[^4]: This is possible without any JavaScript, using lazy-loading directives. Browsers like Firefox disable lazy-loading if JavaScript is also disabled via `about:config`, to mitigate this. If JavaScript is enabled, assume this is always a possibility.

[^5]: This does present a new issue: filter lists need to get updated at a different cadence than the browser. Not everyone updates at the same time. Imagine that a given browser version at a given time has <var>V</var> versions of a filter list in use across a user-base. Users have <var>N</var> different filters enabled. That's <var>V</var>×<var>N</var> possible combinations. I'm over-simplifying; the point is that filter lists enabled could add significant entropy to a user's fingerprint, and that's before you involve custom filters.

    We could reduce the number of combinations by combining all the filter lists into a single list that gets updated all at once. When <var>N</var>=1, we're at just <var>V</var> possible combinations. Updates could be spread out over a longer cadence, decreasing the value of <var>V</var>.

[^6]: Torbutton aims to allow many Tor Browser users to share the same configuration. See its [security settings](https://tb-manual.torproject.org/security-settings/) and [the preferences they change](https://gitweb.torproject.org/torbutton.git/tree/modules/security-prefs.js).

[^7]: Users of metered connections may need to block large elements. Users with accessibility needs may need to alter inaccessible pages. Users who don't speak a page's language may need to use machine translation.[^8] Telling users to just "stop doing this" would be arrogant, yet all three of these examples are fingerprintable.

[^8]: Copying page text and pasting it into a separate translation tool could help, but it's not always a replacement for full-page translation. [Machine translation uses semantic HTML](https://seirdy.one/posts/2020/11/23/website-best-practices/#machine-translation), and plain-text translation often provides worse results. (ooh, is this my first footnote within a footnote?)



---
date: "2021-01-27T16:13:36-08:00"
lastmod: "2021-12-13T15:26:03-08:00"
description: WhatsApp's rise and recent PR efforts highlight a class of business models that I call "user domestication".
footnote_heading: References and endnotes
outputs:
    - html
    - gemtext
tags:
    - free software
    - user domestication
    - privacy
    - platforms
featured: 3
image: "whatsapp_ad_dark.png"
image_alt: "WhatsApp PR notice describing data not collected; analysis in article."
title: WhatsApp and the domestication of users
---
<section role="doc-introduction">

Intro&shy;duction {#introduction}
-----------------

<p role="note">
<em>Update: I wrote a follow up: <a href="../../../../2021/02/23/keeping-platforms-open/">Keeping platforms open</a>. Check it out if you found this article interesting.</em>
</p>

<p itemprop="backstory">
I have never used WhatsApp, and never will. Despite this, I still feel the need to write an article about WhatsApp since it’s the perfect case study to help understand a class of businesses models I call “user domestication”. The domestication of users is high on my list of problems plaguing the human race, and is worth a detailed explanation.
</p>

WhatsApp wasn't the first instant messenger of its kind, and probably won't be the last. I simply chose to focus on WhatsApp since its recent privacy issues have made it a hot topic.

With the meta-explanation out of the way, let us begin.

</section>

WhatsApp's rise {#whatsapps-rise}
--------------------

For those unfamiliar, WhatsApp is a tool that makes it convenient and easy to help Facebook further its core mission: the optimization and auctioning of human behavior (colloquially known as "targeted advertising"). It originally persuaded people to consent to this by allowing them to send text to each other over the Internet, something that was [already possible](https://en.wikipedia.org/wiki/Comparison_of_instant_messaging_protocols), and combining an easy-to-learn UI with successful marketing. It then expanded to include features such as free voice and video calls. Free calls helped it grow to become the de-facto communication platform in many regions. I'm stunned at its ubiquity every time I visit my extended family in India; I'm frequently greeted by looks of confusion when I remind them that I don't use WhatsApp.

Having its own proprietary chat system incompatible with other clients allowed WhatsApp to build a [network effect](https://en.wikipedia.org/wiki/Network_effect): WhatsApp's existing users were held captive by the fact that leaving WhatsApp meant losing the ability to communicate with WhatsApp users. People switching from WhatsApp must convince all their friends to switch, too; this includes less technically inclined friends who had a hard time learning WhatsApp in the first place.

In a WhatsApp world, people who want to keep in touch must abide by the following rules:

- Everyone can only use the proprietary WhatsApp client to send messages; developing alternative clients isn't supported.
- Everyone's mobile device must run an operating system supported by said client. Since WhatsApp developers will only write a client for popular operating systems, the Android and iOS duopoly strengthens.
- Users fully depend on WhatsApp developers. If WhatsApp developers decide to include user-hostile features in the app, users must go with it. They can't switch to a different server or client without switching away from WhatsApp and losing the ability to communicate with all their WhatsApp contacts.

User domestication
------------------

WhatsApp rose by trapping previously-free beings in their corral and changing their habits to create dependence on masters. Over time, this made it difficult or impossible to return to their previous lifestyle. That process should sound familiar: it's eerily similar to the domestication of animals.

I call this type of vendor lock-in <dfn id="user-domestication-dfn">user domestication</dfn>: the removal of user autonomy to trap users into serving vendors.

I chose this metaphor because animal domestication is a gradual process that isn't always deliberate, and typically revolves around one group becoming dependent upon another. For example: there's evidence that domestication of dogs began with socialization, resulting in not-entirely-artificial selection promoting genes that resulted in more friendliness with and dependence upon humans.[^1]

Whether it happens on purpose or by accident, user domestication almost always follows the same three steps:

1. A high level of dependence given from users to a software vendor
2. An inability for users to control their software, through at least one of the following methods:
   1. Preventing modification of the software
   2. Preventing migration onto a different platform
3. The exploitation of now-captive users who are unable to resist

The completion of the first two steps left WhatsApp users vulnerable to user domestication. With investors to answer to, they had every incentive to implement user-hostile features without consequence.

So, of course, they did.

WhatsApp's descent
------------------

Domestication has a purpose: it enables a master species to exploit the domesticated species for its own gain.

Recently, WhatsApp updated its privacy policy to allow sharing data with its parent, Facebook. Users who agreed to use WhatsApp under its previous privacy policy had two options: agree to the new policy or be unable to use WhatsApp again. The WhatsApp privacy policy update is a classic bait-and-switch: WhatsApp lured users in with a sleek interface and the impression of privacy, domesticated them to remove their autonomy to migrate, and then backtracked on its previous commitment to privacy with minimal consequence. Each step in this process enabled the next; had user domestication not taken place, it would be easy for most users to switch away with minimal friction.

Those of us who were sounding the alarm a few years ago experienced a brief moment of sadistic bliss when our titles were upgraded from "annoying and paranoid conspiracy theorists" to just "annoying".

### An attempt at damage control

The bait-and-switch operation incurred backlash significant enough for a noticeable minority of users to actually migrate; this number turned out to be slightly more than the rounding error WhatsApp was likely expecting. In response, WhatsApp delayed the change and published an ad to improve its image.

{{<transcribed-image id="whatsapp-notice">}}

#### <span itemprop="name">Whatsapp Ad</span> {#whatsapp-notice-hd}

{{< transcribed-image-figure id="whatsapp-notice" has-transcript="true" >}}

{{< picture name="whatsapp_ad" alt="WhatsApp notice describing data not collected." >}}

<figcaption itemprop="caption">

WhatsApp ad, taken from <span itemprop="encodesCreativeWork" itemscope="" itemtype="https://schema.org/WebPage">{{<cited-work name="Answering your questions about WhatsApp’s Privacy Policy" url="https://faq.whatsapp.com/general/security-and-privacy/answering-your-questions-about-whatsapps-privacy-policy">}} (archived: <a href="https://web.archive.org/web/20210121163337/https://faq.whatsapp.com/general/security-and-privacy/answering-your-questions-about-whatsapps-privacy-policy" itemprop="archivedAt">Wayback Machine <time datetime="2021-01-21T16:33:37+00:00">2021-01-21</time> snapshot</a>)</span>

</figcaption>
{{< /transcribed-image-figure >}}
{{< transcribed-image-transcript >}}

WhatsApp Protects and Secures Your Personal Messages.

- WhatsApp cannot see your personal messages or hear your calls and neither can Facebook.

- WhatsApp does not keep logs of who everyone is messaging or calling.

- WhatsApp cannot see your shared location and neither can Facebook.

- WhatsApp does not share your contacts with Facebook.

- WhatsApp groups remain private.

- You can set your messages to disappear.

- You can download your data.

{{< /transcribed-image-transcript >}} {{< /transcribed-image >}}

The ad lists various data that WhatsApp doesn't collect or share. Allaying data collection concerns by listing data _not_ collected is misleading. WhatsApp doesn't collect hair samples or retinal scans either; not collecting that information doesn't mean it respects privacy because it doesn't change the information WhatsApp _does_ collect.

The ad denies "keep[ing] logs of who everyone is messaging or calling". Collecting data is not the same as "keeping logs"; it's possible for metadata to be fed into an algorithm before being discarded. A model can thus learn that two users call each other frequently without keeping logs of the metadata for each call. The fact that they specifically chose to phrase this line around logging implies that WhatsApp either already collects this class of data or has deliberately left the door open to collecting it in the future.

A stroll through WhatsApp's [actual privacy policy](https://web.archive.org/web/20210124061525/https://www.whatsapp.com/legal/updates/privacy-policy/?lang=en) at the time reveals that they do collect considerable metadata used for marketing through Facebook.

Software freedom
----------------

With user domestication, providing useful software to users is a means to the end of exploiting them. The alternative is simple: make serving users the end in and of itself.

To avoid being controlled by software, users must be in control. Software that allows users to be in control is called [free software](https://en.wikipedia.org/wiki/Free_software) or libre software. The word "free" in this context refers to freedom rather than price. Software freedom is similar to the concept of open-source; the latter is an offshoot of the former focused on more business-friendly practical benefits rather than ethics. A less ambiguous term that neutrally refers to free, libre, and open-source software is **<abbr title="free, libre, and open-source software">FLOSS</abbr>**.[^2]

Others have explained the [fundamental concepts](https://www.gnu.org/philosophy/free-sw.en.html) underpinning free software and [its importance](https://www.gnu.org/philosophy/free-software-even-more-important.html) better than I can, so I won't go into detail. It comes down to four essential freedoms:

- The freedom to run the program as you wish, for any purpose
- The freedom to study how the program works, and change it so it does your computing as you wish
- The freedom to redistribute copies so you can help others
- The freedom to distribute copies of your modified versions to others

### Making money with FLOSS

The most common objection I hear is that FLOSS makes it harder to make money.

The key to making money with FLOSS is to make software a [commoditized complement](https://www.gwern.net/Complement) of other, more profitable services. Examples of such services include selling support, customization, consulting, training, managed hosting, hardware, and certifications. Plenty of companies use this approach instead of building proprietary software: Red Hat, Collabora, System76, Purism, Canonical, SUSE, Hashicorp, Databricks, and Gradle are some names that come to mind.

Managed hosting isn't a basket worth all your eggs if giants like AWS can do the same at a lower price. Being the developer can give an edge in areas like customization, support, and training; it doesn't offer as obvious an advantage when it comes to hosting.

FLOSS isn't always enough
-------------------------

Free software is a necessary but sometimes insufficient requirement to build domestication immunity. Two more measures include **simplicity** and **open platforms.**

### Simplicity

When software grows too complex, it needs to be maintained by a large team. Users who disagree with a vendor can't easily fork and maintain a multi-million-line codebase, especially if the software in question potentially contains security vulnerabilities. Dependence on the vendor can grow quite problematic when complexity causes development costs to skyrocket; the vendor might resort to implementing user-hostile features to stay afloat.

Complex software that can't be developed by a different group of people creates dependence, step one of user domestication. That alone is enough to open the door to problematic developments.

#### Case study: Mozilla and the Web

Mozilla was a ray of hope in the browser wars, a space dominated by adtech, surveillance, and vendor lock-in. Unfortunately, developing a browser engine is a monumental task difficult enough for Opera and Microsoft to give up and re-skin Chromium. Browsers are more than the document readers they were meant to be: they've evolved into application runtimes with their own stacks for GPU acceleration, Bluetooth, permissions, device enumeration, bundled media codecs, <abbr title="digital rights management">DRM</abbr>[^3], extension APIs, developer tools...the list goes on. It takes billions of dollars a year to respond to vulnerabilities in such a massive attack surface and keep up with a standard that grows at such a worrying rate. Those billions have to come from somewhere.

Mozilla ended up having to make major compromises to stay afloat. It cut search deals with blatantly user-hostile companies, and bundled the browser with [ads](https://blog.mozilla.org/advancingcontent/2014/02/11/publisher-transformation-with-users-at-the-center/) and bloatware such as a partially ad-funded proprietary bookmarking SaaS called [Pocket](https://dustri.org/b/firefox-youre-supposed-to-be-in-my-pocket-not-the-other-way-around.html). Since acquiring Pocket (to diversify its sources of income), Mozilla hasn't yet delivered on its [earlier statements](https://techcrunch.com/2017/02/27/mozilla-pockets-pocket-in-first-acquisition/) saying it would open-source its code: while the clients have been open-sourced, the server code remains proprietary. Open-sourcing this and re-writing portions if necessary would understandably be a large task due in part to Pocket's complexity.

Substantial forks such as Pale Moon are unable to keep up with the growing complexity of modern Web standards such as Web Components. In fact, Pale Moon recently had to [migrate its code off of GitHub](https://forum.palemoon.org/viewtopic.php?f=1&t=25473) since GitHub began using Web Components, a feature too complex for Pale Moon to support. It's nigh-impossible to start a new browser from scratch and catch up with behemoths that have been running on ridiculous annual sums for decades. Users can pick between a browser engine developed by Mozilla, an adtech company (Blink by Google), or a walled-garden vendor (WebKit by Apple). WebKit doesn't seem too bad, but users will be helpless if Apple ever decides to backtrack.

To summarize: the complexity of the Web platform forced Mozilla, the only browser engine developer claiming to serve "people, not profit", to implement user-hostile features in its browser. The Web's complexity has left users with limited choice between three big players with conflicts of interest whose positions grow more entrenched with time.

For the record, **I don't think Mozilla is a bad organization;** rather, I think it's surprising that they're able to do so much without further compromise in a system that practically requires it. Their core product is still FLOSS, and very lightly patched third-party builds remove antifeatures.

### Open platforms

To prevent a network effect from turning into vendor lock-in, software that naturally encourages a network effect needs to be part of an open platform. In the case of messaging software, it should be possible to make alternative clients and servers that are compatible with each other to prevent completion of user domestication's first two steps.

#### Case study: Signal

Ever since a certain car salesman [tweeted](https://web.archive.org/web/20210108024414/https://nitter.net/elonmusk/status/1347165127036977153) "Use Signal", large numbers of users have been obediently switching. At the time of writing, the Signal clients and servers are FLOSS and use some of the best <abbr title="end-to-end encryption">E2EE</abbr> out there; however, I'm not a fan.

Although Signal's clients and servers are FLOSS, Signal is still a closed platform. Signal co-founder Moxie Marlinspike is quite critical of open and federated platforms, describing his rationale for keeping Signal a closed platform in [a blog post](https://signal.org/blog/the-ecosystem-is-moving/).[^4] This means that there's no supported way to develop an alternative server that's supported by Signal clients, or an alternative client that supports Signal servers. Step one to user domestication is nearly complete.

In addition to there being a single client and server implementation, there's only one Signal server provider: Signal Messenger LLC. Users' dependence on this central server provider blew up in their faces when Signal's recent growth caused downtime for over a day, rendering every Signal user unable to send messages until the single vendor fixed the issue.

People still tried to develop alternative clients: a Signal fork called [LibreSignal](https://github.com/LibreSignal/LibreSignal) attempted to make Signal work on privacy-friendly Android builds without proprietary Google Play Services. That fork shut down after Moxie [made it clear](https://github.com/LibreSignal/LibreSignal/issues/37#issuecomment-217211165) that he wasn't okay with a third-party app using Signal's servers. Moxie's decision is understandable, but the situation could have been avoided if Signal didn't have to rely on a single server provider.

If Signal decides to update its apps to include a user-hostile feature, users will be just as helpless as they now are with WhatsApp. Although I don't think this is likely, Signal's closed platform leaves users vulnerable to user domestication.

Despite not liking Signal, I still recommended it to my non-technical friends because it was the only messenger private enough for me and simple enough for them. If it had literally any onboarding (account creation, manually adding contacts, etc.), one of my friends would have stuck with Discord or WhatsApp. I'd say something cheeky like "you know who you are" if there was any chance he'd make it this far in the article.

Food for thought
----------------

Both of the prior two case studies---Mozilla and Signal---are examples of well-meaning organizations unintentionally leaving users vulnerable to user domestication. The former represents a lack of simplicity but the presence of an open platform. The latter represents a closed platform with a higher degree of simplicity. Intent isn't in the picture when examining the three steps and countermeasures to user domestication.

paulsnar pointed out a potential conflict between simplicity and open platforms:

> I feel like there's some tension between simplicity and open platforms; to take Signal, in a way it's simple precisely because it's a de-facto-closed platform, or at least so Moxie has argued. In turn, Matrix is superficially simple, but the protocol is actually (imho) fairly complex exactly because it's an open platform.

I don't have a simple answer to this dilemma. It's true that [Matrix](https://matrix.org/) is extremely complex (compared to alternatives such as IRC or even [XMPP](https://xmpp.org/)), and it's true that it's harder to build an open platform. That being said, it's certainly possible to keep complexity on a leash while developing an open platform: Gemini, IRC, and email are examples. While email standards aren't nearly simple as Gemini and IRC, they evolve slowly; this keeps implementations from having to play catch-up the way Web browsers and Matrix clients/servers do.

Not all software needs to rake in billions. Federation [allows](https://drewdevault.com/2020/09/20/The-potential-of-federation.html) services and networks like the Fediverse and XMPP to scale up to large numbers of users without forcing a single behemoth to sell its soul to foot the bill. Although anti-domestication business models are less profitable, they still allow the creation of the same technologies that were enabled by user domestication. All that's missing is an advertising budget; the biggest advertising some of these projects get is long unpaid blog posts.

Maybe we don't need to chase growth and try to "make it big". Maybe we can stop after achieving sustainability and financial security, and make it possible for people to do more with less.

Closing notes
-------------

Before it turned into a manifesto of sorts, this post was intended to be an expanded version of a comment I left under a [Fediverse post](https://fosstodon.org/@binyamin/105608407071699797) by [Binyamin Green](https://binyam.in/).

I initially decided to expand it to its current form for personal reasons. Nowadays, people demand a thorough explanation every time I refuse to use something that "everybody" uses (WhatsApp, Microsoft Office, Windows, macOS, Google Docs...). They'll usually ignore the explanation, but they expect one anyway. By the next time I meet them, they'll have forgotten our prior conversation and will re-enact the same dialogue again. Justifying all my life choices by sending logically correct statements into the void---knowing that everything I say will be ignored---is an emotionally draining process that has taken a toll on my mental health for the past few years; sending my friends this article and changing the subject should save me a few gray hairs in the years to come.

This article extends the guiding philosophies of the Free Software and Copyleft movements. Thanks to [Barna Zsombor](https://bzsombor.web.elte.hu/) for giving good feedback over IRC.

Since 2900 words wasn't quite enough, I wrote a follow-up: [Keeping platforms open](../../../../2021/02/23/keeping-platforms-open/). Check it out if you found this article interesting.

Translations
------------

Translations are always welcome.

- {{<mention-work itemprop="workTranslation" itemtype="BlogPosting">}}{{<indieweb-person itemprop="author" first-name="Евгений" last-name="Кузнецов" url="https://evgenykuznetsov.org/">}} translated this article to <span itemprop="inLanguage">Russian</span>: {{<cited-work lang="ru" rel="alternate" url="https://evgenykuznetsov.org/posts/2021/domestication/" name="WhatsApp и одомашнивание пользователей">}}{{</mention-work>}}.

- {{<mention-work itemprop="workTranslation" itemtype="BlogPosting">}}The Framalang translators at [Framasoft](https://framasoft.org/) translated this article to <span itemprop="inLanguage">French</span>: {{<cited-work lang="fr" rel="alternate" url="https://framablog.org/2021/02/04/utilisateurs-libres-ou-domestiques-whatsapp-et-les-autres/" name="WhatsApp et la domestication des utilisateurs">}}{{</mention-work>}}.

- {{<mention-work itemprop="workTranslation" itemtype="BlogPosting">}}{{<indieweb-person itemprop="author" nickname="Licaon Kter" url="https://web.archive.org/web/20210924154338/https://convorb.im/">}} translated this article to <span itemprop="inLanguage">Romanian</span>: {{<cited-work lang="ro" rel="alternate" url="https://web.archive.org/web/20210924154306/convorb.im/post/2021/02/14/whatsapp-si-domesticirea-utilizatorilor.html" name="WhatsApp și domesticirea utilizatorilo">}}{{</mention-work>}}.

- {{<mention-work itemprop="workTranslation" itemtype="BlogPosting">}}{{<indieweb-person itemprop="author" first-name="David" last-name="Jimenez" url="https://sgfault.com">}} translated this article to <span itemprop="inLanguage">Spanish</span>: {{<cited-work lang="es" rel="alternate" url="https://sgfault.com/post/2021/02/2021-02-21-whatsapp-y-la-domesticacion-de-usuarios/" name="WhatsApp y la domesticación de usuario">}}{{</mention-work>}}.

- {{<mention-work itemprop="workTranslation" itemtype="BlogPosting">}}{{<indieweb-person itemprop="author" nickname="Skariko" url="https://www.lealternative.net/author/skariko/" org="Le Alternative" org-url="https://lealternative.net/">}} translated this article to <span itemprop="inLanguage">Italian</span>: {{<cited-work lang="it-IT" rel="alternate" url="https://www.lealternative.net/2021/12/13/whatsapp-e-laddomesticamento-degli-utenti/" name="WhatsApp e l’addomesticamento degli utent">}}{{</mention-work>}}.

- {{<mention-work itemprop="workTranslation" itemtype="BlogPosting">}}{{<indieweb-person itemprop="author" nickname="puer robustus" url="https://blog.puer-robustus.eu/">}} translated this article to <span itemprop="inLanguage">German</span>: {{<cited-work lang="de-DE" rel="alternate" url="https://blog.puer-robustus.eu/post/domestizierung-von-nutzern/" name="WhatsApp und die Domestizierung von Nutzern">}}{{</mention-work>}}.


[^1]: <span itemprop="citation">Pierotti, R.; Fogg, B. (2017). The First Domestication: How Wolves and Humans Coevolved. Yale University Press.</span>

[^2]: Many within the free software movement dislike the term "open source" for a [number of reasons](https://www.gnu.org/philosophy/open-source-misses-the-point.html); others use the terms "free" and "open source" [interchangeably](https://drewdevault.com/2019/09/17/The-wrong-words-but-the-right-ideas.html). Finally, many vendors use the word "free" to refer to price rather than freedom, prompting some free software supporters to adopt the term "libre" instead. All this can be quite confusing, which is why I prefer acronyms like FLOSS to describe these terms' intersection.

[^3]: See [Defective by Design](https://www.defectivebydesign.org/). DRM is another classic example of user domestication. For the record, Mozilla opposed making DRM a Web standard. It implemented DRM support after it lost to the other W3C members. This doesn't excuse putting DRM in a browser, but at least there wasn't malicious intent. The same can't be said for the pro-DRM members of the W3C.

[^4]: Moxie's blog post generated many responses. Two good follow-ups are on [Linux Weekly News](https://lwn.net/Articles/687294/) and a [blog post](https://matrix.org/blog/2020/01/02/on-privacy-versus-freedom/) by Matrix.org



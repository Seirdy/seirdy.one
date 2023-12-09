---
date: 2021-07-10
title: "Meta: about this site"
outputs:
    - html
description: "About this site. How it's built, why it's built that way, privacy, accessibility, mirrors, etc."
---
{{<build-info>}}

How I run this site
-------------------

With the exception of search-result pages, this site's public-facing content is statically-generated using [the Hugo static-site generator](https://gohugo.io/). I list all the server-side software on [my "uses" page]({{<relref "/about/uses.md#server-side-stuff">}}). All programs on my server that did not come pre-installed with Fedora Cloud Edition are statically-linked binaries built by me, running in heavily sandboxed environments. Most services run with their own root directories (i.e. they run in chroots).

Hugo pulls Webmentions from my Webmention endpoint during builds, so I can have statically-generated comments. Although I did use a pre-made theme a long time ago, I've since gradually re-written the site; my theme is now original. See [my site design standards]({{<relref "/meta/site-design.md">}}) for my design goals.

### Services this site relies on

This site is hosted on a virtual private server I rent from Digital Ocean, with 1&nbsp;virtual CPU and 1&nbsp;GB of memory. I don't necessarily endorse Digital Ocean; for now, I'm only using it for the free credits. I use name servers from [deSEC](https://desec.io/), and do recommend it to others who want managed DNSSEC.

This site encrypts HTTPS traffic with an OCSP-stapled TLS certificate signed by Let's Encrypt. It regularly pulls package updates from Fedora's official repository mirrors.

Other versions of this site
---------------------------

This website's canonical location is on seirdy.one.

This page also exists on the [tildeverse](https://tildeverse.org/), a bunch of \*nix computers that let people sign up for shell accounts. A typical shell account features clients for IRC and email, common terminal/commandline utilities, and (most importantly) web hosting. Read about the tildeverse's [origins](https://web.archive.org/web/20180917091804/https://medium.com/message/tilde-club-i-had-a-couple-drinks-and-woke-up-with-1-000-nerds-a8904f0a2ebf), read [the FAQ](https://tilde.club/wiki/faq.html), pick [a tilde](https://tilde.club/%7Epfhawkins/othertildes.html) and [get started](https://tilde.club/~anthonydpaul/primer.html). My Tildeverse pages will serve as a "rough draft".

Content on this site also appears on <a rel="alternate" href="gemini://seirdy.one/" class="u-syndication">my Gemini capsule</a>. My Web and Gemini content may be slightly different: I often phrase things differently to accommodate the strengths and weaknesses of each medium.

I have a [Tor hidden Web service](http://wgq3bd2kqoybhstp77i3wrzbfnsyd27wt34psaja4grqiezqircorkyd.onion/ "{rel='alternate' class='u-syndication'}") which mirrors this site's contents, except for the fact that it replaces some SVGs with PNGs.

Featured in directories
-----------------------

This site is featured in some cool directories.

### Website "clubs"

The {{<mention-work itemtype="WebSite">}}{{<cited-work name="1MB Club" url="https://1mb.club/">}} by {{<indieweb-person itemprop="author" url="https://bt.ht/" first-name="Bradley" last-name="Taunt">}}{{</mention-work>}} inspired a number of similar website "clubs". I'm in all the ones I'm aware of except for the [No CSS Club](https://nocss.club/) and the [1kb club](https://1kb.club/).

- [512KB Club](https://www.512kb.club/)
- [250kb club](https://250kb.club/)
- [10 KB Club](https://10kbclub.com/)
- [no-JS Club](https://no-js.club/)
- [Darktheme Club](https://darktheme.club/)
- [XHTML Club](https://xhtml.club/)

### Other directories

- [Hyperlinked Text](https://sjmulder.nl/en/textonly.html)
- [textonly.website](https://textonly.website/)
- [Indieweb Webring Directory](https://xn--sr8hvo.ws/directory)
- [Writer's Lane, Nightfall City](https://nightfall.city/writers-lane/)
- [Just Another Useless Page](https://www.geocities.ws/jaup/jaup.htm)
- [Webrings Fanlisting](https://fanlistings.nickifaulk.com/webrings/)
- [Yesterlinks](https://links.yesterweb.org/)
- [Gossip's Web](https://gossipsweb.net/personal-websites)
- [Nixers](https://github.com/nixers-projects/sites/wiki/List-of-nixers.net-user-sites)
- [Smooth Sailing](https://smoothsailing.asclaria.org/)
- [Ye Olde Blogroll](https://blogroll.org/)
- [Nerd Listings](http://nerdlistings.info/)
- [ooh.directory](https://ooh.directory/)
- [List-Me.com](https://list-me.com/)

<details>
<summary>Pending directories</summary>

- [LinkLane](https://www.linklane.net/) (pending)
- [Responsive Web Directory](https://kalechips.net/responsive/) (pending)
- [Accessible Net Directory](https://pinkvampyr.leprd.space/accessiblenet/) (pending)

</details>

Awards and badges
------

{{<image-figure id="internetnl-web">}}

{{<picture name="internetnl-web" alt="Badge with text: 100% score in website test, internet.nl">}}

<figcaption itemprop="caption">

[Internet.nl](https://internet.nl/) offers an automated website security check. Relevant buzzwords include IPv6, DNSSEC, TLS, HTTP security headers, and RPKI. [See a report for seirdy.one](https://internet.nl/site/seirdy.one/2510940/).

Internet.nl penalizes the use of [0-RTT](https://blog.cloudflare.com/introducing-0-rtt/) because it opens sites up to replay attacks. Since passing the test, I moved all non-idempotent content to other subdomains. Save for some fancy Nginx redirects, everything on the `seirdy.one` domain is static public content. This property made it safe to enable 0-RTT without being at risk of replay attacks. As of right now, I don't pass the test, but I consider the 0-RTT failure to be a false positive.

</figcaption>

{{</image-figure>}}

{{<image-figure id="iso-8601">}}

{{< picture name="8601" alt="Bitmap font reading: “Viatrix's ISO 8601 Award! Seirdy's Home, awarded 23/17/22”" class="pix" sf=2 >}}

<figcaption itemprop="caption">

{{<indieweb-person itemprop="mentions" name="Viatrix" url="https://viatrix.is-hella.gay">}} sent me an ["ISO-8601 Award"](https://mincerafter42.github.io/fun/8601award.html) for using the Correct Date Format. In her words: <q cite="https://mincerafter42.github.io/fun/8601award.html">It shows my like of ISO 8601, and trolls anyone trying to read the Awarded date.</q>

</figcaption>

{{</image-figure>}}

{{<image-figure id="not-ai">}}

{{<picture name="notai" alt="written By human, not by AI">}}

<figcaption itemprop="caption">

[Not By AI](https://notbyai.fyi/) offers badges to indicate that content is not generated by "Artificial Intelligence" (i.e., machine learning) in the wake of a wave of text-to-image and language models. At the time of writing, 100% of the content on this website is manually written. The only "algorithmic" writing aid I have is NeoVim's default spell-checking and word suggestions, and occasionally use a simple prose linter for weak suggestions (most of which I ignore).

</figcaption>

{{</image-figure>}}


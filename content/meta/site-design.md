---
outputs:
    - html
title: Site design standards
description: "The accessibility statement and design standards I hold myself to when creating seirdy.one"
date: "2022-06-10T00:00:00+00:00"
---
This site may look simple on the surface, but I put a _lot_ of thought into it. I hold myself to a long list of requirements concerning accessibility, compatibility, privacy, security, and machine-friendliness.

<p role="doc-tip">Note: all references to "pixels" (<abbr title="pixels">px</abbr>) in this section refer to CSS pixels.</p>

Accessibility statement
-----------------------

I've made every effort to make seirdy.one as accessible as possible. More information about the accessibility-related work for seirdy.one is in my post {{<mention-work>}}{{<cited-work url="https://seirdy.one/posts/2020/11/23/website-best-practices/" name="Best practices for inclusive textual websites" extraName="headline">}}{{</mention-work>}}.

### Conformance status

The [Web Content Accessibility Guidelines (WCAG)](https://www.w3.org/WAI/standards-guidelines/wcag/) defines requirements for designers and developers to improve accessibility for people with disabilities. It defines three levels of conformance: Level A, Level AA, and Level AAA. I've made sure seirdy.one is **fully conformant with WCAG 2.2 level AA.**

<dfn>Fully conformant</dfn> means that the content fully conforms to the accessibility standard without any exceptions.

### Additional accessibility considerations

Additionally, I strive to conform to WCAG 2.2 level AAA wherever applicable. I comply with all AAA criteria except for the following:


SC 2.4.9 Link Purpose (Link Only)
: I'm actually trying to follow this criterion, but it's a work in progress. Let me know if any link names can be improved! Link purpose _in context_ always makes sense.

SC 3.1.5 Reading Level
: The required reading ability often exceeds the lower secondary education level, especially on more technical articles.

SC 3.1.6 Pronunciation
: I do not yet provide any pronunciation information.

I have only tested WCAG compliance in mainstream browser engines (Blink, Gecko, WebKit). Full details on how I meet every WCAG success criterion are on a separate page: [Details on WCAG 2.2 conformance](../wcag-conformance/)

I also go further than WCAG in many aspects:

- Rather than follow SC 2.5.5's requirement to achieve a minimum tap target size of 44 by 44 pixels, I follow Google's more strict guidelines. These guidelines mandate that targets are at least 48-by-48 pixels, with no overlap against any other targets in a 56-by-56 pixel range. I try to follow this guideline for any interactive element that isn't a hyperlink surrounded by body text.

- I ensure at least one such 56-by-56&nbsp;px non-interactive region exists on the page, for users with hand tremors or or anyone who wants to tap the screen without clicking something.

- With the exception of in-text borders, I only set custom colors in response to the `prefers-color-scheme: dark` media query. These custom colors pass APCA contrast ratios, all being close to the ideal lightness contrast of 90. They are also autism- and overstimulation-friendly colors: yellow links are significantly de-saturated to reduce harshness.

- I ensure that the page works on extremely narrow viewports without triggering two-dimensional scaling. It should work at widths well below 200 CSS pixels.

### Assessment and evaluation

I test each WCAG success criterion myself using the mainstream browser engines (Blink, Gecko, WebKit). I test using multiple screen readers: Orca (primary, with Firefox and Epiphany), NVDA (with Firefox and Chromium), Windows Narrator (with Microsoft Edge), Apple VoiceOver (with desktop and mobile Safari), and Android TalkBack (with Chromium).

I also accept user feedback. Users are free to contact me through any means linked on my [About page](../../about/).

Finally, I supplement manual testing with the following automated tools:

- [axe-core](https://github.com/dequelabs/axe-core)
- [IBM Equal Access Accessibility Checker](https://www.ibm.com/able/toolkit/verify/automated)
- [AInspector](https://github.com/ainspector/ainspector-for-firefox)
- [WAVE Web Accessibility Evaluation Tool](https://wave.webaim.org/)
- [ARC Toolkit](https://www.tpgi.com/arc-platform/arc-toolkit/)

WAVE reports no errors; AXE is unable to determine certain contrast errors, but it otherwise reports no errors; IBM Equal Access reports no errors but some items that need review.

I regularly run axe-core and the IBM Equal Access Accessibility Checker on every page in my sitemap, and receive no errors.

Compatibility statement
-----------------------

The website is built on well structured, semantic, [polygot XHTML5](https://www.w3.org/TR/html-polyglot/) (including [WAI-ARIA](https://www.w3.org/WAI/standards-guidelines/aria/) and [DPUB-ARIA](https://www.w3.org/TR/dpub-aria-1.1/) extensions where appropriate), enhanced with CSS for styling. The website does **not** rely on modern development practices such as CSS Grid, Flexbox, SVG 2, Web fonts, and JavaScript; this should improve support in older browsers such as Internet Explorer 11. No extra plugins or libraries should be required to view the website.

This site sticks to Web standards. I regularly run a local build of [the Nu HTML Checker](https://github.com/validator/validator), `xmllint`, and [html proofer](https://github.com/gjtorikian/html-proofer) on every page in my sitemap, and see no errors. I do [filter out false Nu positives](https://git.sr.ht/~seirdy/seirdy.one/tree/master/item/linter-configs/vnu_filter.jq) and report them upstream when I can.

I also perform cross-browser testing for both HTML and XHTML versions of my pages:

- I maintain excellent compatibility with **mainstream engines:** Blink (Chromium and Edge), WebKit (Safari, Epiphany), and Gecko (Firefox). The hidden service also works well with the Tor Browser.

- The site works well with **textual browsers.** Lynx and Links2 are first-class citizens for which all features work as intended. [w3m doesn't support soft hyphens](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=830173), but the site is still otherwise usable in it. I maintain compatibility with these engines by making CSS a strictly-optional progressive enhancement and using semantic markup.

- I also regularly test compatibility with **current alternative engines:** the SerenityOS browser, Servo, NetSurf, Dillo, Kristall, and Goanna (Pale Moon's Gecko fork). I have excellent compatibility with Goanna and Servo. The site is usable in NetSurf, Dillo, and the SerenityOS browser; the always-expanded `<details>` elements might look odd. [The SerenityOS browser doesn't support ECDSA certificates](https://github.com/SerenityOS/serenity/issues/14160), but the Tildeverse mirror works fine. It also has some issues displaying my SVG avatar; it does not attempt to use the PNG fallback.

- I occasionally test **abandoned engines,** sometimes with a TLS-terminating proxy if necessary. These engines include Tkhtml, KHTML, Internet Explorer (with and without compatibility mode), Netscape Navigator, and outdated versions of current browsers. The aforementioned issue with `<details>` applies to all of these choices. I use Linux, but testing in browsers like Internet Explorer depends on my access to a Windows machine.

Some engines I have not yet tested, but hope to try in the future:

- [Netzhaut](https://netzhaut.dev/)
- [Kozmonaut](https://github.com/twilco/kosmonaut)
- [Moon](https://github.com/ZeroX-DG/moon)
- [hastur](https://github.com/robinlinden/hastur)

Machine-friendliness
--------------------

I think making a site machine-friendly is a great alternative perspective to traditional SEO, the latter of which I think tends to incentivise low-quality content and makes searching difficult. It's a big part of what I've decided to call ["agent optimization"]({{<relref "notes/agent-optimization.md">}}).

This site is **parser-friendly.** It uses polygot (X)HTML5 markup containing schema.org microdata, microformats2, and legacy microformats. Microformats are useful for IndieWeb compatibility; schema.org microdata is useful for various forms of content-extraction (such as "reading mode" implementations) and search engines. I've also sprinkled in some Creative Commons vocabulary using RDFa syntax.

I make Atom feeds available for articles and notes, and have a combined Atom feed for both. These feeds are enhanced with Ostatus and ActivityStreams XML namespaces.

All HTML pages have an XHTML5 counterpart, which is currently the same except for the presence of an XML declaration. To see this counterpart, add "index.xhtml" to the end of a URL or request a page with an `Accept` header containing `application/xhtml+xml` but not `text/html`. All pages parse correctly using all the XHTML browser parsers I could try.

### Reading mode compatibility

The aforementioned metadata (microdata, microformats) has improved reading-mode compatibility.

This site should fully support the Readability algorithm. The Readability algorithm is used by Firefox and Vivaldi. It's the basis of one of multiple distillers used by Brave; Brave typically uses its Readability-based logic on seirdy.one. Readability is the only article distillation algorithm I try to actively support.

This site happens to fully support Apple's Reader Mode and Azure Immersive Reader (AIR), the latter of which powers Microsoft Edge's reading mode. Unfortunately, AIR applies a stylesheet atop the extracted article that makes figures difficult to read: it centers text in figures, included pre-formatted blocks. I filed an issue on AIR's feedback forum, but that forum was subsequently deleted.

This site works well in the Diffbot article extractor. Diffbot powers a variety of services, including Instapaper.

This site does not work well in Chromium's DOM Distiller's flawed distillation techniques. Regions with high link-densities, such as citations, get filtered out. DOM Distiller also does not show footnotes, and sometimes cuts off final [DPUB-ARIA](https://w3c.github.io/dpub-aria/) sections (acknowledgements, conclusions).

Static IndieWeb
---------------

One of my goals for this site was to see just how far I could take IndieWeb concepts on a fully static site with ancillary services to handle dynamism. Apart from the search-results page, this site is static on the back-end (all pages are statically-generated). All pages, including the search-results page, are fully static on the front-end (no JS).

[The IndieMark page](https://indieweb.org/IndieMark) lists all the ways you can "IndieWeb-ify" your site.

### Features I have already implemented

- IndieAuth compatibility, using the external [IndieLogin.com service](https://indielogin.com/).

- Microformats: representative `h-card`, in-text `h-card` and `h-cite` when referencing works, `h-feed`.

- Sending and receiving Webmentions. I receive Webmentions with [webmentiond](https://github.com/zerok/webmentiond), and send them from my own computer using [Pushl](https://github.com/PlaidWeb/Pushl).

- Displaying Webmentions: linkbacks, IndieWeb "likes" (not silo likes), and comments. I based their appearance on Tumblr's display of interactions.

- Backfeeding content from silos: I'm only interested in backfilled content containing discussion, not "reactions" or "likes". Powered by [Bridgy](https://brid.gy/).

### Features I am not interested in

- Authoring tools, either through a protocol (e.g. MicroPub) or a dynamic webpage: I prefer writing posts in my `$EDITOR` and deploying with `git push`, letting a CI job build and deploy the site with `make deploy-prod`. This allows me to participate with the social Web using the same workflow I use for writing code, avoiding the need to adopt and learn new tools.

- Full silo independence: I want to treat my site as a "filtered" view of me to keep searchable and public. On other silos I might shitpost or post short-lived, disposable content. These aren't private, but I want them to remain less prominent. I POSSE content to other places, but I don't exclusively use POSSE.

- Sharing my likes, favorites, reposts: I find these a bit too shallow for seirdy.one. I prefer "bookmarks" where I can give an editorialized description of the content I wish to share along with any relevant tags. I'll keep simple likes and reposts to silos.

- Rich reply-contexts: I'd rather have users click a link to visit the reply and use quoted text to respond to specific snippets, similar to interleaved-style email quoting. Most of my replies are to Fediverse posts; on the Fediverse, people are often (understandably!) averse to scraping and archiving content. For that reason: I only show a tiny excerpt of content, and I ask for permission to POSSE replies to unlisted posts by `#nobot` accounts.

### Features I am interested in

- WebSub. I had some issues with Superfeedr; I think I'll resort to running my own single-user hub.

- Automatic POSSE to the Fediverse (would be difficult with reply-contexts, and Bridgy doesn't support non-Mastodon features like Markdown).

- Taxonomies (tags).

### Low-priority features I have some interest in

- RSVPs: I don't attend many events, let alone events for which I would broadcast my attendance. A page for this would be pretty empty.

- Event posts: same reason as above.

- Running my own IndieAuth authorization endpoint to replace the external IndieLogin service.

- Some sort of daemon to replace Bridgy. It sounds like a large undertaking because I'd have to implement it from scratch: Bridgy is written in Python, but I want every service on my server to be a statically-linked native executable.

Privacy
-------

This site is **privacy-respecting.** Its CSP blocks all scripts, third-party content, and other problematic features. I describe how I go out of my way to reduce the information you can transmit on this site in [my privacy policy](../privacy/).


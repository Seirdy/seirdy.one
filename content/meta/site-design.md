---
outputs:
    - html
title: Site design standards
description: "The accessibility statement and design standards I hold myself to when creating seirdy.one"
date: "2022-06-10T00:00:00+00:00"
---
This site may look bare-bones on the surface, but I put much thought into it. I hold myself to a long list of requirements. I make mistakes; if part of my site violates these standards, please contact me!

<p role="doc-tip">Note: all references to "pixels" (<abbr title="pixels">px</abbr>) refer to CSS pixels.</p>

{{<toc>}}

## Accessibility statement

I hold seirdy.one to the highest accessibility standards possible. For more information about seirdy.one's accessibility-related work, read {{<mention-work itemtype="BlogPosting">}}{{<cited-work url="https://seirdy.one/posts/2020/11/23/website-best-practices/" name="Best practices for inclusive textual websites" extraName="headline">}}{{</mention-work>}}.

### Conformance status

The [Web Content Accessibility Guidelines (<abbr>WCAG</abbr>)](https://www.w3.org/WAI/standards-guidelines/wcag/) defines requirements for designers and developers to improve accessibility for people with disabilities. It defines three levels of conformance: Level A, Level AA, and Level AAA. I make seirdy.one **fully conformant with <abbr>WCAG</abbr> 2.2 level AA.**

<dfn>Fully conformant</dfn> means that the content conforms to the accessibility standard without any exceptions.

### More accessibility considerations

I conform to all <abbr>WCAG</abbr> AAA success criteria (<abbr>SC</abbr>) _except_ the following:


<abbr>SC</abbr> 2.4.9 Link Purpose (Link Only)
: <abbr>SC</abbr> 2.4.9 conformance is a work in progress. Let me know if any link names need improvement! Link purpose _in context_ always makes sense.

<abbr>SC</abbr> 3.1.5 Reading Level
: Required reading ability often exceeds the lower secondary education level.

<abbr>SC</abbr> 3.1.6 Pronunciation
: I do not currently offer any pronunciation information.

I have only tested <abbr>WCAG</abbr> compliance in mainstream browser engines (Blink, Gecko, WebKit). For full details on how I meet every <abbr>WCAG</abbr> success criterion, read <cite>[Details on <abbr>WCAG</abbr> 2.2 conformance]({{<relref "/meta/wcag-conformance.md">}})</cite>.

The <abbr>WCAG</abbr> presents a starting point, not a stopping point. Here are some non-<abbr>WCAG</abbr> accessibility criteria I consider:

- Rather than follow <abbr>SC</abbr> 2.5.5's advice to achieve a minimum tap target size of 44 by 44 pixels, I follow Google's more strict guidelines. These guidelines mandate target sizes of at least 48-by-48 pixels, with no overlap against any other targets in a 56-by-56 pixel range. I follow this guideline for any interactive element _except_ inline hyperlinks surrounded by non-interactive text.

- I ensure at least one such 56-by-56&nbsp;px non-interactive region exists on the page, for users with hand tremors or anyone who wants to tap the screen without clicking something.

- Except for text borders, I only set custom colors in response to the `prefers-color-scheme: dark` media query. These custom colors have an Advanced Perceptual Contrast Algorithm (<abbr>APCA</abbr>) lightness contrast close to the ideal value of 90. I use autism- and overstimulation-friendly colors: the yellow links have low saturation to reduce harshness.

- I ensure narrow viewports don't cause two-dimensional scrolling. I test this at widths narrower than 200 CSS pixels; this is much stricter than the <abbr>WCAG</abbr> threshold values.

### Assessment and evaluation

I test each <abbr>WCAG</abbr> success criterion with the mainstream browser engines: Blink, Gecko, and WebKit. I test using multiple screen readers:

- Orca (primary, with Firefox and Epiphany)
- NVDA (with Firefox and Chromium)
- Windows Narrator (with Microsoft Edge)
- Apple VoiceOver (with desktop and mobile Safari)
- Android TalkBack (with Chromium)

I also accept user feedback. Feel free to contact me through any means linked on my [About page]({{<relref "/about/_index.md">}}).

The following automated tools supplement manual testing:

- [axe-core](https://github.com/dequelabs/axe-core)
- [IBM Equal Access Accessibility Checker](https://www.ibm.com/able/toolkit/verify/automated/)
- [AInspector](https://github.com/ainspector/ainspector-for-firefox)
- [WAVE Web Accessibility Evaluation Tool](https://wave.webaim.org/)
- [ARC Toolkit](https://www.tpgi.com/arc-platform/arc-toolkit/)
- [webhint](https://webhint.io/)
- [lighthouse](https://developer.chrome.com/docs/lighthouse/overview/)

WAVE reports no errors. AXE sometimes fails to measure contrast, but otherwise reports no errors. IBM Equal Access reports no errors, and finds some items which need manual review.

I run axe-core, the IBM Equal Access Accessibility Checker, the Nu HTML Checker (local build, latest commit of the validator and its CSS-Validator submodule), and webhint on every page in my sitemap. After filtering out false-positives (and reporting them upstream), I receive no errors. I repeat this run with every change to my Hugo templates and stylesheets.

<del datetime="2024-04-22">To work around [issue 1008 in IBM Equal Access Checker](https://github.com/IBMa/equal-access/issues/1008), I remove all instances of `content-visibility` from my site's CSS before running `achecker` from the command line</del>. <ins datetime="2024-04-22">Update: the issue has been resolved</ins>

## Compatibility statement

### Conformance

This website uses well structured, semantic, [polygot XHTML5](https://www.w3.org/TR/html-polyglot/) (including [WAI-ARIA](https://www.w3.org/WAI/standards-guidelines/aria/) and [DPUB-ARIA](https://www.w3.org/TR/dpub-aria-1.1/) extensions where appropriate), enhanced with CSS for styling.

This website conforms to Web standards. Each build runs `xmllint` to catch syntax errors. Every few commits, I run a local build of [the Nu HTML Checker](https://github.com/validator/validator) and [html proofer](https://github.com/gjtorikian/html-proofer) across all 200-something pages in my sitemap, and see no errors. I do [filter out false Nu positives](https://git.sr.ht/~seirdy/seirdy.one/tree/master/item/linter-configs/vnu_filter.jq), and I [report and fix false-positives](https://github.com/w3c/css-validator/issues?q=author%3ASeirdy) when possible. See [my docs for building and validating this site]({{<relref "/meta/build-this-site.md">}}) for more information.

### Cross-browser compatibility

This website does **not** rely on modern development practices such as CSS Grid, Flexbox, SVG 2, Web fonts, and JavaScript; this improves support in older browsers such as Internet Explorer 11. Users can access this site without extra plug-ins or polyfills. The site does use strictly-optional modern features (e.g. CSS containment) that don't create significant visual differences.

I also perform cross-browser testing for HTML [and XHTML versions](#markup) of my pages. I test with, but [do not necessarily endorse]({{<relref "/notes/pale-moon.md">}}), a large variety of browsers:


Mainstream engines
: I keep excellent compatibility with mainstream engines: Blink (Chromium, Edge, QtWebEngine), WebKit (Safari, Epiphany), and Gecko (Firefox).

Tor Browser
: My Tor hidden service also works well with the Tor Browser, except for [a page containing an `<audio>` element](http://wgq3bd2kqoybhstp77i3wrzbfnsyd27wt34psaja4grqiezqircorkyd.onion/posts/2022/07/01/experiment-copilot-legality/). The `<audio>` element appears non-interactive in the Tor Browser due to a bug involving NoScript and Firefox's handling of [the `sandbox` Content Security Policy <abbr>CSP</abbr> directive](https://www.w3.org/TR/CSP3/#directive-sandbox). To work around the issue, I include link to download the audio.

Mainstream engine forks
: Pale Moon and recent versions of K-Meleon use Goanna, a single-process fork of Firefox's Gecko engine. Ultralight is a proprietary, source-available fork of WebKit focused on lightweight embedded webviews. My site works in these engines without any noticeable issues.

Alternative engines
: I test compatibility with current alternative engines: the SerenityOS browser, Servo, NetSurf, Kristall, and litehtml. I have excellent compatibility with litehtml and Servo. The site is usable in NetSurf, and the SerenityOS browser. Servo is the only engine in this category with support for `<details>`. ~~[The SerenityOS browser lacks ECDSA certificate support](https://github.com/SerenityOS/serenity/issues/14160), but the Tildeverse mirror works fine.~~ <ins itemprop="correction" itemscope="" itemtype="https://schema.org/CorrectionComment" cite="https://github.com/SerenityOS/serenity/commit/f9386737a631b5f3b7eb1920bd4440a2784359e9">Update <time itemprop="datePublished">2024-01-30</time>: <span itemprop="text">[SerenityOS LibTLS merged support for these ciphers in October 2023](https://github.com/SerenityOS/serenity/commit/f9386737a631b5f3b7eb1920bd4440a2784359e9), resolving this incompatibility</span></ins>. The SerenityOS browser also has issues displaying my inline SVG avatar.

Textual browsers
: The site works well with textual browsers. All features except `<details>` work in Lynx and Links2. I include [felinks (an ELinks fork)](https://github.com/rkd77/elinks), edbrowse, and w3m in my tests. [w3m doesn't support soft hyphens](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=830173), but the site is still otherwise usable in it. I support these engines by making CSS a strictly-optional progressive enhancement and by using semantic markup. I test with Edbrowse less often. No textual browser supports `<details>`.

Abandoned engines
: I occasionally test abandoned engines, sometimes with a TLS-terminating proxy if necessary. These engines include Tkhtml, KHTML, Dillo,[^1] Internet Explorer[^2] (with and without compatibility mode), Netscape Navigator, old Presto-based Opera versions,[^3] and outdated versions of current browsers. No abandoned engine supports `<details>`. I use Linux, but testing in Internet Explorer depends on my access to a Windows machine. Besides the `<details>` issues, the site works well in Internet Explorer 11 and Opera Presto. The site has layout issues but remains usable in Tkhtml, KHTML, and Netscape.

I support compatibility to the following degrees:

- Works without major issues in mainstream engines, the Tor browser, Goanna, and Ultralight.
- Fully operable in textual browsers, litehtml, and NetSurf. Some issues (e.g. missing `<details>`) might make the experience unpleasant, but all major functions work.
- Basic features in abandoned engines, Dillo, the SerenityOS browser. Some ancillary features may not work (e.g. forms for Webmentions and search), but users can browse and read.

Some engines I have not yet tested, but hope to try in the future:

- [Flow Browser](https://www.ekioh.com/flow-browser/)
- [gngr](https://gngr.info/)
- [WeasyPrint](https://weasyprint.org/)
- [Netzhaut](https://web.archive.org/web/20230405031300/http://netzhaut.dev/)
- [Kozmonaut](https://github.com/twilco/kosmonaut)
- [Moon](https://github.com/ZeroX-DG/moon)
- [hastur](https://github.com/robinlinden/hastur)

## Machine-friendliness

I use machine-friendliness as an alternative perspective to traditional search-engine-optimization, the latter of which incentivizes low-quality content. It's a major part of what I've dubbed ["agent optimization"]({{<relref "notes/agent-optimization.md">}}).

### Markup

This site is **parser-friendly.** It uses well-formed, semantic, polygot (X)HTML5 markup validated by [the Nu HTML checker and `xmllint`](#compatibility-statement).

All HTML pages have an XHTML5 counterpart; the `content-type` HTTP header is their sole difference. All pages parse correctly with all the XHTML parsers I tried. To see this counterpart, do one of the following:

- Add `index.xhtml` to the end of a URL
- Request a page with an `Accept` header containing `application/xhtml+xml`, but not `text/html`.

My markup includes structured data in four syntaxes, for four different vocabularies:

1. HTML classes convey **Microformats vocabulary** to provide IndieWeb compatibility. This improves Webmentions and enables VCard-generation.
2. Microdata syntax conveys **Schema.org vocabulary.** This enables many forms of content-extraction, performed by "reading mode" implementations and search engines.
3. RDFa syntax conveys **Creative Commons vocabulary.**
4. `<meta>` properties convey **Open Graph metadata.** Instant-messengers and social media use that metadata to generate link previews.

I make Atom feeds available for articles and notes, and have a combined Atom feed for both. These feeds are enhanced with OStatus and Activity Streams XML namespaces.

### Reading mode compatibility

The aforementioned structured data improves reading-mode compatibility.

The only article distillation algorithm I actively support is Readability; it powers Firefox and Vivaldi's reading-modes. Although Brave's reading-mode has multiple article-distillers, it's the sole distiller Brave uses on seirdy.one.

This site happens to distill well under Safari's Reader Mode and Microsoft's Azure Immersive Reader (<abbr>AIR</abbr>); the latter powers Microsoft Edge's reading-mode. <abbr>AIR's</abbr> stylesheet makes code figures difficult to read: it centers text in figures, included pre-formatted blocks. I filed an issue on the <abbr>AIR</abbr> feedback forum, but Microsoft later deleted that forum.

This site works well in the Diffbot article extractor. Diffbot powers a variety of services, including Instapaper.

This site has poor compatibility with the Chromium DOM Distiller's flawed techniques. Regions with high link-densities, such as citations, get filtered out. DOM Distiller also removes footnotes, and sometimes [DPUB-ARIA](https://w3c.github.io/dpub-aria/) sections near the end of an article (acknowledgements, conclusions).

## Static IndieWeb

I want to show how far I can take IndieWeb concepts on a fully static site, leaving dynamism to ancillary services.

[The IndieMark page](https://indieweb.org/IndieMark) lists all the ways you can "IndieWeb-ify" your site.

### Static site

In multiple senses of the word, my public pages are static.

- I generate and serve all pages statically, except for the search-results pages.
- My <abbr title="Content Security Policy">CSP</abbr> blocks scripts, eliminating all client-side dynamism besides `<details>` and forms.

### IndieWeb features implemented

I've implemented several features from IndieMark:

- IndieAuth compatibility, using the external [IndieLogin.com service](https://indielogin.com/).

- Microformats: representative `h-card`, in-text `h-card` and `h-cite` when referencing works, `h-feed`.

- Sending and receiving Webmentions. I receive Webmentions with [webmentiond](https://github.com/zerok/webmentiond), and send them from my own computer using [Pushl](https://github.com/PlaidWeb/Pushl/).

- Displaying Webmentions: I render backlinks, IndieWeb "likes" (not silo likes), and comments below posts. I model their appearance after Tumblr's display of interactions.

- Backfeeding content from silos: I'm only interested in backfilled content containing discussion, not "reactions" or "likes". Powered by [Bridgy](https://brid.gy/).

### IndieWeb features skipped

IndieWeb sites need not implement _every_ IndieWeb standard. Progressive enhancement and graceful degradation let me implement interesting features, and skip less interesting ones. Skipped features include:

- Authoring tools, in the form of protocols (MicroPub) or dynamic pages. I prefer writing posts in my `$EDITOR` and deploying with `git push`, letting a <abbr>CI</abbr> job build and deploy the site. I can participate in the IndieWeb and write code with the same tools; [I juggle enough already]({{<relref "/about/uses.md">}}).

- Full silo independence. My site provides a public, searchable, and _filtered_ view of myself. On other silos I might shitpost or post short-lived, disposable content. These public, but I want them to remain less prominent. I [<abbr>POSSE</abbr>](https://indieweb.org/POSSE) content to other places, but I don't exclusively use <abbr title="Publish on Own Site, Syndicate Elsewhere">POSSE</abbr>.

- Sharing my "likes", "favorites", and "re-posts". I find these a bit too shallow for seirdy.one. I prefer "bookmarks" where I give editorialized descriptions of shared content. I'll confine likes and reposts to silos.

- Rich reply-contexts. I use quoted text to respond to specific snippets, and prefer that users follow links to see full reply contexts. Most of my replies respond to Fediverse posts; many people on the Fediverse feel aversion to content-scraping and archiving. For that reason: I limit reply-contexts to tiny excerpts, and ask for permission to <abbr>POSSE</abbr> replies to unlisted posts by `#nobot` accounts.

### Future IndieWeb features

I'm not done IndieWeb-ifying my site. I plan to implement these features:

- WebSub. I had some issues with Superfeedr; I think I'll resort to running my own single-user hub.

- Automatic <abbr>POSSE</abbr> to the Fediverse (difficult with reply-contexts, and Bridgy lacks non-Mastodon features such as HTML).

- Taxonomies (tags).

### Low-priority features I have some interest in

I'm not opposed to these features, but I probably won't implement support for them.

- [<abbr>RSVPs</abbr>](https://indieweb.org/rsvp): I don't attend many events, let alone events worth an "RSVP" entry.

- Event posts: same reason.

- Running my own IndieAuth authorization endpoint to replace the external IndieLogin service.

- Some sort of daemon to replace the Bridgy service. I don't plan to run my own Bridgy instance: Bridgy requires Python, but I prefer installing statically-linked native executables.

## Privacy

This site is **privacy-respecting.** Its <abbr title="Content Security Policy">CSP</abbr> blocks all scripts, third-parties, and other problematic features. For details on this site's privacy, [read the privacy policy](../privacy/).


[^1]: Although no official announcement of Dillo's demise exists, the browser's development halted years ago. The Dillo website's domain name expired, so [I mirrored the Dillo repository]({{<relref "/notes/dillo-repository-mirror.md">}}).

[^2]: [Internet Explorer's engine isn't abandoned]({{<relref "internet-explorer-is-almost-gone.md">}}). Microsoft discontinued the consumer version, but supports the browser for enterprise users. I used to have access to the latter; I now test with "Internet Explorer Mode" in Edge when I can access a Windows machine.

[^3]: Strictly speaking, Opera still supports Presto to a limited degree. Opera Mini's "Extreme" mode still uses a server-side Presto rendering engine; see {{<mention-work itemprop="citation" role="doc-credit" itemtype="Article">}}{{<cited-work name="Opera Browsers, Modes & Engines" url="https://dev.opera.com/articles/browsers-modes-engines/" extraName="headline">}}{{</mention-work>}}. That said, I do test with the outdated desktop Presto engine in a sandboxed environment.



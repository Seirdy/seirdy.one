---
date: "2020-11-23T12:21:35-08:00"
description: A lengthy guide to making simple and accessible sites that focus on content rather than form. Emphasizes brutalist web design, adaptability, and minimalism to cater to underrepresented users.
outputs:
    - html
    - gemtext
footnote_heading: Notes
toc: true
tags:
    - web
    - accessibility
    - minimalism
sitemap:
    ChangeFreq: daily
    Priority: 0.7
title: An opinionated list of best practices for textual websites
---
<div role="doc-preface">

_The following applies to minimal websites that focus primarily on text. It does not apply to websites that have a lot of non-textual content. It also does not apply to websites that focus more on generating revenue or pleasing investors than being inclusive._

This is a "living document" that I add to as I receive feedback. See the [changelog](https://git.sr.ht/~seirdy/seirdy.one/log/master/item/content/posts/website-best-practices.md).

If you find the article too long, just read the introduction and conclusion. The table of contents should help you skim.

</div>

{{<toc>}}

<section role="doc-introduction">

Intro&shy;duction {#introduction}
-----------------

I realize not everybody's going to ditch the Web and switch to Gemini or Gopher today (that'll take, like, a month at the longest). Until that happens, here's a non-exhaustive, highly-opinionated list of best practices for websites that focus primarily on text. I don't expect anybody to fully agree with the list; nonetheless, the article should have _some_ useful information for any web content author or front-end web developer.

My primary focus is [inclusive design](https://100daysofa11y.com/2019/12/03/accommodation-versus-inclusive-design/). Specifically, I focus on supporting _under&shy;represented ways to read a page_. Not all users load a page in a common web-browser and navigate effortlessly with their eyes and hands. Authors often neglect people who read through accessibility tools, tiny viewports, machine translators, "reading mode" implemen&shy;tations, the Tor network, printouts, hostile networks, and uncommon browsers, to name a few. I list more niches in [the conclusion](#conclusion). Compatibility with so many niches sounds far more daunting than it really is: if you only selectively override browser defaults and use plain-old, semantic HTML (<abbr title="plain-old, semantic HTML">POSH</abbr>), you've done half of the work already.

One of the core ideas behind the flavor of inclusive design I present is being _inclusive by default._ Web pages shouldn't use accessible overlays, reduced-data modes, or other personalizations if these features can be available all the time. Of course, some features conflict; you can't display a light and dark color scheme simultaneously. Personalization is a fallback strategy to resolve conflicting needs. Disproportionately under&shy;represented needs deserve disproportionately greater attention, so they come before personal preferences instead of being relegated to a separate lane.

Another focus is minimalism. [Progressive enhancement](https://en.wikipedia.org/wiki/Progressive_enhancement) is a simple, safe idea that tries to incorporate some responsibility into the design process without rocking the boat too much. I don't find it radical enough. On top of progressive enhancement, I prefer limiting any enhancements to ones that have been demonstrated to solve specific accessibility, security, performance, or significant usability problems faced by people _besides me._

I'd like to re-iterate yet another time that this only applies to websites that primarily focus on text. If graphics, interactivity, etc. are an important part of your website, less of the article applies. My hope is for readers to consider a subset of this page the next time they build a website, and _address the trade-offs they make when they deviate._ I don't expect--or want--anybody to follow all of my advice, because doing so would make the Web quite a boring place!

I'll cite the Web Accessibility Initiative's (<abbr title="Web Accessibility Initiative">WAI</abbr>) <cite>[Techniques for WCAG&nbsp;2.2](https://www.w3.org/WAI/WCAG22/Techniques/)</cite> a number of times. Unlike the <cite>Web Content Accessibility Guidelines</cite> (<abbr title="Web Content Accessibility Guidelines">WCAG</abbr>), the Techniques document does not list requirements; rather, it serves to non-exhaustively educate authors about _how_ to use specific technologies to comply with the WCAG. I don't find much utility in the technology-agnostic goals enumerated by the WCAG without the accompanying technology-specific techniques to meet those goals.

</section>

Security and privacy
--------------------

One of the defining differences between textual websites and advanced Web&nbsp;2.0 sites/apps is safety. Most browser vulnera&shy;bilities are related to modern Web features like JavaScript and WebGL. The simplicity of basic textual websites _should_ guarantee some extra safety; however, webmasters need to take additional measures to ensure limited use of "modern" risky features.

### TLS

All of the simplicity in the world won't protect a page from unsafe content injection by an intermediary. Proper use of TLS protects against page alteration in transit and ensures a limited degree of privacy. Test your TLS setup with <a translate="no" href="https://testssl.sh/">testssl.sh</a> and [Webbkoll](https://webbkoll.dataskydd.net/).

If your OpenSSL (or equivalent) version is outdated or you don't want to download and run a shell script, SSL Labs' [SSL Server Test](https://www.ssllabs.com/ssltest/) should be equivalent to testssl.sh. Mozilla's [HTTP Observatory](https://observatory.mozilla.org/) offers a subset of Webbkoll's features and is a bit out of date (and requires JavaScript), but it also gives a beginner-friendly score. Most sites should strive for at least a 50, but a score of 100 or even 120 shouldn't be too hard to reach.

A false sense of security is far worse than transparent insecurity. Don't offer broken TLS ciphers, including TLS 1.0 and 1.1. Vintage computers can run TLS 1.2 implemen&shy;tations such as BearSSL surprisingly efficiently, leverage a TLS terminator, or they can use a plain unencrypted connection. A broken cipher suite is security theater.

### Scripts and the Content Security Policy

Consider taking hardening measures to maximize the security benefits made possible by the simplicity of textual websites, starting with script removal.

JavaScript and WebAssembly are responsible for the bulk of modern web exploits. If that isn't reason enough, most [non-mainstream search indexes](./../../../2021/03/10/search-engines-with-own-indexes.html) have little to no support for JavaScript. Ideally, a text-oriented site can enforce a scripting ban at the [Content Security Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP) (<abbr title="Content Security Policy">CSP</abbr>) level.

<figure itemscope itemtype="https://schema.org/SoftwareSourceCode">
<figcaption>

<strong itemprop="codeSampleType">Code snippet</strong>: this is the CSP for my main website, with hashes removed for readability.

</figcaption>

<pre><samp itemprop="text">default-src 'none';
img-src 'self' data:;
style-src 'sha256-<var>HASH</var>';
style-src-attr 'none';
frame-ancestors 'none';
base-uri 'none';
form-action 'none';
manifest-src https://seirdy.one/manifest.min.<var>HASH</var>.webmanifest;
upgrade-insecure-requests;
sandbox allow-same-origin</samp></pre>

</figure>

`default-src: 'none'` implies `script-src: 'none'`, causing a compliant browser to forbid the loading of scripts. Furthermore, the `sandbox` CSP directive forbids a [wide variety of risky actions](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/sandbox). While `script-src` restricts script loading, `sandbox` can also restrict script execution with stronger defenses against script injection (e.g. by a browser add-on).[^1] I added the `allow-same-origin` parameter so that these add-ons will still be able to function.[^2]

If you're able to control your HTTP headers, then use headers instead of a `<meta http=equiv>` tag. In addition to not supporting certain directives, a CSP in a `<meta>` tag might let some items slip through:

<figure itemscope itemtype="https://schema.org/Quotation">
	<blockquote itemprop="text">
		<p>
		At the time of inserting the <code>meta</code> element to the document, it is
		possible that some resources have already been fetched. For example, images might be stored in
		the <a href="https://html.spec.whatwg.org/multipage/images.html#list-of-available-images">list of available images</a> prior to dynamically inserting a <code>meta</code>
		element with an <code>http-equiv</code> attribute in the Content security policy state.
		Resources that have already been fetched are not guaranteed to be blocked by a <a href="https://w3c.github.io/webappsec-csp/#content-security-policy-object">Content
			Security Policy</a> that's <a href="https://w3c.github.io/webappsec-csp/#enforced">enforced</a> late.
		</p>
	</blockquote>
	<figcaption>
		&mdash; <span class="h-cite" itemprop="citation" role="doc-credit">
			<span itemprop="isPartOf" itemscope itemtype="https://schema.org/TechArticle">
				<cite itemprop="name headline" class="p-name">HTML Living Standard</cite>, section 4.2.5.3: Pragma directives,
				<a class="u-url" itemprop="url" href="https://html.spec.whatwg.org/multipage/semantics.html#attr-meta-http-equiv-content-security-policy">Content Security Policy state</a>
			</span>
		</span>
	</figcaption>
</figure>

### If you must enable scripts

Please use progressive enhancement (<abbr title="progressive enhancement">PE</abbr>)[^3] throughout your site; every feature possible should be optional, and scripting is no exception.

I'm sure you're a great person, but your readers might not know that; don't expect them to trust your website. Your scripts should look as safe as possible to an untrusting eye. Avoid requesting permissions or using [sensitive APIs](https://browserleaks.com/javascript).

Finally, consider using your CSP to restrict script loading. If you must use inline scripts, selectively allow them with a hash or nonce. [Some recent directives](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/trusted-types) restrict and enforce proper use of [trusted types](https://web.dev/trusted-types/).

### Third-party content

Third-party content will complicate the CSP, allow more actors to track users, possibly slow page loading, and create more points of failure. Some privacy-conscious users actually block third-party content: while doing so is fingerprintable, it can reduce the amount of data collected about an already-identified user. Avoid third-party content, if at all possible.

Some web developers deliver resources using a third-party content delivery network (<abbr title="content delivery network">CDN</abbr>), such as jsDelivr or Unpkg. Traditional wisdom held that doing so would allow different websites to re-use cached resources; however, all mainstream browsers engines now [partition their caches](https://privacycg.github.io/storage-partitioning/) to prevent this behavior.

If you must use third-party content, use [subresource integrity](https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity) (check the [<abbr title="Subresource Integrity">SRI</abbr> specification](https://www.w3.org/TR/SRI/)). This prevents alteration without your consent. If you wish to be extra careful, you could use SRI for first-party resources too.

Be sure to check the privacy policies for the third party services _and_ subscribe to updates, as their practices could impact the privacy of all your users.

For embedded third-party content (e.g. images), give extra consideration to the ["Beyond alt-text" section](#beyond-alt-text). Your page should be as useful as possible if the embedded content becomes inaccessible.

Optimal loading
---------------

Nearly every Internet user has to deal with unreliable connections every now and then, even the top 1%. Developing regions lack modern Internet infrastructure; high-ranking executives travel frequently. Everybody hits the bottom of the bell-curve.

Reducing load time is especially useful to poorly-connected users. For much of the world, connectivity comes in short bursts during which loading time is precious. Chances of a connection failure or packet loss increase with time.

Optimal loading is a complex topic. Broadly, it covers three overlapping categories: reducing payload size, delivering content early, and reducing the number of requests and round trips.

### Blocking resources

HTML is a blocking resource: images and stylesheets will not load until the user agent loads and parses the HTML that calls them. To start loading above-the-fold images before the HTML parsing finishes, send a `link` HTTP header.

<figure itemscope itemtype="https://schema.org/SoftwareSourceCode">
<figcaption>

<strong itemprop="codeSampleType">Code snippet</strong>: my website includes a `link` header to load an SVG that serves as my IndieWeb photo and favicon. Hash removed from filename for readability.

</figcaption>

<pre><samp itemprop="text">link: &lt;/favicon.<var>HASH</var>.svg&gt;; rel=preload; as=image</samp></pre>

</figure>

### Don't count on the cache

The browser cache is a valuable tool to save bandwidth and improve page speed, but it's not as reliable as many people seem to believe. Don't focus too much on "repeat view" performance.

Out of privacy concerns, most browsers no longer re-use cached content across sites; refer back to the section on [third-party content](#third-party-content) for more details. Privacy-conscious users (including all users using "private" or "incognito" sessions) will likely have their caches wiped between sessions.

Requesting a high number of cached resources can decrease performance of the cache, causing browsers to [bypass the cache](https://simonhearne.com/2020/network-faster-than-cache/). The effect is especially pronounced on low-end phones and mechanical hard drives.

One way to help browsers decide which disk-cached resources to prioritize is to use immutable assets. Include the `immutable` directive in your `cache-control` headers, and cache-bust modified assets by changing their URLs.

<figure itemscope itemtype="https://schema.org/SoftwareSourceCode">
<figcaption>
<strong itemprop="codeSampleType">Code snippet</strong>: The only external assets on my pages are images and a web app manifest (for icons); I mark these assets as "immutable" and cache-bust them by including checksums in their filenames.
</figcaption>
<pre><samp itemprop="text">cache-control: max-age=31557600, immutable</samp></pre>
</figure>

You can also keep your asset counts low by combining textual assets (e.g. CSS) and inlining small resources.

### Inline content

In addition to HTML, CSS is also a blocking resource. You could pre-load your CSS using a `link` header. Alternatively: if your gzipped CSS is under **one kilobyte,** consider inlining it in the `<head>` using a `<style>` element. Simply inlining stylesheets can pose a security threat, but the `style-src` <abbr title="Content Security Policy">CSP</abbr> directive can mitigate this if you include a hash of your inline stylesheet sans trailing whitespace.

Consider inlining images under 250&nbsp;bytes with a `data:` URI; that's the size at which cache-validation requests might outweigh the size of the image. My 32-pixel PNG site icon is under 150&nbsp;bytes and inlines quite nicely. On this site's hidden service, it's often the only image on a page (the hidden service replaces SVGs with PNGs; see the section on [the Tor Browser](#the-tor-browser)). Inlining this image and the stylesheet allows my hidden service's homepage to load in a single request, which is a welcome improvement given the round-trip latency that plagues onion routing implemen&shy;tations.

### Round-trips

Download size matters, especially on metered connections. There's no shortage of advice concerning minimizing this easy-to-understand metric. Unfortunately, it alone doesn't give us the full picture: download size is not the exact same thing as time taken to deliver useful content to users.

Google's answer to this problem is "Core Web Vitals" containing metrics such as [the Speed Index](https://docs.webpagetest.org/metrics/speedindex/). These metrics aren't useless, but they are incredibly naive.

<figure itemscope itemtype="https://schema.org/Quotation">
<blockquote itemprop="text">

SpeedIndex is based on the idea that what counts is how fast the visible part of the website renders. It doesn't matter what's happening elsewhere on the page. It doesn't matter if the network is saturated and your phone is hot to the touch. It doesn't matter if the battery is visibly draining. Everything is OK as long as the part of the site in the viewport appears to pop into view right away.

Of course, it doesn’t matter how fast the site appears to load if the first thing the completed page does is serve an interstitial ad. Or, if like many mobile users, you start scrolling immediately and catch the 'unoptimized' part of the page with its pants down.

There is only one honest measure of web performance: **the time from when you click a link to when you've finished skipping the last ad.**

Everything else is bullshit.

</blockquote>
<figcaption>
	&mdash; <span class="h-cite" itemprop="citation" role="doc-credit">
			<span itemprop="isPartOf" itemscope itemtype="https://schema.org/PresentationDigitalDocument">
				{{<indieweb-person first-name="Maciej" last-name="Cegłowski" url="https://idlewords.com/about.htm" itemprop="author">}},
				{{<cited-work name="The Website Obesity Crisis" url="https://idlewords.com/talks/website_obesity.htm" extraName="headline">}}
			</span>
	</span>
</figcaption>
</figure>

Plenty of other factors exist, but listing them all is beyond the scope of this article.

A supplementary metric to use alongside download size is **round trips.** Estimate the number of bytes and round-trips it takes to do the following:

1. Begin downloading the final blocking resource
2. Finish downloading all blocking resources
3. Finish downloading _two screenfuls of content_
4. Finish downloading the full page.

### Congestion control

Understanding round-trips requires understanding your server's approach to congestion control.

Historically, TCP congestion control approaches typically set an initial window size to ten TCP packets and grew this value with each round-trip. Under most setups, this meant that the first round-trip could include 1460 bytes. The following round-trip could deliver under three kilobytes.[^4]

Nowadays, servers typically employ BBR-based congestion control. It allows for regular "spikes" in window size, but the initial window size is still small. Find more details in the slides from <span class="h-cite" itemscope itemtype="https://schema.org/PresentationDigitalDocument"> <cite class="p-name" itemprop="name headline" ><a class="u-url" itemprop="url" href="https://labs.apnic.net/presentations/store/2019-09-05-bbr.pdf">TCP and BBR</a></cite> (PDF) by {{<indieweb-person first-name="Geoff" last-name="Huston" itemprop="author" url="https://www.potaroo.net/" org="APNIC" org-url="https://www.apnic.net/">}} </span>

HTTP/3 uses QUIC instead of TCP, which makes things a bit different; the important thing to remember is that _user agents should be aware of all blocking resources **before** finishing the earliest possible round-trip._

### The golden kilobyte

Assume that your first impression must fit in the first kilobyte. Make good use of this golden kilobyte; most or all of it will likely be taken up by HTTP headers.[^5] Ideally, the first kilobyte transferred should inform the client of all blocking resources required, possibly using preload directives; all of these resources can then begin downloading over the same multiplexed HTTP/2 connection before the current round-trip finishes! Note that this works best if you took my earlier advice to [avoid third-party content](#third-party-content).

Apply these strategies in moderation. Including extra preload directives in your document markup might not help as much as you think, since their impact on page size could negate minor improvements. Micro-optimizations have diminishing returns; past a certain point, your effort is better spent elsewhere.

### Layout shifts

Loading content of unknown dimensions, such as images, can create layout shifts; the <abbr title="Web Incubator Community Group">WICG</abbr>'s <cite>[Layout Instability API](https://wicg.github.io/layout-instability/#sec-intro)</cite> describes the phenomenon in detail. Avoid layout shifts by including dimensions in HTML attributes. The simplest way to do so is by including unitless `width` and `height` values, but the `style` attribute could work too. I recommend staying away from the `style` attribute, or at least selectively allowing its use with the `style-src-attr` CSP directive.

### Other server-side tweaks

In-depth server configuration is a bit out of scope, so I'll keep each improvement brief.

Compression--especially static compression--dramatically reduces download sizes. My full-text RSS feed is about a quarter of a megabyte, but the Brotli-compressed version is around 70 kilobytes. Caddy supports this with a `precompressed` directive; Nginx requires a [separate module](https://github.com/google/ngx_brotli) for Brotli compression.

When serving many resources at once (e.g., if a page has many images), HTTP/2 could offer a speed boost through multiplexing; use it if you can, but expect many clients to only support HTTP/1.1. HTTP/3 is unlikely to help textual websites much, so run a benchmark to see if it's worthwhile.

Consider caching static assets indefinitely with a year-long duration in their `cache-control` headers, possibly with an `immutable` parameter. If you have to update a static asset, cache-bust it by altering the URL. This approach should eliminate the need for an `etag` header on static assets.

Using [OCSP stapling](https://en.wikipedia.org/wiki/OCSP_stapling) eliminates the need to connect to a certificate authority, saving users a DNS lookup and allowing them to instead re-use a connection.

Consider the trade-offs involved in enabling 0-<abbr title="Round-Trip Time">RTT</abbr> for TLS 1.3. On one hand, it shaves off a round-trip during session resumption; on the other hand, it can enable replay attacks. 0-RTT shouldn't be too unsafe for idempotent GET requests of static content. For dynamic content, evaluate whether your backend is vulnerable to replay attacks described in [appendix E.5](https://www.rfc-editor.org/rfc/rfc8446.html#appendix-E.5) of the spec.

The Tor Browser
---------------

Many people use Tor out of necessity. On Tor, additional constraints apply.

For one, Tor users are encouraged to set the Tor Browser Bundle's (<abbr title="Tor Browser Bundle">TBB</abbr>) [security settings](https://tb-manual.torproject.org/en-US/security-settings/) to "safest". This disables scripts, MathML, some fonts, SVG images, and [other features](https://gitweb.torproject.org/torbutton.git/tree/modules/security-prefs.js). If your site has any SVG images, the Tor browser will download these just like Firefox would (to avoid fingerprinting) but will not render them.

Additionally, hopping between nodes in Tor circuits incurs latency, worsening the impacts of requiring multiple requests and round-trips. Try to minimise the number of requests to view a page.

If you use a CDN or some over&shy;complicated website security stack, make sure it doesn't block Tor users or require them to enable JavaScript to complete a CAPTCHA. Tor Browser users are supposed to avoid fingerprinting vectors like JS and browser extensions, so requiring a JavaScript-based CAPTCHA will effectively block many Tor users.

Tor users are unable to leverage media queries or client-hints to signal special needs. Pages need to be as accessible as possible _by default_. This should be a given, but it's doubly important when serving fingerprinting-averse readers.

### Hidden services

To go above and beyond, try mirroring your site to a Tor hidden service to reduce the need for exit nodes. Mirroring allows you to keep a separate version of your site optimized for the Tor browser.

Normally, optimizing specifically for a given user agent's quirks (especially in a separate version of a website) is a bad practice; however, the Tor Browser is a special case because there's no alternative available: Tor users should all use the same browser to avoid standing out. On top of that, the Tor Browser sometimes pretends to have Firefox's capabilities: progressive enhancement and graceful degradation won't work when a browser lies about its functionality.

For example, my website's clearnet version uses some SVG images. Some browsers can't handle a given image format. The typical solution is to use a `<picture>` element containing `<source>` children of varying formats and a fallback `<img>` element using a legacy image format.

The Tor browser will download whichever format Firefox would, rather than whichever formats it actually supports. A `<picture>` element containing an SVG and a raster fallback won't help: the Tor browser will avoid fingerprinting by selecting the SVG format, not a fallback format. The image will not be rendered, so users will have downloaded the image only to see a white box.

I address the issue by not using any SVG images on [my hidden service](http://wgq3bd2kqoybhstp77i3wrzbfnsyd27wt34psaja4grqiezqircorkyd.onion/).

Against lazy loading
--------------------

Lazy loading may or may not work. Some browsers, including Firefox and the Tor Browser, disable lazy-loading when the user turns off JavaScript. Turning it off makes sense because lazy-loading, like JavaScript, is a fingerprinting vector. Specifically, it identifies idiosyncratic scrolling patterns:

<figure itemscope itemtype="https://schema.org/Quotation">
	<blockquote itemprop="text">
		<p>Loading is only deferred when JavaScript is enabled. This is an anti-tracking measure, because if a user agent supported lazy loading when scripting is disabled, it would still be possible for a site to track a user's approximate scroll position throughout a session, by strategically placing images in a page's markup such that a server can track how many images are requested and when.</p>
	</blockquote>
	<figcaption>
		&mdash; <span class="h-cite" itemprop="citation" role="doc-credit">
			<span itemprop="isPartOf" itemscope itemtype="https://schema.org/TechArticle">
				{{<cited-work name="<img>: The Image Embed element" url="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/img" extraName="headline">}}
				on <abbr title="Mozilla Developer Network">MDN</abbr>,
				<a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/img#attr-loading"> the <code>loading</code> attribute</a>
			</span>
		</span>
	</figcaption>
</figure>

If you can't rely on lazy loading, your pages should work well without it. If pages work well without lazy loading, is it worth enabling?

The scope of this article is textual content supplemented by images. In that context, I don't think lazy loading is worthwhile because it often frustrates users on slow connections. I think I can speak for some of these users: mobile data near my home has a number of "dead zones" with abysmal download speeds, and my home's Wi-Fi repeater setup used to result in packet loss rates above 60%&nbsp;(!!).

Users on poor connections have better things to do than idly wait for pages to load. They might open multiple links in background tabs to wait for them all to load at once, and/or switch to another task and come back when loading finishes. They might also open links while on a good connection before switching to a poor connection. For example, I often open several links on Wi-Fi before going out for a walk in a mobile-data dead-zone. A Reddit user reading an earlier version of this article described a [similar experience](https://i.reddit.com/r/web_design/comments/k0dmpj/an_opinionated_list_of_best_practices_for_textual/gdmxy4u/) riding the train.

Unfortunately, pages with lazy loading don't finish loading off-screen images in the background. To load this content ahead of time, users need to switch to the loading page and slowly scroll to the bottom to ensure that all the important content appears on-screen and starts loading. Website owners shouldn't expect users to have to jump through these ridiculous hoops.

### Against speculative pre-loading

A common objection to my case against lazy-loading is that users may be more likely to click a link than scroll to the bottom, so pages should prioritize pre-loading the link. Pre-loading a page's essential resources is fine. Speculatively pre-loading content on separate pages isn't.

Many users with poor connections also have capped data, and would prefer that pages don't decide to predictively load many pages ahead-of-time for them. The overlap between these two groups grows especially pronounced as data cap overages trigger throttling; this is enough to trigger [a seasonal pattern in Japan](https://web.archive.org/web/20220402004738/https://nitter.pussthecat.org/yoavweiss/status/1195036487538003968).

Some go so far as to disable this behavior to avoid data overages. Savvy privacy-conscious users (including Tor Browser users) also generally disable speculative pre-loading since pre-loading behavior is fingerprintable.

Users who click a link _choose_ to load a full page. Loading pages that a user hasn't clicked on is making a choice for that user. I encourage adoption of "link" HTTP headers to pre-load essential and above-the-fold resources when possible, but doing so does not resolve the issues with lazy-loading: the people who are harmed by lazy loading are more likely to have pre-fetching disabled.

Moreover, determining the pages to prioritize for speculative pre-loading typically requires analytics and/or A/B testing. Enrolling users in a study (e.g. by collecting information about their behavior) without prior informed consent _in terms they fully understand_ demonstrates a disrespect for their autonomy. Furthermore: analytics typically represent all users equally, when developers should be giving disproportionate attention to marginalized users (e.g., disabled users). The convenience of the majority should not generally outweigh the needs of the minority. Many marginalized people don't wish to broadcast the fact that they have special needs, so don't rely on being able to figure out who's whom.

### Can't users on poor connections disable images?

I have two responses:

1. If an image isn't essential, don't include it in the page. If an image is essential, assume sighted users want to see it.
2. Yes, users could disable images. That's _their_ choice. If your page uses lazy loading, you've effectively (and probably unintention&shy;ally) made that choice for a large number of users.

Nonetheless, expect some readers to have images disabled. Refer to the "[Beyond alt-text](#beyond-alt-text)" section to see how to best support this case.

### Related issues

Pages should finish making all `GET` network requests while loading. This makes it easy to load pages in the background before disconnecting. I singled out lazy-loading, but other factors can violate this constraint.

One example is pagination. It's easier to download one long article ahead of time, but inconvenient to load each page separately. Displaying content all at once also improves searchability. The single-page approach has obvious limits: don't expect users to happily download a single-page novel.

Another common offender is infinite-scrolling. In addition to requiring JavaScript, infinite-scrolling also makes it difficult for readers to find their old place upon re-visiting a page. This creates harsh consequences for accidental navigation. WordPress documentation [lists more problems](https://make.wordpress.org/accessibility/handbook/markup/infinite-scroll/)[^6].

<figure>
<a href="https://explainxkcd.com/1309/#Transcript">
{{< picture name="infinite_scrolling" alt="Comic: if books had infinite-scroll, we'd have to turn pages carefully or risk losing the page. Transcript in caption.">}}
</a>
<figcaption>

Infinite-scrolling means that accidentally navigating to a link will result in losing your place. Source: [xkcd](https://xkcd.com/1309/). Transcript [on the "explain xkcd" wiki](https://explainxkcd.com/1309/#Transcript).

</figcaption>
</figure>

A hybrid between the two is paginated content in which users click a "load next page" link to load the next page below the current page (typically using "dynamic content replacement"). It's essentially the same as infinite scrolling, except additional content is loaded after a click rather than by scrolling. This is only slightly less bad than infinite scrolling; it still has the same fundamental issue of allowing readers to lose their place.

I've discussed loading pages in the background, but what about saving a page offline (e.g. with <kbd>Ctrl</kbd> + <kbd>s</kbd>)? While lazy-loading won't interfere with the ability to save a complete page offline, some of these related issues can. Excessive pagination and inline scrolling make it impossible to download a complete page without manually scrolling or following pagination links to the end.

### Other ways to defer content

Deferring network requests is a bad idea, but there are other ways to improve large-page performance.

A similar image attribute that I _do_ recommend is the [`decoding`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/Img#attr-decoding) attribute. I typically use `decoding="async"` so that image decoding can be deferred.

Long pages with many DOM nodes may benefit from CSS containment, a more recently-adopted part of the CSS spec.

<dfn>CSS containment</dfn> allows authors to isolate sub-trees of the DOM. Combined with a property like "content-visibility", it enables browsers to defer rendering of less essential below-the-fold content. Try to avoid the `hidden` parameter when `auto` is better:

<figure itemscope itemtype="https://schema.org/Quotation">
<blockquote itemprop="text">

`content-visibility: auto` is a more complex value than `hidden`; rather than being similar to `display: none`, it adaptively hides/<wbr>displays an element's contents as they become <a href="https://drafts.csswg.org/css-contain/#relevant-to-the-user">relevant to the user</a>. It also doesn’t hide its <a href="https://drafts.csswg.org/css-contain/#skips-its-contents">skipped contents</a> from the user agent, so screen readers, in-page search, and other tools can still interact with it.

</blockquote>
<figcaption>
	&mdash;
	<span class="h-cite" itemprop="citation" role="doc-credit">
		<span itemprop="isPartOf" itemscope itemtype="https://schema.org/TechArticle">
			<cite itemprop="name headline" class="p-name">CSS Containment Module Level 2</cite>, section 4.2:
			<a class="u-url" itemprop="url" href="https://drafts.csswg.org/css-contain/#using-cv-auto">Using <code>content-visibility: auto</code></a>
		</span>
	</span>
</figcaption>
</figure>

Leveraging containment is a progressive enhancement, so there aren't any serious implications for older browsers. I use it for my site footers and endnotes.

Using containment for content at the end of the page is relatively safe. Using it for content earlier in the page risks introducing [layout shifts](#layout-shifts). Eliminate the layout shifts by calculating a value for the `contain-intrinsic-size` property. <cite><a href="https://www.terluinwebdesign.nl/en/css/calculating-contain-intrinsic-size-for-content-visibility/">Calculating 'contain-intrinsic-size' for 'content-visibility'</a></cite>, by {{<indieweb-person first-name="Thijs" last-name="Terluin" url="https://www.terluinwebdesign.nl/en/about-us/thijs-terluin/" org="Teluin Webdesign" org-url="https://www.terluinwebdesign.nl/en/">}}, is a comprehensive guide to calculating intrinsic size values.

In-page search
--------------

In-page search (e.g., using <kbd>Ctrl</kbd> + <kbd>f</kbd>) has been a basic feature in document readers well before browsers, and continues to be an essential feature today.

Web pages that hide content behind "show content" widgets are difficult to search through: users need to toggle "show content" for each item they wish to search. Often, in-page search highlights are hidden; Reddit's atrocious redesign is a serious offender.

<figure>
{{<picture name="find" alt="searching for the word \"good\" in the phrase \"I wonder how much good a\" when a \"see more\" link obscures the words \"good a\", before and after revealing the hidden text.">}}
<figcaption>

Searching for the word "good" before (above) and after (below) a "see more" link is clicked. Both situations show a match, but only one of them allows us to view the match. Both screenshots are from the Reddit redesign.

</figcaption>
</figure>

If you need to hide some content for performance reasons, I described a less hostile way to do so in [the "other ways to defer content" section](#other-ways-to-defer-content).

Searchability is another reason to prefer conveying information textually, when possible: video (especially without accurate captions), pictures of text, etc. aren't so easily searchable.

### The importance of proofreading

Correct, consistent spelling is important to readers who use search. In-page search doesn't currently pick up misspelled words. If in-page search implementations develop such a feature, some users may wish to sometimes turn it off; even Google Search implemented a "verbatim" mode for exact matches.

Moreover, some search implementations (such as the one built into Firefox) support case-sensitive matching. Inconsistent capitalization of proper nouns, acronyms, and initialisms can make searching difficult.

### Problematic overrides

Search is so essential to some users' ability to navigate that some desktop users enable "type-ahead" search, to automatically begin a search upon typing multiple characters.[^7] If you ignored my advice to avoid JavaScript, at least think twice before using it to define custom keyboard shortcuts which interfere with this type of functionality. I singled out type-ahead search, but there are countless other examples of uncommon keyboard behavior that JavaScript overrides interfere with.

Another problematic override is scroll-behavior. Enforcing smooth-scrolling (e.g., with the `scroll-behavior` CSS property) can interfere with the use of in-page search by slowing down jumps between matches. Rapidly darting around the page with smooth scrolling can cause motion sickness. Simply relying on users to override default behaviors violates the "inclusive by default" directive I encourage, since user preferences are fingerprintable and shift responsibility away from developers.

There's a complex solution to [turn off smooth scrolling for un-focused elements](https://schepp.dev/posts/smooth-scrolling-and-page-search/), but it doesn't address separate issues such as anchor-link navigation.

About fonts
-----------

I recommend setting the default font to `sans-serif`. [`system-ui` causes issues](https://infinnie.github.io/blog/2017/systemui.html) among readers whose system fonts don't cover your website's charset.

If you really want, you could use serif instead of sans-serif; however, serif fonts tend to look worse on low-res monitors. Not every screen's <abbr title="Dots Per Inch">DPI</abbr> has three digits. Accommodate users' default zoom levels by keeping your font size the same as most similar websites.

To ship custom fonts is to assert that branding is more important than user choice. That might very well be a reasonable thing to do; branding isn't evil! That being said, textual websites in particular don't benefit much from branding. Beyond basic layout and optionally supporting dark mode, authors generally shouldn't dictate the presentation of their websites; that should be the job of the user agent. Most websites are not important enough to look completely different from the rest of the user's system.

A personal example: I set my preferred browser font to `sans-serif`, and map it to my preferred font in my computer's fontconfig settings. Now every website that uses sans-serif will have my preferred font. Sites with sans-serif blend into the users' systems instead of sticking out.

### But most users don't change their fonts...

The "users don't know better and need us to make decisions for them" mindset isn't without merits; however, in my opinion, it's overused. Using system fonts doesn't make your website harder to use, but it does make it smaller and stick out less to the subset of users who care enough about fonts to change them. This argument isn't about making software easier for non-technical users; it's about branding by asserting a personal preference.

### Can't users globally override stylesheets instead?

It's not a good idea to require users to automatically override website stylesheets to see their preferred fonts. Doing so would break websites that use fonts such as Font Awesome to display vector icons. We shouldn't have these users constantly battle with websites the same way that many ad- and script-blocking users (myself included) already do when there's a better option.

That being said, many users _do_ actually override stylesheets. We shouldn't _require_ them to do so, but we should keep our pages from breaking in case they do. Pages following this article's advice will probably work perfectly well in these cases without any extra effort.

### Font finger&shy;printing concerns

Some people raised fingerprinting concerns when I suggested using the default "sans-serif" font. Websites could see which font this maps to in order to identify users.

I don't know much about fingerprinting, except that you can't do font enumeration or accurately calculate font metrics without JavaScript. Since text-based websites that follow these best-practices don't send requests after the page loads and have no scripts, they shouldn't be able to fingerprint via font identification.

Other websites can still fingerprint via font enumeration using JavaScript. They don't need to stop at seeing what sans-serif maps to: they can see available fonts on a user's system,[^8] the user's canvas fingerprint, window dimensions, etc. Some of these can be mitigated by [Firefox's protections against fingerprinting](https://support.mozilla.org/en-US/kb/firefox-protection-against-fingerprinting), but these protections understandably override user font preferences.

Ultimately, surveillance self-defense on the web is an arms race full of trade-offs. If you want both privacy and customizability, the web is not the place to look; try Gemini or Gopher instead.

### Zoom and font size

Browsers allow users to zoom by adjusting size metrics. Additionally, most browsers allow users to specify a minimum font size. Minimum sizes don't always work; setting size values in `px` can override these settings.

In your stylesheets, avoid using `px` where possible. Define sizes and dimensions using relative units (preferably `em`). Exceptions exist for some decorations[^9] (e.g. borders), but they are uncommon.

<figure itemscope itemtype="https://schema.org/SoftwareSourceCode">
<figcaption>

<strong itemprop="codeSampleType">Code snippet</strong>: set font size and line-spacing with a percentage and a unitless value, respectively.

</figcaption>
<pre><code itemprop="text">font: 100%/1.5 sans-serif;</code></pre>
</figure>

Beyond alt-text
---------------

Note: this section does not include examples of its own. If you wish to see examples, look at the figures in the official version of this web page. You're probably on it right now; if not, [here's the canonical location](https://seirdy.one/2020/11/23/website-best-practices.html).

Expect some readers to have images disabled or unloaded. Examples include:

* Blind readers
* Users with metered connections: sometimes they disable all images, and other times they only disable images above a certain size
* People experiencing packet loss who fail to download some images
* Users of textual browsers

Accordingly, follow good practices for alt-text:

* Concisely summarize the image content the best you can, without repeating the surrounding content.
* Images with a low information density should usually have alt-text under 120 characters.
* Don't include significant information that isn't present in the image; I'll cover how to handle supplementary information in the next subsections.

The <abbr title="Web Accessibility Initiative">WAI</abbr> provides some guidelines in <cite>[An `alt` Decision Tree](https://www.w3.org/WAI/tutorials/images/decision-tree/)</cite>. It's a little lacking in nuance, but makes for a good starting point. Remember that guidelines and "good practices" always have exceptions.

### Putting images in context

Alt text should be limited to describing content of the image. It lacks context. To make things worse, images can contain a great deal of information. Sighted people can "filter" this information and find areas to focus on; alt text should capture this detail. However, sighted users' understanding of this detail can be informed by surrounding less-essential detail.

Blind users might struggle to view images in context; they can't easily scan the text before and after an image non-linearly if there's no semantic connection between them.

<figure itemscope itemtype="https://schema.org/Quotation">
	<blockquote itemprop="text">
		<p>Try reading your screen through a drinking straw for an hour to get an idea of the limited context that a blind user has. You simply cannot scan the entire page at a glance with a screenreader - you have to listen to the structure of it carefully and remember all that, or read through the entire thing to find stuff, unless there are explicit associations such as longdesc.</p>
	</blockquote>
	<figcaption>
		&mdash; <span class="h-cite" itemprop="citation" role="doc-credit">
			<span itemprop="isPartOf" itemscope itemtype="https://schema.org/EmailMessage">
				{{<indieweb-person first-name="Charles" last-name="McCathieNevile" url="https://www.w3.org/People/Charles/" itemprop="sender">}},
				{{<cited-work name="longdesc Re: Clarification of rational for deprecation..." extraName="headline" url="https://lists.w3.org/Archives/Public/public-html/2008Feb/0061.html">}}
			</span>
		</span>
	</figcaption>
</figure>

Being sighted and loading images can introduce issues of its own. Sometimes, sighted readers might focus on the _wrong_ part of an image. How can you give readers the missing context and tell them what to focus on?

The best solution comes in two parts:

1. Before the image, supply context that prepares readers for what to expect.
2. After the image, describe your interpretation of important details.

This is somewhat similar to the way most students in primary and secondary schools are taught to cite evidence in essays. On that note: remember that these are weak norms, not rules. Deviate where appropriate, just as students should as they learn to write.

### Figures

A <dfn>figure</dfn> is any sort of self-contained information that is referenced by--but somewhat distinct from--body content. Items that make for good figures are often found in [floating blocks](https://en.wikipedia.org/wiki/Page_layout#Floating_block) of print material.

Consider using a `<figure>` element when employing the previous section's two-part strategy. Place one of the two aforementioned pieces of information in a `<figcaption>`; the caption can come before or after the image.

Figures aren't just for images; they're for any self-contained referenced content that's closer to the surrounding body than an `<aside>`. Some example items that could use a caption:


Blockquote
: Captioned with a citation

Code snippet
: Captioned with its purpose or a link to a the larger file from which the snippet was borrowed

Equation
: Sometimes captioned with a brief explanation of its behavior, purpose, or significance. Remember to add alt-text.

Figures and captions have loose guidelines, and nearly everything I said on the matter is full of exceptions. A figure need not have a caption, but the majority benefit from one. It need not contain a single main element, but most probably should.

I personally try to maintain the flow of an article even if its figures and captions are completely removed or moved to an appendix. A figure is a "self-contained" block: user agents may re-position figure captions relative to the main figure content, or move the entire figure elsewhere; this is especially common in [reading-mode implementations](#non-browsers-reading-mode). The HTML specification explicitly notes this behavior.

<figure itemscope itemtype="https://schema.org/Quotation">
	<blockquote itemprop="text">
		<p>When a <code>figure</code> is referred to from the main content of the document by identifying
		it by its caption (e.g., by figure number), it enables such content to be easily moved away from
		that primary content, e.g., to the side of the page, to dedicated pages, or to an appendix,
		without affecting the flow of the document.</p>
		<p>If a <code>figure</code> element is <a href="https://html.spec.whatwg.org/multipage/dom.html#referenced">referenced</a> by its relative position, e.g.,
		"in the photograph above" or "as the next figure shows", then moving the figure would disrupt the
		page's meaning. Authors are encouraged to consider using labels to refer to figures, rather than
		using such relative references, so that the page can easily be restyled without affecting the
		page's meaning.</p>
	</blockquote>
	<figcaption>
		&mdash; <span class="h-cite" itemprop="citation" role="doc-credit">
			<span itemprop="isPartOf" itemscope itemtype="https://schema.org/TechArticle">
				<cite itemprop="name headline" class="p-name">HTML Living Standard</cite>, section 4.4.12:
				<a class="u-url" itemprop="url" href="https://html.spec.whatwg.org/multipage/grouping-content.html#the-figure-element">The <code>figure</code> element</a>
			</span>
		</span>
	</figcaption>
</figure>

### Image trans&shy;cripts {#image-transcripts}

Some images contain text. Only use pictures of text if the visual appearance of the text is an essential part of what you wish communicate.

If the image is a screenshot of text from a website, link to that website to allow users to read its contents in context; this can serve as an "image transcript" of sorts.

A <dfn>`longdesc`</dfn> attribute used to be another way to reference an image transcript. The `longdesc` attribute contained a hyperlink (often an anchor link) to a location with more information about an image. This attribute [has been obsoleted](https://html.spec.whatwg.org/multipage/obsolete.html#non-conforming-features) in the HTML Living Standard.

The recommended way to link to a transcript is by hyperlinking the image (i.e., wrapping it with `<a>`). Put a short summary in the alt-text, and mention that the hyperlink contains a transcript.

<figure>
<figcaption>
The xkcd comic <a href="#related-issues">included earlier in the page</a> had this alt-text:
</figcaption>

> Comic: if books had infinite-scroll, we'd have to turn pages carefully or risk losing the page. Transcript in caption.

</figure>

Image transcripts also help users relying on [machine-translation](#machine-translation), since translation tools rely on textual content (OCR is error-prone). These users won't read alt-text; have an alternative way to discover a transcript. Wherever you put the transcript, ensure it's semantically connected to the image. I linked a transcript in the figure caption.

I describe best practices for preparing pictures of text in [a dedicated section](#pictures-of-text).

About custom colors
-------------------

Some users' browsers set default page colors that aren't black-on-white. For instance, Linux users who enable GTK style overrides might default to having white text on a dark background. Websites that explicitly set foreground colors but leave the default background color (or vice-versa) end up being difficult to read. The same phenomenon occurs on pages with text on top of background images. Don't strain your eyes trying to read this example:

<figure>
{{< picture name="website_colors" alt="Screenshot of a website with gray text on a darker gray background. Details in caption." >}}
<figcaption>

This is an unreadable screenshot of a [website promoting browser style overrides](http://bettermotherfuckingwebsite.com/) (specifically, the "A little less contrast" section). I had set my browser foreground and background colors to white and dark gray, respectively. The website overrode the foreground colors while assuming that everyone browses with a white background.

</figcaption>
</figure>

A second opinion: {{% indieweb-person first-name="Chris" last-name="Siebenmann" url="https://utcc.utoronto.ca/~cks/" %}} describes this in more detail in <cite>[AWebColours&shy;Problem](https://utcc.utoronto.ca/~cks/space/blog/web/AWebColoursProblem)</cite>. In short: when setting colors, always set both the foreground and the background color. Don't set just one of the two.

Chris also describes the importance of visited link colors in <cite>[VisitedLinks<wbr>Usability](https://utcc.utoronto.ca/~cks/space/blog/web/VisitedLinksUsability)</cite>.

### Color overrides and accessibility

Even if you set custom colors, ensure that the page is compatible with color overrides: elements shouldn't be distinguished solely by foreground and background color. [Technique C25](https://www.w3.org/WAI/WCAG22/Techniques/css/C25) for the <cite>Web Content Accessibility Guidelines (<abbr title="Web Content Accessibility Guidelines">WCAG</abbr>)&nbsp;2.2</cite> describes how doing so can meet the WCAG&nbsp;2.2's [Success Criterion&nbsp;1.4.8](https://www.w3.org/WAI/WCAG22/Understanding/visual-presentation). Specifically, it describes using default colors in combination with visible borders. The latter helps distinguish elements from surrounding content without relying on a custom color palette.

This page's [canonical location](https://seirdy.one/2020/11/23/website-best-practices.html) is an example application of Technique C25 (and the related [Technique G148](https://www.w3.org/WAI/WCAG22/Techniques/general/G148)). It only uses non-default colors when a user agent requests a dark color scheme (using the `prefers-color-scheme` CSS media query; see the next subsection) and for lightening borders. Any image with a solid background may match the page background; to ensure that their dimensions are clear, I surrounded them with borders. I also set a custom color for the borders and ensure that the image backgrounds don't match the border colors. I included borders to break up bottom sections, since these elements lack heading-based delineation. When overriding color schemes, the page layout remains clear.

Color overrides go well beyond simple foreground and background color changes. Windows' High Contrast Mode, for instance, makes [more advanced modifications](https://accessabilly.com/accessibility-issues-concerning-windows-high-contrast-mode/).

In fact, the CSS Working Group is working on a specification for re-coloring websites in <span itemscope itemtype="https://schema.org/TechArticle">{{<cited-work name="CSS Color Adjustment Module Level 1" extraName="headline" url="https://drafts.csswg.org/css-color-adjust-1/">}}</span>. The Chromium team's in-progress [auto dark mode](https://chromestatus.com/feature/5672533924773888) will use this specification to darken websites globally. Websites can opt out with the `color-scheme` property, but they really shouldn't have to: stylesheets should be robust enough to handle re-coloring.

### Dark themes

If you do explicitly set colors, please also include a dark theme using a media query: `@media (prefers-color-scheme: dark)`. For more info, read the relevant docs [on MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-color-scheme). Dark themes are helpful for readers with migraines, photosensitivity (like me!), or dark environments.

If you include a `theme-color` directive in your document `<head>`, then recent browsers will automatically switch their default stylesheets to dark-mode. Unfortunately, some older browsers (like Firefox-ESR) don't support this directive, and WebKit's default dark stylesheet has [unreadable links](https://bugs.webkit.org/show_bug.cgi?id=209851). WebKit versions in the wild are often out of date, so a fixed stylesheet would need to be out for many years before I would consider using default dark stylesheets.

<figure>
{{<picture name="wk_link" alt="dark blue link on dark gray background.">}}
<figcaption>WebKit's default dark stylesheet uses dark-colored links that are difficult to read.</figcaption>
</figure>

When setting colors, especially for a dark background, I recommend checking your page's contrast using Advanced Perceptual Contrast Algorithm (<abbr title="Advanced Perceptual Contrast Algorithm">APCA</abbr>) values. You can do so in an [online checker](https://www.myndex.com/APCA/) (requires JavaScript) or Chromium's developer tools (you might have to enable them in a menu for experimental preferences). Blue and purple links on a black background have much worse perceptual contrast than yellow or green links.

Note that [the APCA isn't fully mature](https://yatil.net/blog/wcag-3-is-not-ready-yet) as of early 2022. Until version 3.0 of the WCAG is ready, pages should also conform to the contrast ratios described in the WCAG&nbsp;2.2's success criteria 1.4.3 (Contrast: Minimum, level AA) or 1.4.6 (Contrast: Enhanced, level AAA). This site's dark-mode stylesheet is an example of a palette that conforms to both the WCAG&nbsp;2.2 AAA contrast requirements and APCA recommendations.

CSS filters such as `invert` are expensive to run, so use them sparingly. Simply inverting your page's colors to provide a dark theme could slow it down or cause a user's fans to spin.

Darker backgrounds draw less power on devices with OLED screens; however, backgrounds should never be solid black. White text on a black background causes halation, especially among astigmatic readers. Halation comes from the word "halo", and refers to a type of "glow" or ghosting around words. There has been some [experimental](https://www.laurenscharff.com/research/AHNCUR.html) and plenty of [anecdotal](https://jessicaotis.com/academia/never-use-white-text-on-a-black-background-astygmatism-and-conference-slides/) evidence to support this.

<figure>
<figcaption>

This image is an approximation of what halation looks like, cropped from <a href="https://www.essentialaccessibility.com/blog/accessibility-for-people-with-astigmatism">Essential Accessibility</a>.

</figcaption>
{{< picture name="halation" alt="Fuzzy white text on black background reading \"But it is not\"." >}}
</figure>

"Just disable dark mode" is a poor response to users complaining about halation: it ignores the utility of dark themes described at the beginning of this section.

If you can't bear the thought of parting with your solid-black background, worry not: there exists a CSS media feature and client-hint for contrast preferences called `prefers-contrast`. It takes the parameters `no-preference`, `less`, and `more`. You can serve increased-contrast pages to those who request `more`, and vice versa. Check section 11.3 of the W3C <span itemscope itemtype="https://schema.org/TechArticle">{{<cited-work url="https://drafts.csswg.org/mediaqueries-5/#prefers-contrast" name="Media Queries Level 5" extraName="headline">}}</span> specification for more information.

I personally like a foreground and background of `#eee` and `#0e0e0e`, respectively. These shades seem to be as far apart as possible without causing accessibility issues: `#0e0e0e` is barely bright enough to create a soft "glow" capable of minimizing halos among slightly astigmatic users, but won't ruin contrast on cheap displays. I also support a `prefers-contrast: less` media query which lightens the background to `#222`.

### Contrast under different conditions

Color palettes need to be effective for different types of vision deficiencies (e.g. color blindnesses) and screens. Color blindness is a far more nuanced topic than "the inability to see some colors". <span itemscope itemtype="https://schema.org/BlogPosting">{{<indieweb-person itemprop="author" first-name="Rob" last-name="Pike" url="http://herpolhode.com/rob/">}} describes his experience in {{<cited-work name="Color blindness" extraName="headline" url="https://commandcenter.blogspot.com/2020/09/color-blindness-is-inaccurate-term.html">}}</span>. Color blindness manifests in complex ways. Testing in grayscale is a great start, but it doesn't account for all kinds of color vision deficiencies.

Different screens and display-calibrations render color differently; what may look like a light-gray on a cheap monitor could look nearly black on a high-end OLED screen. Try to test on both high- and low-end displays, especially when designing a dark color scheme.

Color schemes should also look good to users who apply gamma adjustments. Most operating systems and desktop environments bundle a feature to lower the screen color temperature at night, while some individuals may select a higher one in the morning.

In defense of link under&shy;lines {#in-defense-of-link-underlines}
----------------------------------

Some typographers insist that [underlined on-screen text is obsolete](https://practicaltypography.com/underlining.html),[^10] and hyperlinks are no exception. I disagree.

One reason is that underlines make it easy to separate multiple consecutive inline links:

{{<picture name="underlines" alt="two lines with two consecutive hyperlinks each, one line with and one without underlines.">}}

Underlines also make it easy for color-blind readers to distinguish both the beginnings and ends of links. A basic WCAG Level A requirement is for information to not be conveyed solely through color:

<figure itemscope itemtype="https://schema.org/Quotation">
	<blockquote itemprop="text">
		<p>Color is not used as the only visual means of conveying information, indicating an action, prompting a response, or disting&shy;uishing a visual element. (Level A)</p>
	</blockquote>
	<figcaption>
		&mdash; <span class="h-cite" itemprop="citation" role="doc-credit">
			<span itemprop="isPartOf" itemscope itemtype="https://schema.org/TechArticle">
				<cite><a class="u-url p-name" itemprop="url" href="https://www.w3.org/TR/WCAG22/"><span itemprop="name headline">WCAG&nbsp;2.2</span></a></cite>, <a href="https://www.w3.org/TR/WCAG22/#distinguishable">section 1.4.1</a>
			</span>
		</span>
	</figcaption>
</figure>

Readers already expect underlined text to signify a hyperlink. Don't break fundamental affordances for aesthetics.

Image optimiza&shy;tion {#image-optimization}
-----------------------

Some image optimization tools I use:


[`pngquant`](https://pngquant.org)
: lossy PNG compression. Can reduce the size of the color palette.

[`oxipng`](https://github.com/shssoichiro/oxipng)
: Lossless PNG compression. It's like a parallelized version of [OptiPNG](http://optipng.sourceforge.net/) that also supports an implemen&shy;tation of [ZopfliPNG](https://github.com/google/zopfli/blob/831773bc28e318b91a3255fa12c9fcde1606058b/README.zopflipng) compression

[`jpegoptim`](https://github.com/tjko/jpegoptim)
: Lossless or lossy JPEG compression. Note that JPEG is an inherently lossy format; the lossless features of `jpegoptim` only shrinks the size of existing JPEG files by removing unnecessary metadata.

[`cwebp`](https://developers.google.com/speed/webp/docs/cwebp)
: The reference WebP encoder; has dedicated lossless and lossy modes. Lossy WebP compression isn't always better than JPEG, but lossless WebP consistently beats PNG.

`avifenc`
: The reference AVIF encoder, included in [libavif](https://github.com/AOMediaCodec/libavif)[^11]. AVIF lossless compression is typically useless, but its lossy compression is pretty unique in that it leans towards detail removal rather than introducing compression artifacts. Note that AVIF is not supported by Safari or most WebKit-based browsers.

I put together [a quick script](https://git.sr.ht/~seirdy/dotfiles/tree/3b722a843f3945a1bdf98672e09786f0213ec6f6/Executables/shell-scripts/bin/optimize-image) to losslessly optimize images using these programs. For lossy compression, I typically use [GNU Parallel](https://www.gnu.org/software/parallel/) to mass-generate images using different options before selecting the smallest image at the minimum acceptable quality. Users who'd rather avoid the command line while performing lossy compression can instead check out [Squoosh](https://squoosh.app/), a JavaScript app that bundles WebAssembly-compiled encoders; I've heard good things about it.

You also might want to use the HTML `<picture>` element, using JPEG/PNG as a fallback for more efficient formats such as WebP or AVIF, but only if the size savings are more significant than a couple hundred bytes. More info in the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/picture)

Most of my images will probably be screenshots that start as PNGs. My typical flow:

1. Re-size and crop the PNG. Convert to grayscale if colors isn't important.
2. Lossy compression with `pngquant`
3. Losslessly optimize the result with `oxipng` and its Zopfli backend (slow)
4. Also create a lossless WebP from the lossy PNG and a lossy WebP from the source image, using `cwebp`. Pick the smaller of the two.
5. Include the resulting WebP in the page, with a fallback to the PNG using a `<picture>` element.
6. Create a lossy AVIF image from the cropped full-color PNG, and include it in the `<picture>` element if it's smaller than the WebP. If color isn't important, use the YUV400 color space.
7. If the image is too light, repeat for a dark version of the image to display according to a `prefers-color-scheme: dark` media query.

<figure id="png-pipeline" itemscope itemtype="https://schema.org/SoftwareSourceCode">
<figcaption>

<strong itemprop="codeSampleType">Code snippet</strong>: this is a sample command to compress a PNG image using ImageMagick, `pngquant`, and `oxipng`. It shrinks the image, turns it grayscale, reduces the color palette, and then applies lossless Zopfli compression.

</figcaption>

<pre><code itemprop="text">convert <var translate="yes">ORIGINAL_FILE</var> \
  -resize 75% -colorspace gray -format png - \
  | pngquant -s 1 12 - \
  | oxipng -o max -Z --fix - --out <var translate="yes">OUTPUT_FILE</var>
</code></pre>

</figure>

In general, avoid loading images just for decoration. Only use an image if it has a clear purpose that significantly adds to the content in a way that text can't replace, and provide alt-text as a fallback. Any level of detail that isn't necessary for getting the point across should be removed by lossy compression and cropping.

If you want to include a profile photo (e.g., if your website is part of the IndieWeb and uses an [h-card](https://microformats.org/wiki/h-card)), I recommend re-using one of your favicons. Doing so should be harmless since most browsers will fetch and cache favicons anyway.

If you really want to take PNG optimization to the next level, try [Efficient Compression Tool](https://github.com/fhanau/Efficient-Compression-Tool).

### Breaking conventional wisdom

Some conventional wisdom for image compression doesn't hold up when compressing this aggressively; for instance, I've found that extremely aggressive dithering and PNG compression of small black-and-white images consistently surpasses JPEG compression.

Most resources on image optimization recommend considering progressive rendering. I don't recommend progressive rendering for below-the-fold images; if you optimize an image to just a few kilobytes, it should fully load in time. It's not worth the overhead below the 20&nbsp;kb range.

These resources also encourage authors to include different image variants for different viewport sizes, screen resolutions, and pixel densities. They often skip the caveats:

* Using different image files for different viewport sizes can cause the page to request more images as users re-size their window.
* Sending requests dependent on viewport and display characteristics is a fingerprinting vector, allowing servers to identify users by these properties.

Rather than create separate lanes for different users, I prefer making the defaults as inclusive as possible. A single image should look good under a variety of downscaling algorithms. It should be as small as it can be without losing essential information.

It might seem odd to create a lossless WebP from a lossy PNG, but I've found that it's often the best way to get the smallest possible image at the minimum acceptable quality for screenshots containing solid backgrounds.

### Dark image variants

Bright images on an otherwise dark page distract readers, especially readers like me with ADHD. The human iris adjusts to average amounts of light; an object far brighter than its surroundings causes eye strain even among readers with healthy vision.

A `<picture>` element allows selection of sources based on any CSS media query. When images have light backgrounds, I like to include dark variants to complement a dark stylesheet.

<figure itemscope itemtype="https://schema.org/SoftwareSourceCode">
<figcaption>
<strong itemprop="codeSampleType">Code snippet</strong>: a minimal example of a <code>picture</code> containing a dark variant:
</figcaption>

<pre>
<code itemprop="text">&lt;picture&gt;
&lt;source type="image/png"
  srcset="/p/dark.png"
  media="screen and (prefers-color-scheme: dark)"&gt;
&lt;img src="/p/light.png"
  alt="<var translate="yes">ALTERNATIVE_TEXT</var>"
  width="<var translate="yes">WIDTH</var>" height="<var translate="yes">HEIGHT</var>"&gt;
&lt;picture&gt;</code>
</pre>

</figure>

Requiring the `screen` media type prevents selection of dark variants when printing. Printer paper is almost always white, so dark images could waste ink. Ink waste is a sensitive issue among many students: school printers sometimes charge students who exceed a given ink quota. Ask me how I know!

Light and dark variants of legacy formats (PNG, JPG, GIF), WebP, and AVIF can cause some of my `<picture>` imagesets to have up to six image variants. I could fully automate the process using my static site generator (Hugo) if I wanted to. Since I do want to inspect each image and compress to the minimum acceptable quality, I settled for partial automation using shell scripts and [a Hugo shortcode](https://git.sr.ht/~seirdy/seirdy.one/tree/master/layouts/shortcodes/picture.html).

### SVG images

I only recommend using SVG in images; avoid using them in embeds, objects, or directly in the body. Remember that users may save images, and open them in a non-browser image viewer with reduced SVG compatibility. To maintain maximum compatibility, stick a the subset of the [secure static processing mode](https://www.w3.org/TR/SVG/conform.html#secure-static-mode) of [SVG Static](https://www.w3.org/TR/SVG11/feature#SVG-static). Specifically, the subset that appears in the [SVG Tiny Portable<wbr>/Secure (<abbr title="Portable/Secure">PS</abbr>) spec](https://datatracker.ietf.org/doc/draft-svg-tiny-ps-abrotman/). SVG Tiny PS is a subset of [SVG Tiny&nbsp;1.2](https://www.w3.org/TR/SVGTiny12/intro.html), which is a supported export format in most vector drawing programs. Ignore the elements specifically required for SVG Tiny PS; your image can be a standard SVG that only utilizes a tiny subset of the full SVG spec.

The above advice might seem daunting, but it’s usually easy to use existing tools to generate an SVG Tiny file and manually edit it to support the SVG secure static mode. SVGs that conform to this subset should be compatible with Qt5's SVG implemen&shy;tation, librsvg (used by Wikipedia and GNOME), and most operating systems' icon renderers.

Two tools that can optimize the size of an SVG file are [SVGO](https://github.com/svg/svgo) and the now-discontinued [svgcleaner](https://github.com/RazrFalcon/svgcleaner). Too much lossy SVG compression can sometimes _reduce_ the effectiveness of gzip and Brotli compression. Compress in moderation.

Layout
------

This is possibly the most subjective item I'm including, and the item with the most exceptions. Consider it more of a weak suggestion than hard advice. Use your own judgement.

The first or second heading in the DOM, and the highest heading level, should be the page title marking the start of your main content (i.e. it should come after the site title, site navigation links, etc). Only if this is impossible should you consider adding a "skip link" instead. Visually-impaired users generally prefer navigating by headings.

A simple layout looks good at a variety of window sizes, rendering responsive layout changes unnecessary. Textual websites really don't need more than a single column; readers should be able to scan a page top-to-bottom, left-to-right (or right-to-left, depending on the locale) exactly once to read all its content. Verify this using the horizontal-line test: mentally draw a horizontal line across your page, and make sure it doesn't intersect more than one (1) item. Keeping a single-column layout that doesn't require responsive layout changes ensures smooth window re-sizing.

Exceptions exist: one or two very simple responsive changes won't hurt. The main anti-patterns are adjusting the relative order of elements, and layout shifts dramatic enough to cause confusion.

<figure itemscope itemtype="https://schema.org/SoftwareSourceCode">
<figcaption>

<strong itemprop="codeSampleType">Code snippet</strong>: the only responsive layout change on [my website](https://seirdy.one/) is a single CSS declaration to switch between inline and multi-line navigation links at the top of the page:

</figcaption>

<pre><code itemprop="text">@media print, (min-width: 32rem) {
  header nav li {
    display: inline;
  }
}</code></pre>

</figure>

Nontrivial use of width-selectors, in CSS queries or imagesets, is actually a powerful vector for [JS-free fingerprinting](https://matt.traudt.xyz/posts/2016-09-04-how-css-alone-can-help-track-you/). This is one of the reasons why I didn't recommend resolution- or dimension-aware imagesets in the [image optimization section](#image-optimization).

Achieving this type of layout entails using the WCAG&nbsp;2.2 techniques <cite>[C27: Making the DOM order match the visual order](https://www.w3.org/WAI/WCAG22/Techniques/css/C27.html)</cite> as well as <cite>[C6: Positioning content based on structural markup](https://www.w3.org/WAI/WCAG22/Techniques/css/C6)</cite>.

### What about sidebars?

Sidebars are probably unnecessary, and can be quite annoying to readers who re-size windows frequently. This is especially true for tiling window manager users like me: we frequently shrink windows to a fraction of their original size. When this happens to a website with a sidebar, one of two things happens:

1. The site's responsive design kicks in: the sidebar vanishes and its elements move elsewhere. This can be quite CPU-heavy, as the browser has to both re-wrap the text _and_ handle a complex layout change. Frequent window re-sizers will experience lag and battery loss, and might need a moment to figure out where everything went.
2. The site doesn't use responsive design. The navbar and main content are now squeezed together. Readers will probably close the page.

Neither situation looks great.

### Sidebar alternatives

Common items in sidebars include tag clouds, an author bio, and an index of entries; these aren't useful while reading an article. Consider putting them in the article footer or--even better--dedicated pages. This does mean that readers will have to navigate to a different page to see that content, but they probably prefer things that way; almost nobody who clicked on "An opinionated list of best practices for textual websites" did so because they wanted to read my bio.

Don't boost engagement by giving readers information they didn't ask for; earn engagement with good content, and let readers navigate to your other pages _after_ they've decided they want to read more.

### Accessible skimming

Keeping an identical source order, DOM order, and visual order should also result in a logical <kbd>Tab</kbd> order. Just to be sure, always test the order of keyboard-driven focus.

Measuring tab-order is nice, but it doesn't go far enough. Users of [switch access](https://en.wikipedia.org/wiki/Switch_access) controls find it slow and frustrating to navigate long lists of focusable items. Screen readers make it difficult to consume poorly-organized content non-linearly. The list goes on: nearly every reader reliant upon assistive technologies struggles to skim through poorly-organized pages.

Related items need to be semantically grouped together. Group navigation links together in `<nav>` elements; sections under headings, `<section>` elements, or other landmarks; lists under `<ol>`, `<ul>`, or `<dl>`; etc. to give assistive technologies the means to skip over multiple items at once.

### Line length

The WCAG recommends a max line length of 80 characters (40 characters for <abbr title="Chinese, Japanese, and Korean">CJK</abbr> languages) as a AAA guideline in [Success Criterion 1.4.8 Visual Presentation](https://www.w3.org/TR/WCAG22/#visual-presentation). However, studies seem to have mixed results; some people find it easier to read lines around 90 characters long, while others struggle beyond the 50-character mark. I think the WCAG over-simplified a complex issue. Then again, the AAA level was never intended to be a requirement.

Some of my links display long link-text; short line lengths can break these link texts too much, which can slightly hurt readability. Of course, narrow viewports will obviously make short line lengths non-negotiable. I decided to give article bodies a width of `38em`, which typically corresponds to just under 90 characters. I opted to use `em` instead of `ch` for consistency and for better compatibility with some uncommon browsers (NetSurf, Dillo, and others).

I also ensured that my site supports CSS overrides, window-resizing, zoom levels past 200%, and most "reading mode" implementations. This should help accommodate a wide range of line-length preferences while still looking accessible enough by default.

When setting max line lengths, use a CSS media query to ensure that printed versions of a page use the full page width. This should save some paper.

<figure itemscope itemtype="https://schema.org/SoftwareSourceCode">
<figcaption>
<strong itemprop="codeSampleType">Code snippet</strong>: I opted to wrap all max-width rules in a media query to ensure that they only get called for the <code>screen</code> media type:
</figcaption>

<pre><code itemprop="text">@media screen {
  html {
    max-width: 45em;
    padding: 0 3%;
  }

  .e-content {
    margin: auto;
    max-width: 38em;
  }
}</code></pre>

</figure>

As words-per-line decrease (by increasing zoom or narrowing the viewport), line lengths grow more varied. Justifying text will cause uncomfortable amounts of whitespace. In fact, <q cite="https://www.w3.org/TR/WCAG22/#visual-presentation">Text is not justified</q> is explicitly mentioned in Success Criterion 1.4.8.

Small viewports
---------------

People read on a variety of viewport sizes. Page structure must be simple enough to handle these layouts smoothly.

### Narrow viewports

A single element wider than the viewport will trigger horizontal scrolling for the entire page. This is especially problematic for long pages that already require excessive vertical scrolling.

Not every phone has a giant screen: millions of people around the world use Web-enabled feature phones. The Jio Phone&nbsp;2, for instance, is narrow enough to fall through a belt loop: it sports a screen that's just over 3.6&nbsp;cm (1.44&nbsp;inches) wide. Furthermore, some programs sport browser windows in sidebars (c.f. Mozilla's [side view](https://addons.mozilla.org/en-US/firefox/addon/side-view/), Vivaldi [Web Panels](https://help.vivaldi.com/desktop/panels/web-panels/)). Users who leverage floating or tiling windows rather than maximizing everything could use viewports of arbitrary dimensions.

### Wide items

Long words, especially in headings, can trigger horizontal overflow. Test in a viewport that's under 240 pixels wide (<abbr title="Device Pixel Ratio">DPR</abbr>=1) and observe any words that trail off of the edge of the screen. Add soft hyphens to these words using the `&shy;` entity.

Most modern browsers support the `hyphens` CSS&nbsp;3 property, but full automatic hyphenation is usually an overkill solution with a naive implemen&shy;tation. Automatic hyphenation will insert hyphens wherever it can, not necessarily between the best syllables. At the time of writing, humans are still better at hyphenating than most software implemen&shy;tations. I'm also not aware of a CSS property that only breaks syllables when necessary to avoid horizontal scrolling.

Users employing machine translation will not benefit from your soft hyphens, so don't expect them to always work as intended. Translation tools might also replace short words with long ones. Soft hyphens and automatic hyphenation are both flawed solutions, but I find soft hyphens to be less problematic.

Where long inline `<code>` elements can trigger horizontal scrolling, consider a scrollable `<pre>` element instead. Making a single element horizontally scrollable is far better than making the entire page scrollable in two dimensions.

### Keeping text together

Soft hyphens are great for splitting up text, but some text should stay together. The phrase "10&nbsp;cm", for instance, would flow poorly if "10" and "cm" appeared on separate lines. Splitting text becomes especially painful on narrow viewports. A non-breaking space keeps the surrounding text from being re-flowed. Use the `&nbsp;` HTML entity instead of a space: `10&nbsp;cm`.

<span itemscope itemtype="https://schema.org/Book">{{<cited-work name="Practical Typography" url="https://practicaltypography.com/">}}</span>[^10] describes [where to use the non-breaking space](https://briefs.video/videos/is-progressive-enhancement-dead-yet/) in more detail

One exception to the rules from <cite>Practical Typography</cite>: don't use a non-breaking space if it would trigger two-dimensional scrolling on a narrow viewport. Between broken text and two-dimensional scrolling, broken text is the lesser evil. I personally set a cutoff at 2.5&nbsp;cm (1&nbsp;inch) at 125% zoom.

### Pictures of text

You should only use pictures of text when the visual presentation of the text is part of the information you're trying to convey. Always be sure to test how such an image looks on a narrow screen.

Images do not reflow their text. When the viewport is narrower than the image dimensions, two options arise:

1. Allow the image to exceed the viewport width, triggering two-dimensional scrolling for the whole page.
2. Shrink the image to fit the viewport, causing the text in the image to shrink with it.

I already covered the first option in the prior subsection. If you expect viewers to read the text in the image and you don't link an image transcript, the second option isn't ideal.

The best compromise is to ensure that the image isn't too wide, and can support large text on a narrow viewport. Lines of text in images should contain as few characters as possible. For a good example, see the "[In defense of link underlines](#in-defense-of-link-underlines)" section.

### Indented elements

Most browser default stylesheets were not optimized for narrow viewports, so narrow-viewport optimization is one of few good reasons to override the defaults. The best example of widescreen bias in browser stylesheets is indentation.

The HTML standard's section 4.4.4 [covers blockquotes](https://html.spec.whatwg.org/multipage/grouping-content.html#the-blockquote-element). It recommends placing a `<blockquote>` element inside a `<figure>` and citations in a `<figcaption>` to show a semantic relationship between a quotation and its citation.

Browser default stylesheets typically give `<figure>` elements extra margins on the left and right. `<blockquote>` elements have a large indent. Combining these two properties gives the final quotation an excessive visual indent, wasting precious vertical screen space. When quoted text contains list elements (`<ol>`, `<dl>`, `<ul>`), the indentation alone may fill most of a narrow viewport!

I chose to remove the margins in `<figure>` elements for quotations and code snippets. If you're reading this page with its own stylesheet enabled, in a CSS&nbsp;3 compliant browser, you might have noticed the blockquotes on it have a minimal indent and a thick gray border on the left rather than a full indent. These two adjustments allow blockquotes containing bulleted lists to fit on most narrow viewports, even when wrapped by a `<figure>` element. Browsers that do not support CSS&nbsp;3 properties such as `padding-inline-start` will render quoted text using default stylesheets (probably with an indent), which are perfectly usable if a bit inconvenient.

Another example: outside the Web, I prefer indenting code with tabs instead of spaces. Tab widths are user-configurable, while spaces aren't. HTML pre-formatted code blocks, however, are best indented with two spaces. Default browser stylesheets typically represent tabs with an excessive indent, which can be annoying on narrow viewports.

### Short viewports

Small phones typically support display rotation. When phones switch to landscape-mode, vertical space becomes precious. Fixed elements (e.g. dickbars) become a major usability hazard. Ironically, the WCAG's own interactive Techniques reference is a perfect example of how fixed elements impact usability on short screens.

<figure>
{{< picture name="wcag_quickref" alt="Website with banner covering top half of screen." sf=1.2 >}}
<figcaption>

When filtering criteria on [the Quickref Reference page](https://www.w3.org/WAI/WCAG22/quickref/?currentsidebar=%23col_customize&showtechniques=134%2C124&levels=a&technologies=js%2Cserver%2Csmil%2Cpdf%2Cflash%2Csl), a dickbar lists active filters. I increased the zoom level; you may have to add more filters to fill the screen with a smaller font.

</figcaption>
</figure>

Designers often use figures to "break up" their content, and provide negative space. This is good advice, but I don't think people pay enough attention to the flipside: splitting up content with too many figures can make reading extremely painful on a short viewport. Design maxims usually lack nuance.

Spacing
-------

The previous [small viewports](#small-viewports) section may tempt you to make your content as dense as possible. Please don't overdo it.

There's an ideal range somewhere between "cramped" and "spaced-apart" content. Finding this range is difficult. The best way to resolve such difficult and subjective issues is to ask your readers for feedback, giving disproportionate weight to readers with under-represented needs (especially disabled readers).

### Non-interactive space

Excessive indentation can [make reading difficult](#indented-elements) for narrow viewports, but preserving some indentation is still useful.

For now, I've decided to keep the indents on list elements (`<ol>`, `<dl>`, `<ul>`) since I often fill them with links (see this article's [table of contents](#TableOfContents) for an example). This indentation provides important non-interactive negative space. Readers with hand tremors [depend on this space](https://axesslab.com/hand-tremors/) to scroll without accidentally selecting an interactive element. Readers who double-tap to jump or zoom can't do so if there's no screen region that's "safe to tap".

<figure>
{{<picture name="touch_targets" alt="Phone screen with three \"touch target\" rectangles on top of each other, separated by blank sections labeled \"space\"">}}
<figcaption>
Image credit: <a href="https://axesslab.com/hand-tremors/">Axess Lab</a>
</figcaption>
</figure>

Having clearly distinguished links also helps users decide safe places to tap the screen. See the [section on link underlines](#in-defense-of-link-underlines) for more information.

### Tap targets

Tap targets should be at least 44 pixels tall and wide [according to the WCAG](https://www.w3.org/TR/WCAG22/#target-size-enhanced); this is large enough to easily tap on a touch&shy;screen. The WCAG makes an exception for inline targets, like links in a paragraph.

Google has far more aggressive recommendations: it recommends raising the limit 48 pixels regardless of whether tap targets are inline, going so far as to make tap target size a ranking factor in search.

On lists without visible bullets, I dropped the default indentation. I had to find other ways to ensure adequate tap-target size _and_ provide sufficient space for readers with hand-tremors to scroll. Some examples:

- The [webmention list](#webmentions) below this article separates links with timestamps and some paragraph spacing.
- The [homepage posts list](https://seirdy.one/#posts) and the list of related articles at the top of [one of my posts](https://seirdy.one/2022/02/02/floss-security.html) separates links with descriptions

### Line spacing

Increasing the line-spacing a bit will make tap targets larger and improve comprehension by readers with cognitive disabilities. A WCAG AAA Success Criterion is to allow 1.5 space units between lines.

<figure itemscope itemtype="https://schema.org/Quotation">
	<blockquote itemprop="text">
		<p>Line spacing (leading) is at least space-and-a-half within paragraphs, and paragraph spacing is at least 1.5 times larger than the line spacing.</p>
	</blockquote>
	<figcaption>
		&mdash; <span class="h-cite" itemprop="citation" role="doc-credit">
			<span itemprop="isPartOf" itemscope itemtype="https://schema.org/TechArticle">
				<cite><a class="u-url p-name" itemprop="url" href="https://www.w3.org/TR/WCAG22/"><span itemprop="name headline">WCAG&nbsp;2.2</span></a></cite>, <a href="https://w3c.github.io/wcag/guidelines/22/#visual-presentation">Success Criterion 1.4.8 Visual Presentation</a>
			</span>
		</span>
	</figcaption>
</figure>

The <abbr title="Web Accessibility Initiative">WAI</abbr>'s Cognitive and Learning Disabilities Accessibility Task Force [recommends changing this Success Criterion's level](https://w3c.github.io/coga/extension/#changedlevels), finding it too important to be relegated to AAA status.

Non-browsers: reading mode
--------------------------

Fully standards-compliant browsers aren't the only programs people use. They also use "reading mode" tools and services.

Reading modes leverage article extractors such as <span translate="no">[Readability](https://github.com/mozilla/readability)</span> (integrated into Firefox, Epiphany, Brave, Vivaldi, and others), [DOM Distiller](https://chromium.googlesource.com/chromium/dom-distiller/) (integrated into Chromium), and [Trafilatura](https://trafilatura.readthedocs.io/en/latest/) (powers a variety of tools and services). A host of other proprietary options exist: Diffbot powers services like Instapaper, Mozilla's Pocket has its own secret parsers, and countless "send to e-reader" services have amassed loyal users. Safari's proprietary fork of <span translate="no">Readability</span> has grown quite complex compared to upstream; Edge's Immersive Reader is [a mystery to me](https://techcommunity.microsoft.com/t5/discussions/documentation-on-huerestics-used-during-article-distillation-in/m-p/3266436), with [a problematic stylesheet](https://feedbackportal.microsoft.com/feedback/idea/e0d9b299-e3b6-ec11-a81c-000d3a7ce453).

I don't recommend catering to each tool's non-standard quirks. Studying their design reveals that they observe open standards, to varying degrees. <span translate="no">Readability</span>, DOM Distiller, and Trafilatura understand plain-old, semantic HTML (<abbr title="Plain-Old, Semantic HTML">POSH</abbr>).

POSH should be enough for most use-cases, but some authors want to go further. For example, they may want a byline or published date to show up in these modes.

Most extractors fetch these values using open standards for structured data. The most well-supported option is [microformats](https://microformats.org/wiki/microformats) (<span translate="no">Readability</span> is one of the few that supports the newer microformats2). Some support [schema.org](https://schema.org/) vocabularies in microdata or JSON-LD syntaxes, or [Dublin Core](https://www.dublincore.org/) vocabularies in RDFa. Most parse `<meta>` tags from the document `<head>`, but others don't due to misuse and overly aggressive <abbr title="Search Engine Optimization">SEO</abbr>.

Sorry, that was a lot of jargon for a single paragraph. Unfortunately, describing those terms is out of scope for this post. If you'd like to dive down this rabbit hole, read about the "Semantic Web".

Some reading-mode implementations also support [DPUB-ARIA](https://www.w3.org/TR/dpub-aria-1.1/), but I'd caution against using ARIA when POSH is sufficient: "bad ARIA" can be far more harmful to screen readers than "no ARIA". Only use ARIA to fill in gaps left by POSH.

Again: avoid catering to non-standard implemen&shy;tations' quirks, especially undocumented proprietary ones. Let's not repeat the history of the [browser wars](https://en.wikipedia.org/wiki/Browser_wars). Remember that some implementations have bugs; consider reporting issues when one arises. More information about standard and non-standard behavior of reading modes is in the article <cite>[Web Reading Mode: The non-standard rendering mode](https://www.ctrl.blog/entry/browser-reading-mode-parsers.html)</cite> by {{<indieweb-person first-name="Daniel" last-name="Aleksandersen" url="https://www.daniel.priv.no/">}}.

Reading modes aren't the only non-browser user agents out there. Plain-text feed readers and link previewers are some other options. I singled out reading modes because of their widespread adoption and value. Decide which other kinds of agents are important to you (if any), and see if they expose a hole in your semantics.

Machine trans&shy;lation {#machine-translation}
------------------------

Believe it or not, the entire world doesn't speak your website's languages. Browsers like Chromium, Microsoft Edge, and Safari have integrated machine translation to translate entire pages. Users can also leverage online website translators such as Google Translate or Bing. These "webpage translators" are far more complex than their plain-text predecessors.

Almost every word on your site can be re-written. Prepare for headings to change length, paragraphs to grow and shrink, or hyphenation to disappear. Your site's layout should make sense even when the length of each textual element is changed.

Machines can't reliably translate images of text, since OCR is error-prone. See the [image transcripts section](#image-transcripts) for remedies.

Incorrect spelling and poor grammar in an original work can reduce the accuracy of a machine-translated derivative. Be sure to proofread.

### POSH helps translation engines

To ensure that pages get machine-translated properly, make proper use of semantic HTML. Daniel wrote about this topic too in <cite>[Semantic markup improves the quality of machine-translated texts](https://www.ctrl.blog/entry/html-semantic-improve-machine-translation.html)</cite>; I highly encourage giving his article a read.

Elements to pay close attention to include `<code>`, `<samp>`, `<var>`, `<kbd>`, `<abbr>`, and `<address>`. The semantic information conveyed by these elements supplies important context to translation algorithms.

Only after <abbr title="Plain-Old, Semantic HTML">POSH</abbr> is insufficient should you attempt to "override" behavior with the `translate` HTML attribute. Setting `translate="no"` or `translate="yes"` should override the behavior of standards-compliant translation engines. If you're unsure whether or not to use a `translate` attribute, search the relevant word or phrase on [Keybot](https://www.keybot.com/) to see how human translators approached it.

For example: machine translation will leave `<code>` and `<samp>` blocks as-is. Perhaps you could annotate comments within code with a `translate="yes"` attribute. However, translation engines should leave variables within those comments as-is.

[Google's style guide](https://developers.google.com/style/placeholders) recommends annotating format placeholders in code blocks with the `<var>` element; consider doing so and adding a `translate="yes"` attribute to placeholder values, at your discretion. For an example, check this article's code sample [describing my PNG optimization pipeline](#png-pipeline).

### Changing text direction

Consider the implications of translating between left-to-right (LTR) and right-to-left (RTL) languages. Do a search through your stylesheets for keywords like "left" and "right" to ensure that styles don't depend too heavily on text direction. Once you've cleared the low-hanging fruit, try translating the page to a language like Arabic.

Websites following this page's layout advice shouldn't need much adjustment. {{<indieweb-person first-name="Ahmed" last-name="Shadeed" url="https://ishadeed.com/" appendString="’s">}} <cite>[RTL Styling 101](https://rtlstyling.com/posts/rtl-styling/)</cite> is a comprehensive guide to what can go wrong and how to fix issues.

Inaccessible default stylesheets
--------------------------------

Simple sites should err on the side of respecting default stylesheets. With rare exceptions, there are only two times I feel comfortable overriding default stylesheets:

1. Gently adjusting a parameter rather than completely changing an element's appearance. Typically, this involves adjusting dimensions.
2. Fundamentally altering an element's appearance. I only feel comfortable doing this when the defaults are truly inaccessible, or clash with another accessibility enhancement I made.

My previous advice regarding line spacing and maximum line length fell in the first category. My approach to re-styling `<blockquote>` elements, adding borders, and using `sans-serif` fell in the latter category.

This section contains miscellaneous advice regarding the latter category of stylesheet overrides.

### Monospace handling

By default, most browsers render monospace text at a reduced size. If you want your monospace text to be readable, set its font family to `monospace monospace` (sic).

Font family alone is not enough to distinguish an element from its surroundings. For `<pre>`, `<code>`, and `<samp>` elements, I recommend supplementing the font family change with a soft border. As described in [the "Color overrides and accessibility" section](#color-overrides-and-accessibility), borders are preferable to background colors because they don't override the user-agent's preferred foreground and background colors.

Finally, it's important to distinguish `<kbd>` from `<code>`, `<samp>`, and regular body text.

<figure itemscope itemtype="https://schema.org/SoftwareSourceCode">
<figcaption>

<strong itemprop="codeSampleType">Code snippet</strong>: How I distinguish `<code>` and `<samp>`, `<pre>`, and `<kbd>` from each other and from body text.

</figcaption>

<pre><code itemprop="text">code,
kbd,
samp {
  font-family: monospace, monospace;
}

pre,
:not(pre) > code {
  border: 1px solid;
}

/* A black border is too harsh. */
:not(pre) > code {
  border-color: #aaa;
}

kbd {
  font-weight: bold;
}</code></pre>

</figure>
<!--*-->

### Focus indicators

The default focus indicators are hard to see in certain browsers, especially when the focused element already has a border.

(TODO: add a screenshot).

On one hand, users who need enhanced focus visibility may override the default focus indicators in their browser preferences; I'd like to support such overrides. On the other hand, relying on these customizations would violate the "accessible by default" directive. This would exclude Tor Browser and fingerprinting-averse readers, as well as anybody who has to borrow a machine or browser they don't own or haven't customized yet. This is another one of the few areas where I'd recommend overriding browser default stylesheets.

The WCAG guidelines recommend making focus indicators 2&nbsp;px thick in [Success Criterion 2.4.12](https://w3c.github.io/wcag/guidelines/22/#focus-appearance-enhanced). While this success criterion is only AAA-level, it's easy enough to meet and beneficial enough to others that we should all meet it.

You can use `:focus` and `:focus-visible` to highlight selected and keyboard-focused elements, respectively. Take care to only alter styling, not behavior: only keyboard-focusable elements should receive outlines. Modern browser stylesheets use `:focus-visible` instead of `:focus`; old browsers only support `:focus` and re-style a subset of focusable elements. Your stylesheets should do the same, to match browser behavior.

<figure itemscope itemtype="https://schema.org/SoftwareSourceCode">
<figcaption>

<strong itemprop="codeSampleType">Code snippet</strong>: I do not re-style `:focus` when `:focus-visible` works, to match existing behavior. I also override `:focus` styling only on the subset of focusable elements that would normally show an outline. Based on the post <span itemprop="isBasedOn" itemscope itemtype="https://schema.org/BlogPosting">{{<cited-work name="Refining focus styles with focus-visible" url="https://www.tempertemper.net/blog/refining-focus-styles-with-focus-visible" extraName="headline">}} by {{<indieweb-person nickname="tempertemper" url="https://www.tempertemper.net/" itemprop="author">}}</span>, but modified to work on old browser engines such as KHTML and WebKit&nbsp;537.21.

</figcaption>

<pre>
<code itemprop="text">a:focus,
[tabindex]:focus {
  outline: 3px solid;
}

/* Undo the above if :focus-visible works */
@supports selector(:focus-visible) {
  a:focus:not(:focus-visible),
  [tabindex]:focus:not(:focus-visible) {
    outline: none;
  }
}

:focus-visible {
  outline: 3px solid;
}</code>
</pre>

</figure>
<!--*-->

Screen reader improve&shy;ments {#screen-reader-improvements}
-------------------------------

This section focuses on ways to improve screen reader support that have not already been covered. The most important measures (semantic HTML, good alt-text and image context, correct spelling, etc.) have already been covered in previous sections.

### Split elements and possessive hyperlinks

Some screen readers split up sections by HTML elements. This means HTML elements in the middle of a sentence will trigger pauses. The problem comes up frequently on sites that use excessive inline formatting.

This is especially concerning on my website, where I tend to hyperlink peoples' names (a common practice on the IndieWeb): making names possessive with an "apostrophe + s" creates pronunciation issues. "Seirdy's Home" could be read as "Seirdy. Link. S. Home" if the word "Seirdy" is a hyperlink.

A workaround is to use the "text" ARIA role to remove the semantics of elements.

<figure itemscope itemtype="https://schema.org/Quotation">
<blockquote itemprop="text">

To force a screen reader to interpret the heading as one object, I wrapped the text inside the heading in a span and added `role="text"`.

```
<h1>
  <span role="text">Digital accessibility, <br>
    for everyone. 
  </span>
</h1>
```

</blockquote>
<figcaption>
	&mdash; <span class="h-cite" itemprop="citation" role="doc-credit">
			<span itemprop="isPartOf" itemscope itemtype="https://schema.org/BlogPosting">
				{{<indieweb-person first-name="Hampus" last-name="Sethfords" url="https://axesslab.com/author/hampelusken/" itemprop="author">}},
				{{<cited-work name="Text Splitting Causes Screen Reader Problems" url="https://axesslab.com/text-splitting/" extraName="headline">}}
			</span>
	</span>
</figcaption>
</figure>

If you're unfamiliar with ARIA, always remember the first rule of ARIA: [No ARIA is better than Bad ARIA](https://www.w3.org/TR/wai-aria-practices-1.1/#no_aria_better_bad_aria). ARIA exposes a host of accessibility hazards when used improperly, so only use this approach when there's no good alternative. This workaround doesn't work in certain screen readers, including Orca, so don't count on it.

The best solution for possessive nouns is to include the "apostrophe + s" inside the hyperlink.

### Other tips

Designers already test their websites with multiple browser engines to ensure cross-browser compatibility. Screen readers deserve the same treatment. Orca, NVDA, VoiceOver, TalkBack, and ChromeVox all have unique behavior and varying levels of support for HTML and ARIA.

Screen readers on touch screen devices are also quite different from their desktop counterparts, and typically feature fewer capabilities. Be sure to test on both desktop and mobile.

Screen reader implementations often skip punctuation marks like the exclamation point ("!"). Ensure that meaning doesn't rely too heavily on such punctuation.

I'll be adding more tips here shortly; watch this space.

Testing
-------

If your site is simple enough, it should automatically handle the vast majority of edge-cases. Different devices and browsers all have their quirks, but they generally have one thing in common: they understand <abbr title="Plain-Old, Semantic HTML">POSH</abbr>.

In addition to standard testing, I recommend testing with unorthodox setups that are unlikely to be found in the wild. If a website doesn't work well in one of these tests, there's a good chance that it uses an advanced Web feature that can serve as a point of failure in other cases. Simple sites should be able to look good in a variety of situations out of the box.

Your page should easily pass the harshest of tests without any extra effort if its HTML meets basic standards for well-written code (overlooking bad formatting and a lack of comments). Even if you use a complex static site generator, the final HTML should be simple, readable, and semantic.

### Sample un&shy;orthodox tests {#sample-unorthodox-tests}

These tests begin reasonably, but gradually grow absurd. Once again, use your judgement.

1. Evaluate the heaviness and complexity of your scripts (if any) by testing with your browser's <abbr title="just-in-time">JIT</abbr> compilation disabled.[^12]
2. Test using the Tor Browser's safest security level enabled (disables JS and other features).
3. Load just the HTML. No CSS, no images, etc. Try loading without inline CSS as well for good measure.
4. Print out the site in black-and-white, preferably with a simple laser printer.
5. Test with assistive technologies such as screen readers, magnifiers, and switch controls.
6. Ensure the page responds correctly to browser zoom. No sizes or dimensions should remain "fixed" across zoom levels.
7. Test keyboard navigability with the <kbd>Tab</kbd> key and [caret navigation](https://en.wikipedia.org/wiki/Caret_navigation). Even without specifying tab indexes, tab selection should follow a logical order if you keep the layout simple.
8. Test in textual browsers: lynx, links, w3m, ELinks, edbrowse, EWW, Netrik, etc.
9. Test in an online website translator tool.
10. Read the (prettified and indented) HTML source itself and parse it with your brain. See if anything seems illogical or unnecessary. Imagine giving someone a printout of your page's `<body>` along with a whiteboard. If they have a basic knowledge of HTML tags, would they be able to draw something resembling your website?
11. Test with unorthodox graphical browser engines, like NetSurf, Servo, or the Serenity OS browser.
12. Try printing out your page in black-and-white from an unorthodox graphical browser.
13. Download your webpage and test how multiple word processors render and generate PDFs from it.[^13]
14. Combine conversion tools. Combine an HTML-to-EPUB converter and an EPUB-to-PDF converter, or stack multiple article-extraction utilities on top of each other. Be creative and enjoy breaking your site. When something breaks, examine the breakage and see if it's caused by an issue in your markup, or a CSS feature with an equivalent alternative.
15. Build a time machine. Travel decades--or perhaps centuries--into the future. Keep going forward until the WWW is breathing its last breath. Test your site on future browsers. Figuring out how to transfer your files onto their computers might take some time, but you have a time machine so that shouldn't be too hard. When you finish, go back in time to [meet Benjamin Franklin](https://xkcd.com/567/).

I'm still on step 14, trying to find new ways to break this page. If you come up with a new test, please [share it](mailto:~seirdy/seirdy.one-comments@lists.sr.ht).

Future updates
--------------

This article is, and will probably always be, an ongoing work-in-progress. Some areas I have yet to cover:

* How purely-cosmetic animations harm readers with learning and cognitive disabilities (e.g. attention disorders).
* How exposing new content on hover is inaccessible to users with magnifiers, hand tremors, switch access, and touch&shy;screens.
* Notes on improving support for braille displays.
* How to work well with caret-based navigation.
* How to choose phrasings such that some meaning can be inferred without understanding numbers, for [dyscalculic readers](https://en.wikipedia.org/wiki/Dyscalculia). This is more applicable to posts whose main focus is not mathematical or quantitative.
* How to include equations in a way that maximizes compatibility and accessibility.
* Keypad-based navigation on feature phones (c.f. KaiOS devices).
* How keyboard navigation can be altered by assistive tools such as screen readers.
* How to avoid relying too much on formatting, for user agents that display unformatted text (e.g. textual feed readers like Newsboat)
* Elaboration on how authors should delegate much of their formatting to the user agent, and how CSS resets are a symptom of a failure to do so.
* Keyboard-driven browsers and extensions. Qutebrowser, Luakit, visurf, Tridactyl, etc.
* Ways to support non-mainstream and older browsers by supporting subsets of specifications and using progressive enhancement.
* Avoiding `_blank` targets in URLs unless absolutely necessary.
* Ways to improve comprehension by readers who struggle to understand non-literal language (certain manifestations of cognitive disabilities, non-native speakers unfamiliar with idioms, etc.). I might wait until the <abbr title="Web Accessibility Initiative">WAI</abbr> <cite>[Personalization Help and Support 1.0](https://w3c.github.io/personalization-semantics/help/index.html)</cite> draft specification matures and its vocabularies gain adoption before going in depth.
* Other accessible writing tips, maybe after I get a copy of <span itemscope itemtype="https://schema.org/Book">{{<cited-work name="Writing Is Designing" url="https://rosenfeldmedia.com/books/writing-is-designing/">}} by {{<indieweb-person first-name="Michael" last-name="Metts" url="https://mjmetts.com/" itemprop="author">}} and {{<indieweb-person first-name="Andy" last-name="Welfe" url="https://www.andy.wtf/" itemprop="author">}}</span>. A relevant excerpt on writing accessibly is [on A List Apart](https://alistapart.com/article/standards-for-writing-accessibly/).
* Rules for descriptive link text, for screen reader navigation and for user-agents that display links as footnotes (e.g. some textual browsers with the `dump` flag).

Conclusion
----------

There are so many ways to read a page; authors typically cater only to the mainstream ones. Some ways to read a page I covered include:

* Screen readers
* Switch access
* Keyboard navigation, with the <kbd>Tab</kbd> key or caret navigation
* Navigating with hand-tremors
* Content extraction (e.g. "Reader Mode")
* Low-bandwidth connections
* Unreliable, lossy connections
* Metered connections
* Hostile networks
* Using in-page search
* Downloading offline copies
* Very narrow viewports (much narrower than a phablet)
* Mobile devices in landscape mode
* Frequent window-resizers (e.g. users of tiled-window setups)
* Printouts, especially when paper and ink are rationed (common in schools)
* Textual browsers
* Uncommon graphical browsers
* the Tor Browser (separate from "uncommon browsers" because of how "safest" mode is often incompatible with progressive enhancement and graceful degradation)
* Disabling JavaScript (overlaps with the Tor Browser)
* Non-default color palettes
* Aggressive content blocking (e.g. blocking all third-party content, frames, images, and cookies)
* User-selected custom fonts
* Stylesheet removal, alteration, or replacement
* Machine translators

Each of these may be dismissed as a "niche", especially given a profit motive (or worse, a growth imperative). Yet _many niches add up to a large population._ Every person who grows old becomes disabled; every long-distance traveller experiences poor connections.

Moreover, I don't think that the size of a disadvantaged population should always matter. I understand weighing population size if you have to make a trade-off between two conflicting special needs, but I don't think the aesthetic preferences of the majority are more important than supporting a disadvantaged minority.

Before you throw up your hands and decide you can't help everyone, take another skim through this page. Notice how much repetition exists between sections. _Nearly every bullet-point I listed benefits tremendously from plain-old, semantic HTML (<abbr title="Plain-Old, Semantic HTML">POSH</abbr>)_. If your page is usable with nothing but POSH, you've done half the work already.

<section role="doc-acknowledgments">

Ack&shy;nowledge&shy;ments and further reading {#further-reading}
----------------------------------------------

Initial versions of this page were inspired by existing advocates for web minimalism.

Parts of this page can be thought of as an extension to the principles of Brutalist Web Design:

<figure itemscope itemtype="https://schema.org/Quotation">
	<blockquote itemprop="text">
		<p>Raw content true to its construction:</p>
		<ol>
		<li>Content is readable on all reasonable screens and devices.</li>
		<li>Only hyperlinks and buttons respond to clicks.</li>
		<li>Hyperlinks are underlined and buttons look like buttons.</li>
		<li>The back button works as expected.</li>
		<li>View content by scrolling.</li>
		<li>Decoration when needed and no unrelated content.</li>
		<li>Perform&shy;ance is a feature.</li>
		</ol>
	</blockquote>
	<figcaption>
		&mdash; <span class="h-cite" itemprop="citation" role="doc-credit">
			<span itemprop="isPartOf" itemscope itemtype="https://schema.org/WebSite">
				{{<indieweb-person first-name="David" last-name="Copeland" url="https://naildrivin5.com/" itemprop="author">}},
				{{<cited-work name="Brutalist Web Design" url="https://brutalist-web.design/">}}
			</span>
		</span>
	</figcaption>
</figure>

The [250kb club](https://250kb.club/) gathers websites at or under 250kb, and also rewards websites that have a high ratio of content size to total size.

The [10KB Club](https://10kbclub.com/) does the same with a 10kb homepage budget (excluding favicons and webmanifest icons). It also has guidelines for note&shy;worthiness, to avoid low-hanging fruit like mostly-blank pages.

My favorite website club has to be the [<abbr title="eXtreme HyperText Movement for Luddites">XHTML</abbr> Club](https://xhtml.club/) by {{<indieweb-person first-name="Bradley" last-name="Taunt" url="https://tdarb.org">}}, the creator of the original [1mb.club](https://1mb.club).

Also see [Motherfucking Website](https://motherfuckingwebsite.com/). Motherfucking Website inspired several unofficial sequels that tried to gently improve upon it. My favorite is [Best Motherfucking Website](https://bestmotherfucking.website/).

The [Web Bloat Score calculator](https://www.webbloatscore.com/) is a JavaScript app that compares a page's size with the size of a PNG screenshot of the full page content, encouraging site owners to minimize the ratio of the two.

One resource I found useful (that eventually featured this article!) was the "Your page content" section of {{<indieweb-person first-name="Bill" last-name="Dietrich" url="https://www.billdietrich.me" appendString="’s">}} comprehensive guide to [setting up your personal website](https://www.billdietrich.me/YourPersonalWebSite.html#PageContent).

If you've got some time on your hands, I _highly_ recommend reading the <cite>[Web Content Accessibility Guidelines (WCAG)&nbsp;2.2](https://www.w3.org/TR/WCAG22/)</cite>. The WCAG 2 standard is technology-neutral, so it doesn't contain Web-specific advice. For that, check the <cite>[How to Meet WCAG (Quick Reference)](https://www.w3.org/WAI/WCAG22/quickref)</cite>. It combines the WCAG with its supplementary [list of techniques](https://www.w3.org/WAI/WCAG22/Techniques/).

The WCAG are an excellent starting point for learning about accessibility, but make for a poor stopping point. Much of the content on this page simply isn't covered by the WCAG. One of my favorite resources for learning about what the WCAG _doesn't_ cover is [Axess Lab](https://axesslab.com/articles/).

I've learned about a great number of underrepresented ways to browse from the Fediverse, particularly from [this subthread asking people to share](https://pleroma.envs.net/notice/AHqp3TEDFoyz0W4nbc) (requires JavaScript; [plaintext mirror](https://gopher.envs.net/pleroma.envs.net:7070/1/notices/AHqp3TEDFoyz0W4nbc)). Several responses informed updates to this page.

An early version of this article received useful responses when I [posted it to Lobsters](https://lobste.rs/s/akcw1m/opinionated_list_best_practices_for); I incorporated some feedback shortly afterward.

A special thanks goes out to GothAlice for the questions she answered in `#webdev` on Libera.Chat.

</section>


[^1]: Many addons function by injecting content into pages; this significantly weakens many aspects of the browser security model (e.g. site and origin isolation) and should be avoided if at all possible. For content such as public key fingerprints, I recommend setting a blank `sandbox` directive even if it means breaking these addons.

[^2]: Some addons will have reduced functionality; for instance, [Tridactyl](https://github.com/tridactyl/tridactyl) can't create an `<iframe>` for its command window. I consider this to be worthwhile since the most important functionality is still available, and because authors shouldn't feel compelled to support security weakening. I say this as someone who uses Tridactyl often.

[^3]: Here's an [overview of PE](https://en.wikipedia.org/wiki/Progressive_enhancement) and [my favorite write-up on the subject](https://whalecoiner.com/articles/progressive-enhancement).

[^4]: <cite>High-Performance Browser Networking</cite> by {{<indieweb-person first-name="Ilya" last-name="Grigorik" url="https://www.igvita.com/">}} gives [a great introduction to how TCP works](https://hpbn.co/building-blocks-of-tcp/), if you'd like more details.

[^5]: HPACK and QPACK header compression includes dictionaries containing common headers. If a header matches one of these common values, its effective size can be reduced to a single byte. If a header has an uncommon value, consider minifying it by removing unnecessary whitespace. Remember that if your golden first kilobyte already lists all essential resources, these could be considered premature optimizations. Real bottlenecks lie elsewhere.

[^6]: Ironically, that page doesn't load the main text without JavaScript despite citing a JavaScript requirement as a downside. If you can't load the page, the same reasons are [outlined here](https://addyosmani.com/blog/infinite-scroll-without-layout-shifts/) in the "Accessibility concerns for infinite scroll" section.

[^7]: Firefox users [can enable "find as you type"](https://website-archive.mozilla.org/www.mozilla.org/access/access/type-ahead/) by toggling a preference in `about:config`. Chromium (and derivatives) users can [install an extension](https://github.com/Foxy/chrome-type-ahead); note that it requires full-page access and performs script injection to work.

[^8]: Iterating through a list of font names to see if each one is available on a user's system is a slow but effective way to determine installed fonts without being granted permission to use the Font Access API. [BrowserLeaks has a demo](https://browserleaks.com/fonts) of this approach. Warning: the page might hog your CPU for a while.

[^9]: Decoration is more than cosmetic. The [color overrides and accessibility](#color-overrides-and-accessibility) sub-section describes how some decorations, like borders, improve accessibility.

[^10]: <span itemscope itemtype="https://schema.org/Book">{{<cited-work name="Practical Typography" url="https://practicaltypography.com/">}}</span> only renders invisible text without JavaScript. You can use a textual browser, screen reader, copy-paste the page contents elsewhere, use a reader-mode implemen&shy;tation, or "view source" to read it without enabling scripts. All of these options will ironically override the carefully-crafted typography of this website about typography.

    I find <cite>Practical Typography</cite> quite useful for printed works, and incorporated a more moderate version of its advice on soft-hyphens into this page. With a few such exceptions, I generally find it to be poor advice for Web content.

[^11]: libavif links against libaom, librav1e, and/or libsvtav1 to perform AVIF encoding and decoding. libaom is best for this use-case, particularly since libaom can link against libjxl to use its Butteraugli distortion metric. This lets libaom optimize the perceptual quality of lossy encodes much more accurately.

[^12]: <p>Consider disabling the JIT for your normal browsing too; doing so removes whole classes of vulnera&shy;bilities. In Firefox, navigate to <code>about:config</code> and toggle some flags under <code>javascript<wbr>.options</code>.</p><figure itemscope itemtype="https://schema.org/SoftwareSourceCode"><figcaption><strong itemprop="codeSampleType">Code snippet</strong>: Firefox prefs to turn off JIT compilation</figcaption><pre><code itemprop="text">javascript.options.ion<br>javascript.options.baselinejit<br>javascript.options.native_regexp<br>javascript.options.asmjs<br>javascript.options.wasm</code></pre></figure><p>

    In Chromium and derivatives, run the browser with `--js-flags='--jitless'`; in the Tor Browser, set the security level to "Safer".

[^13]: LibreOffice can also render HTML but has extremely limited support for CSS. OnlyOffice seems to work best, but doesn't load images. If your page is CSS-optional, it should look fine in both.

    Fun fact: Microsoft Outlook renders HTML email with Microsoft Word's proprietary HTML engine.



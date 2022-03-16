---
date: "2020-11-23T12:21:35-08:00"
description: A lengthy guide to making simple and accessible sites that focus on content rather than form. Emphasizes brutalist web design, adaptability, and minimalism.
outputs:
    - html
    - gemtext
footnote_heading: Notes
tags:
    - web
    - minimalism
title: An opinionated list of best practices for textual websites
---
_The following applies to minimal websites that focus primarily on text. It does not apply to websites that have a lot of non-textual content. It also does not apply to websites that focus more on generating revenue or pleasing investors than being good websites._

This is a "living document" that I add to as I receive feedback. See the [changelog](https://git.sr.ht/~seirdy/seirdy.one/log/master/item/content/posts/website-best-practices.md).

I realize not everybody's going to ditch the Web and switch to Gemini or Gopher today (that'll take, like, a month at the longest). Until that happens, here's a non-exhaustive, highly-opinionated list of best practices for websites that focus primarily on text:

- Final page weight under 50kb without images, and under 200kb with images. Page weight should usually be much smaller; these are upper-bounds for exceptional cases.
- Works in Lynx, w3m, links (both graphics and text mode), NetSurf, and Dillo
- Works with popular article-extractors (e.g. Readability) and HTML-to-Markdown converters. This is a good way to verify that your site uses simple HTML and works with most non-browser article readers (e.g. ebook converters, PDF exports).
- No scripts or interactivity, preferably enforced at the Content-Security-Policy (<abbr title="Content Security Policy">CSP</abbr>) level
- No cookies
- No animations
- No fonts--local or remote--besides `sans-serif` and `monospace`.
- No requests after the page finishes loading
- No 3rd-party resources (preferably enforced at the CSP level)
- No lazy loading
- No custom colors OR explicitly set the both foreground and background colors.
- A maximum line length for readability
- Server configured to support compression (gzip, optionally Brotli and Zstandard as well). It's a free speed boost.
- Supports dark mode via a CSS media feature and/or works with most "dark mode" browser addons. More on this below.
- A good score on Mozilla's [HTTP Observatory](https://observatory.mozilla.org/). A bare minimum would be 50, but it shouldn't be too hard to hit 100.
- Optimized images.
- All images labeled with alt-text. The page should make sense without images.
- Probably HTTP/2. Maybe even HTTP/3. Run some tests to see if this is worth it if you're so inclined.
- Works well with Tor and the Tor Browser's safety settings.
- Preserve link underlines.
- Handle a wide variety of viewport sizes without dramatic layout changes

I'd like to re-iterate yet another time that this only applies to websites that primarily focus on text. If graphics, interactivity, etc. are an important part of your website, less (possibly none) of this article applies. My hope is for most readers to consider _some_ points I make on this page the next time they build a website. I don't expect--or want--anybody to follow 100% of my advice.

Earlier revisions of this post generated some responses I thought I should address below. Special thanks to the IRC and [Lobsters](https://lobste.rs/s/akcw1m) users who gave good feedback!

I'll also cite the document <cite>[Techniques for WCAG 2.2](https://www.w3.org/WAI/WCAG22/Techniques/)</cite> a number of times. Unlike the Web Content Accessibility Guidelines (<abbr title="Web Content Accessibility Guidelines">WCAG</abbr>), the Techniques document does not list requirements; rather, it serves to educate authors about *how* to use specific technologies to comply with the WCAG. I don't find much utility in the technology-agnostic goals enumerated by the WCAG without the accompanying technology-specific techniques to meet those goals.

Security
--------

One of the defining differences between textual websites and advanced Web 2.0 sites/apps is safety. Most browser vulnerabilities are related to modern Web features like JavaScript and WebGL. The simplicity of basic textual websites _should_ guarantee some extra safety; however, webmasters need to take some additional measures to ensure limited use of "modern" risky features.

### TLS

All of the simplicity in the world won't protect a page from unsafe content injection by an intermediary. Proper use of TLS protects against page alteration in transit and ensures a limited degree of privacy. Test your TLS setup with [testssl.sh](https://testssl.sh/) and [Webbkoll](https://webbkoll.dataskydd.net/). Mozilla's [HTTP Observatory](https://observatory.mozilla.org/) offers a subset of Webbkoll's features but it also gives a beginner-friendly score. Most sites should strive for at least a 50, but a score of 100 or even 120 shouldn't be too hard.

A false sense of security is far worse than transparent insecurity. Don't offer broken TLS ciphers, including TLS 1.0 and 1.1.

### Scripts and the Content Security Policy

Consider taking hardening measures to maximize the security benefits made possible by the simplicity of textual websites, starting with script removal.

JavaScript and WebAssembly are responsible for the bulk of modern web exploits. Ideally, a text-oriented site can enforce a scripting ban at the [<abbr title="content security policy">CSP</abbr>](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP) level. For example, here's the CSP for `https://seirdy.one`:

```
content-security-policy: default-src 'none';
img-src 'self' data:;
style-src 'sha256-g8fT13xy415WmQo4vYgG4v4xJiNmrhPYQ9PGDGfXX5Y=';
style-src-attr 'none';
frame-ancestors 'none'; base-uri 'none'; form-action 'none';
manifest-src https://seirdy.one/manifest.min.ca9097c5e38b68514ddcee23bc6d4d62.webmanifest;
upgrade-insecure-requests; navigate-to 'none';
sandbox allow-same-origin
```

`script-src: 'none'` is implied by `default-src: 'none'`, causing a compliant browser to forbid the loading of scripts. Furthermore, the `sandbox` CSP directive forbids a [wide variety](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/sandbox) of potentially insecure actions. While `script-src` restricts script loading, `sandbox` can also restrict script execution with stronger defenses against script injection (e.g. by a browser addon).[^1] I added the `allow-same-origin` parameter so that these addons will still be able to function.[^2]

### If you must enable scripts

Please use progressive enhancement (<abbr title="progressive enhancement">PE</abbr>)[^3] throughout your site; every feature possible should be optional, and scripting is no exception.

I'm sure you're a great person, but your readers might not know that; don't expect them to trust your website. Your scripts should look as safe as possible to an untrusting eye. Avoid requesting permissions or using [sensitive APIs](https://browserleaks.com/javascript).

Finally, consider using your CSP to restrict script loading. If you must use inline scripts, selectively allow them with a hash or nonce. Some [recent directives](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/trusted-types) restrict and enforce proper use of [trusted types](https://web.dev/trusted-types/).

About fonts
-----------

If you really want, you could use serif instead of sans-serif; however, serif fonts tend to look worse on low-res monitors. Not every screen's <abbr title="Dots Per Inch">DPI</abbr> has three digits.

To ship custom fonts is to assert that branding is more important than user choice. That might very well be a reasonable thing to do; branding isn't evil! That being said, textual websites in particular don't benefit much from branding. Beyond basic layout and optionally supporting dark mode, authors generally shouldn't dictate the presentation of their websites; that should be the job of the user agent. Most websites are not important enough to look completely different from the rest of the user's system.

A personal example: I set my preferred fonts in my computer's fontconfig settings. Now every website that uses sans-serif will have my preferred font. Sites with sans-serif blend into the users' systems instead of sticking out.

### But most users don't change their fonts...

The "users don't know better and need us to make decisions for them" mindset isn't without merits; however, in my opinion, it's overused. Using system fonts doesn't make your website harder to use, but it does make it smaller and stick out less to the subset of users who care enough about fonts to change them. This argument isn't about making software easier for non-technical users; it's about branding by asserting a personal preference.

### Can't users globally override stylesheets instead?

It's not a good idea to require users to automatically override website stylesheets. Doing so would break websites that use fonts such as Font Awesome to display vector icons. We shouldn't have these users constantly battle with websites the same way that many adblocking/script-blocking users (myself included) already do when there's a better option.

That being said, many users _do_ actually override stylesheets. We shouldn't _require_ them to do so, but we should keep our pages from breaking in case they do. Pages following this article's advice will probably work perfectly well in these cases without any extra effort.

### But wouldn't that allow a website to fingerprint with fonts?

I don't know much about fingerprinting, except that you can't do font enumeration without JavaScript. Since text-based websites that follow these best-practices don't send requests after the page loads and have no scripts, they shouldn't be able to fingerprint via font enumeration.

Other websites can still fingerprint via font enumeration using JavaScript. They don't need to stop at seeing what sans-serif maps to: they can see all the available fonts on a user's system, the user's canvas fingerprint, window dimensions, etc. Some of these can be mitigated with Firefox's `privacy.resistFingerprinting` setting, but that setting also understandably overrides user font preferences.

Ultimately, surveillance self-defense on the web is an arms race full of trade-offs. If you want both privacy and customizability, the web is not the place to look; try Gemini or Gopher instead.

About lazy loading
------------------

Lazy loading may or may not work. Some browsers, including Firefox and the Tor Browser, disable lazy-loading when the user turns off JavaScript. Turning it off makes sense because lazy-loading, like JavaScript, is a fingerprinting vector. Specifically, it identifies idiosyncratic scrolling patterns:

<figure itemscope itemtype="https://schema.org/Quotation">
	<blockquote>
		<p>Loading is only deferred when JavaScript is enabled. This is an anti-tracking measure, because if a user agent supported lazy loading when scripting is disabled, it would still be possible for a site to track a user's approximate scroll position throughout a session, by strategically placing images in a page's markup such that a server can track how many images are requested and when.</p>
	</blockquote>
	<figcaption class="h-cite" itemprop="citation">
		&mdash; <cite itemprop="isPartOf" itemscope itemtype="https://schema.org/TechArticle"><a class="u-url p-name" itemprop="url" href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/img"><span itemprop="name">&lt;img&gt;: The Image Embed element</span></a></cite> on <abbr title="Mozilla Developer Network">MDN</abbr>, <a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/img#attr-loading"> the <code>loading</code> attribute</a>
	</figcaption>
</figure>

If you can't rely on lazy loading, your pages should work well without it. If pages work well without lazy loading, is it worth enabling?

I don't think so: lazy loading often frustrates users on slow connections. I think I can speak for some of these users: mobile data near my home has a number of "dead zones" with abysmal download speeds, and my home's Wi-Fi repeater setup occasionally results in packet loss rates above 60%&nbsp;(!!).

Users on poor connections have better things to do than idly wait for pages to load. They might open multiple links in background tabs to wait for them all to load at once, and/or switch to another task and come back when loading finishes. They might also open links while on a good connection before switching to a poor connection. For example, I often open 10-20 links on Wi-Fi before going out for a walk in a mobile-data dead-zone. A Reddit user reading an earlier version of this article described a [similar experience](https://i.reddit.com/r/web_design/comments/k0dmpj/an_opinionated_list_of_best_practices_for_textual/gdmxy4u/) riding the train.

Unfortunately, pages with lazy loading don't finish loading off-screen images in the background. To load this content ahead of time, users need to switch to the loading page and slowly scroll to the bottom to ensure that all the important content appears on-screen and starts loading. Website owners shouldn't expect users to have to jump through these ridiculous hoops.

A similar attribute that I _do_ recommend is the [`decoding`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/Img#attr-decoding) attribute. I typically use `decoding="async"` so that image decoding can be deferred.

### Would pre-loading/pre-fetching solve the issues with lazy-loading?

Pre-loading essential resources is fine, but speculatively pre-loading content that the user may or may not request isn't.

A large number of users with poor connections also have capped data, and would prefer that pages don't decide to predictively load many pages ahead-of-time for them. Some go so far as to disable this behavior to avoid data overages. Savvy privacy-conscious users also generally disable pre-loading since pre-loading behavior is fingerprintable.

Users who click a link _choose_ to load a full page. Loading pages that a user hasn't clicked on is making a choice for that user. I encourage adoption of "link" HTTP headers to pre-load essential and above-the-fold resources when possible, but doing so does not resolve the issues with lazy-loading: the people who are harmed by lazy loading are more likely to have pre-fetching disabled.

### Can't users on poor connections disable images?

I have two responses:

1. If an image isn't essential, you shouldn't include it inline.
2. Yes, users could disable images. That's _their_ choice. If your page uses lazy loading, you've effectively (and probably unintentionally) made that choice for a large number of users.

About custom colors
-------------------

Some users' browsers set default page colors that aren't black-on-white. For instance, Linux users who enable GTK style overrides might default to having white text on a dark background. Websites that explicitly set foreground colors but leave the default background color (or vice-versa) end up being difficult to read. Here's an example:

<a href="https://seirdy.one/misc/website_colors_large.png">
{{< picture name="website_colors" alt="This page with a grey background behind black/grey headers and white-on-white code snippets" >}}
</a>

A second opinion: {{% indieweb-person first-name="Chris" last-name="Siebenmann" url="https://utcc.utoronto.ca/~cks/" %}} describes this in more detail in <cite>[AWebColoursProblem](https://utcc.utoronto.ca/~cks/space/blog/web/AWebColoursProblem)</cite>. In short: when setting colors, always set both the foreground and the background color. Don't set just one of the two.

Chris also describes the importance of visited link colors in <cite>[RealBlogUsability](https://utcc.utoronto.ca/~cks/space/blog/web/RealBlogUsability)</cite>.

### Color overrides and accessibility

Even if you set custom colors, ensure that the page is compatible with color overrides: elements shouldn't be distinguished solely by foreground and background color. [Technique C25](https://www.w3.org/WAI/WCAG22/Techniques/css/C25) for the <cite>Web Content Accessibility Guidelines (<abbr title="Web Content Accessibility Guidelines">WCAG</abbr>) 2.2</cite> describes how doing so can meet the WCAG 2.2's [Success Criterion 1.4.8](https://www.w3.org/WAI/WCAG22/Understanding/visual-presentation). Specifically, it describes using default colors in combination with visible borders. The latter helps distinguish elements from surrounding content without relying on a custom color palette.

This page's [canonical location](https://seirdy.one/2020/11/23/website-best-practices.html) is an example application of Technique C25 (and the related [Technique G148](https://www.w3.org/WAI/WCAG22/Techniques/general/G148)). It only uses non-default colors when a user agent requests a dark color scheme (using the `prefers-color-scheme` CSS media query; see the next subsection) and for lightening borders. Any image with a solid background may match the page background; to ensure that their dimensions are clear, I surrounded them with borders. I included horizontal lines further down to break up next/prev post navigation as well as separate footers, since these elements lack heading-based delineation. When overriding color schemes or disabling CSS altogether, the page layout remains clear.

The aforementioned techniques ensure a clear page layout independently of color scheme.

### Dark themes

If you do explicitly set colors, please also include a dark theme using a media query: `@media (prefers-color-scheme: dark)`. For more info, read the relevant docs [on MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-color-scheme)

When setting colors, especially with a dark background, I recommend checking your page's contrast using <abbr title="Advanced Perceptual Contrast Algorithm">APCA</abbr> values. You can do so in an [online checker](https://uglyduck.ca/lazy-dev-dark-mode/) or Chromium's developer tools (you might have to enable them in a menu for experimental preferences). Blue and purple links on a black background have much worse perceptual contrast than yellow or green links. Also, remember that the darker the background, the less battery your website will require devices with OLED screens.

Note that the APCA isn't fully mature as of early 2022. Until version 3.0 of the WCAG is ready, pages should also conform to the contrast ratios described in the WCAG 2.2's success criterions  1.4.3 (Contrast: Minimum, level AA) or 1.4.6 (Contrast: Enhanced, level AAA).

CSS filters such as `invert` are expensive to run, so use them sparingly. Simply inverting your page's colors to provide a dark theme could slow it down or cause a user's fans to spin.

Image optimization
------------------

Some image optimization tools I use:

- [`pngquant`](https://pngquant.org) (lossy)
- [`oxipng`](https://github.com/shssoichiro/oxipng) (lossless)
- [`jpegoptim`](https://github.com/tjko/jpegoptim) (lossless or lossy)
- [`cwebp`](https://developers.google.com/speed/webp/docs/cwebp) (lossless or lossy)
- `avifenc` (lossless or lossy), included in [libavif](https://github.com/AOMediaCodec/libavif)

I put together a [quick script](https://git.sr.ht/~seirdy/dotfiles/tree/3b722a843f3945a1bdf98672e09786f0213ec6f6/Executables/shell-scripts/bin/optimize-image) to losslessly optimize images using these programs in my dotfile repo.

You also might want to use the HTML `<picture>` element, using JPEG/PNG as a fallback for more efficient formats such as WebP or AVIF. More info in the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/picture)

Most of my images will probably be screenshots that start as PNGs. My typical flow:

1. Re-size and crop the image. Convert to grayscale if colors aren't important.
2. Lossy compression with `pngquant`
3. Losslessly optimize the result with `oxipng` and its Zopfli backend (slow)
4. Also create a lossless WebP from the lossy PNG and a lossy WebP from the source image, using `cwebp`. Pick the smaller of the two.
5. Include the resulting WebP in the page, with a fallback to the PNG using a `<picture>` element.
6. Create a lossy AVIF image from the original source image, and include it in the `<picture>` element if it's smaller than the WebP.
7. If the image is too light, repeat for a dark version of the image to display with a `prefers-dark-mode` media query.

Here's a sample command to compress a PNG image using ImageMagick, `pngquant`, and `oxipng`. It shrinks the image, turns it grayscale, reduces the color palette, and then applies lossless Zopfli compression:

```sh
convert -resize 75% original.png -colorspace GRAY -format png - \
	| pngquant -s 1 12 - \
	| oxipng -o max -Z --fix - --out compressed.png
```

It might seem odd to create a lossless WebP from a lossy PNG, but I've found that it's often the best way to get the smallest possible image at the minimum acceptable quality for screenshots with solid backgrounds.

In general, avoid using inline images just for decoration. Only use an image if it has a clear purpose that significantly adds to the content in a way that text can't replace, and provide alt-text as a fallback. Any level of detail that isn't necessary for getting the point across should be removed with lossy compression and cropping. Some conventional wisdom for image compression doesn't hold up when compressing this aggressively; for instance, I've found that extremely aggressive dithering and PNG compression of small black-and-white images consistently surpasses JPEG compression.

If you want to include a profile photo (e.g., if your website is part of the IndieWeb), I recommend re-using one of your favicons. Doing so should be harmless since most browsers will fetch and cache favicons anyway.

If you really want to go overboard with PNG optimization, you can try a tool like [Efficient Compression Tool](https://github.com/fhanau/Efficient-Compression-Tool).

Layout
------

This is possibly the most subjective item I'm including, and the item with the most exceptions. Consider it more of a weak suggestion than hard advice. Use your own judgement.

A simple layout looks good at a variety of window sizes, rendering responsive layout changes unnecessary. Textual websites really don't need more than a single column; readers should be able to scan a page top-to-bottom, left-to-right (or right-to-left, depending on the locale) exactly once to read all its content. Verify this using the horizontal-line test: mentally draw a horizontal line across your page, and make sure it doesn't intersect more than one (1) item. Keeping a single-column layout that doesn't require responsive layout changes ensures smooth window re-sizing.

Exceptions exist: one or two very simple responsive changes won't hurt. For example, the only responsive layout change on [my website](https://seirdy.one/) is a single CSS declaration to switch between inline and multi-line navigation links at the top of the page:

```
@media (min-width: 32rem) {
  nav li {
    display: inline;
  }
}
```

Nontrivial use of width-selectors, in CSS or `<source>` tags, is actually a powerful vector for [JS-free fingerprinting](https://matt.traudt.xyz/posts/2016-09-04-how-css-alone-can-help-track-you/).

Achieving this type of layout entails using the WCAG 2.2 techniques <cite>[C27: Making the DOM order match the visual order](https://www.w3.org/WAI/WCAG22/Techniques/css/C27.html)</cite> as well as <cite>[C6: Positioning content based on structural markup](https://www.w3.org/WAI/WCAG22/Techniques/css/C6)</cite>.

### What about sidebars?

Sidebars are probably unnecessary, and can be quite annoying to readers who re-size windows frequently. This is especially true for tiling window manager users like me: we frequently shrink windows to a fraction of their original size. When this happens on a website with a sidebar, one of two things happens:

1. The site's responsive design kicks in: the sidebar vanishes and its elements move elsewhere. This can be quite CPU-heavy, as the browser has to both re-wrap the text _and_ handle a complex layout change. Frequent window re-sizers will experience lag and battery loss, and might need a moment to figure out where everything went.
2. The site doesn't use responsive design. The navbar and main content are now squeezed together. Readers will probably close the page.

Neither situation looks great.

### Sidebar alternatives

Common items in sidebars include article tags, an author bio, and an index of entries; these aren't useful while reading an article. Consider putting them in the article footer or--even better--dedicated pages. This does mean that readers will have to navigate to a different page to see that content, but they probably prefer things that way; almost nobody who clicked on "An opinionated list of best practices for textual websites" did so because they wanted to read my bio.

Don't boost engagement by providing readers with information they didn't ask for; earn engagement with good content, and let readers navigate to your other pages _after_ they've decided they want to read more.

Tor
---

Many people use Tor out of necessity. On Tor, additional constraints apply.

For one, Tor users are encouraged to set the Tor Browser Bundle's (<abbr title="Tor Browser Bundle">TBB</abbr>) [security settings](https://tb-manual.torproject.org/en-US/security-settings/) to "safest". This disables scripts, MathML, some fonts, SVG images, and [other features](https://gitweb.torproject.org/torbutton.git/tree/modules/security-prefs.js). If your site has any SVG images, be sure to provide a fallback to raster formats using a `<picture>` element.

Additionally, hopping between nodes in Tor circuits incurs latency, worsening the impacts of requiring multiple requests and round-trips. Try to minimise the number of requests to view a page.

If you use a CDN or some overcomplicated website security stack, make sure it doesn't block Tor users or require them to enable JS to complete a CAPTCHA. To go above and beyond, try mirroring your site to an onion service to reduce the need for exit nodes.

Testing
-------

If your site is simple enough, it should automatically handle the vast majority of edge-cases. Different devices and browsers all have their quirks, but they generally have one thing in common: they understand semantic, backward-compatible HTML.

In addition to standard testing, I recommend testing with unorthodox setups that are unlikely to be found in the wild. If a website doesn't look good in one of these tests, there's a good chance that it uses an advanced Web feature that can serve as a point of failure in other cases. Simple sites should be able to look good in a variety of situations out of the box.

Your page should easily pass the harshest of tests without any extra effort if its HTML meets basic standards for well-written code (overlooking bad formatting and a lack of comments). Even if you use a complex static site generator, the final HTML should be simple, readable, and semantic.

### Sample unorthodox tests

These tests start out pretty reasonable, but gradually get more ridiculous. Once again, use your judgement.

1. Evaluate the heaviness and complexity of your scripts (if any) by testing with your browser's <abbr title="just-in-time">JIT</abbr> compilation disabled.[^4]
2. Test using the Tor browser with the safest security level enabled (disables JS, SVG, and other features).
3. Load just the HTML. No CSS, no images, etc. Try loading without inline CSS as well for good measure.
4. Print out the site in black-and-white, preferably with a simple laser printer.
5. Test with a screen reader.
6. Test keyboard navigability with the <kbd>TAB</kbd> key. Even without specifying tab indexes, tab selection should follow a logical order if you keep the layout simple.
7. Test in textual browsers: lynx, links, w3m, ELinks, edbrowse, EWW, Netrik, etc.
8. Read the (prettified/indented) HTML source itself and parse it with your brain. See if anything seems illogical or unnecessary. Imagine giving someone a printout of your page's `<body>` along with a whiteboard. If they have a basic knowledge of HTML tags, would they be able to draw something resembling your website?
9. Test in an online website translator tool.
10. Test on something ridiculous: try your old e-reader's embedded browser, combine an HTML-to-EPUB converter and an EPUB-to-PDF converter, or stack multiple article-extraction utilities on top of each other. Be creative and enjoy breaking your site. When something breaks, examine the breakage and see if you can fix it by simplifying your page.
11. Build a time machine. Travel decades--or perhaps centuries--into the future. Keep going forward until the WWW is breathing its last breath. Test your site on future browsers. Figuring out how to transfer your files onto their computers might take some time, but you have a time machine so that shouldn't be too hard. When you finish, go back in time to [meet Benjamin Franklin](https://xkcd.com/567/).

I'm still on step 10, trying to find new ways to break this page. If you come up with a new test, please [share it](mailto:~seirdy/seirdy.one-comments@lists.sr.ht).

In defense of link underlines
-----------------------------

Some typographers insist that [underlined on-screen text is obsolete](https://practicaltypography.com/underlining.html), and hyperlinks are no exception. I disagree.

One reason is that underlines make it easy to separate multiple consecutive inline links:

{{< picture name="underlines" alt="a line of three consecutive hyperlinks with and without underlines" >}}

Underlines also make it easy for readers with color vision deficiencies to distinguish links from surrounding text. A basic WCAG Level A requirement is for information to not be conveyed solely through color:

<figure itemscope itemtype="https://schema.org/Quotation">
	<blockquote>
		<p>Color is not used as the only visual means of conveying information, indicating an action, prompting a response, or distinguishing a visual element. (Level A)</p>
	</blockquote>
	<figcaption class="h-cite" itemprop="citation">
		&mdash; <cite itemprop="isPartOf" itemscope itemtype="https://schema.org/CreativeWork"><a class="u-url p-name" itemprop="url" href="https://www.w3.org/TR/WCAG22/"><span itemprop="name">WCAG 2.2</span></a></cite>, <a href="https://www.w3.org/TR/WCAG22/#distinguishable">section 1.4.1</a>
	</figcaption>
</figure>

Readers already expect underlined text to signify a hyperlink. Don't break fundamental affordances for aesthetics.

Other places to check out
-------------------------

This page can be thought of as an extension of the principles of Brutalist Web Design:

<figure itemscope itemtype="https://schema.org/Quotation">
	<blockquote>
		<ul>
		<li>Content is readable on all reasonable screens and devices.</li>
		<li>Only hyperlinks and buttons respond to clicks.</li>
		<li>Hyperlinks are underlined and buttons look like buttons.</li>
		<li>The back button works as expected.</li>
		<li>View content by scrolling.</li>
		<li>Decoration when needed and no unrelated content.</li>
		<li>Performance is a feature.</li>
		</ul>
	</blockquote>
	<figcaption class="h-cite" itemprop="citation">
		&mdash; {{<indieweb-person first-name="David" last-name="Copeland" url="https://naildrivin5.com/">}}, <cite itemprop="isPartOf" itemscope itemtype="https://schema.org/CreativeWork"><a class="u-url p-name" itemprop="url" href="https://brutalist-web.design/"><span itemprop="name">Brutalist Web Design</span></a></cite>
	</figcaption>
</figure>

The [250kb club](https://250kb.club/) gathers websites at or under 250kb, and also rewards websites that have a high ratio of content size to total size.

The [10KB Club](https://10kbclub.com/) does the same with a 10kb homepage budget (excluding favicons and webmanifest icons). It also has guidelines for noteworthiness, to avoid low-hanging fruit like mostly-blank pages.

My favorite website club has to be the [<abbr title="eXtreme HyperText Movement for Luddites">XHTML</abbr> Club](https://xhtml.club/) by {{<indieweb-person first-name="Bradley" last-name="Taunt" url="https://tdarb.org">}}, the creator of the original [1mb.club](https://1mb.club).

Also see [Motherfucking Website](https://motherfuckingwebsite.com/). Motherfucking Website inspired several unofficial sequels that tried to gently improve upon it. My favorite is [Best Motherfucking Website](https://bestmotherfucking.website/).

The [WebBS calculator](https://www.webbloatscore.com/) compares a page's size with the size of a PNG screenshot of the full page content, encouraging site owners to minimize the ratio of the two.

One resource I found useful (that eventually featured this article!) was the "Your page content" section of {{<indieweb-person first-name="Bill" last-name="Dietrich" url="https://www.billdietrich.me">}}'s comprehensive guide to [setting up your personal website](https://www.billdietrich.me/YourPersonalWebSite.html#PageContent).

If you've got some time on your hands, I _highly_ recommend reading the <cite>[Web Content Accessibility Guidelines (WCAG) 2.2](https://www.w3.org/TR/WCAG22/)</cite>. The WCAG 2 standard is technology-neutral, so it doesn't contain Web-specific advice. For that, check the <cite>[How to Meet WCAG (Quick Reference)](https://www.w3.org/WAI/WCAG22/quickref)</cite>. It combines the WCAG with its supplementary [list of techniques](https://www.w3.org/WAI/WCAG22/Techniques/).


[^1]: Many addons function by injecting content into pages; this significantly weakens many aspects of the browser security model (e.g. site and origin isolation) and should be avoided if at all possible. On sensitive pages with content such as public key fingerprints, I recommend setting a blank `sandbox` directive even if it means breaking these addons.

[^2]: Some addons will have reduced functionality; for instance, [Tridactyl](https://github.com/tridactyl/tridactyl) can't create an `<iframe>` for its command window. I consider this to be worthwhile since the most important functionality is still available, and because authors shouldn't feel compelled to support security weakening. I say this as someone who uses Tridactyl often.

[^3]: Here's an [overview of PE](https://en.wikipedia.org/wiki/Progressive_enhancement) and [my favorite write-up on the subject](https://whalecoiner.com/articles/progressive-enhancement).

[^4]: Consider disabling the JIT for your normal browsing too; doing so removes whole classes of vulnerabilities. In Firefox, toggle `javascript.options.ion`, `javascript.options.baselinejit`, `javascript.options.native_regexp`, `javascript.options.asmjs`, and `javascript.options.wasm` in `about:config`; in Chromium, run chromium with `--js-flags='--jitless'`; in the Tor Browser, set the security level to "Safer".



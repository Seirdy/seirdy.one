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
title: An opinionated list of best practices for textual websites
---
_The following applies to minimal websites that focus primarily on text. It does not apply to websites that have a lot of non-textual content. It also does not apply to websites that focus more on generating revenue or pleasing investors than being good websites._

This is a "living document" that I add to as I receive feedback. See the [changelog](https://git.sr.ht/~seirdy/seirdy.one/log/master/item/content/posts/website-best-practices.md).

I realize not everybody's going to ditch the Web and switch to Gemini or Gopher today (that'll take, like, a month at the longest). Until that happens, here's a non-exhaustive, highly-opinionated list of best practices for websites that focus primarily on text. I don't expect anybody to fully agree with the list; nonetheless, the article should have _some_ useful information for any web content author or front-end web developer.

My primary focus is [inclusive design](https://100daysofa11y.com/2019/12/03/accommodation-versus-inclusive-design/). Specifically, I focus on supporting _under&shy;represented ways to read a page_. Not all users load a page in a common web-browser and navigate effortlessly with their eyes and hands. Authors often neglect people who read through accessibility tools, tiny viewports, machine translators, "reading mode" implemen&shy;tations, the Tor network, printouts, hostile networks, and uncommon browsers. Compatibility with so many niches sounds far more daunting than it really is: if you only selectively override browser defaults and use semantic HTML, you've done half of the work already.

I'd like to re-iterate yet another time that this only applies to websites that primarily focus on text. If graphics, interactivity, etc. are an important part of your website, less of the article applies. My hope is for readers to consider _some_ points I make on this page the next time they build a website, and be aware of the trade-offs they make when they deviate. I don't expect--or want--anybody to follow all of my advice, because doing so would make the Web quite a boring place!

I'll cite the document <cite>[Techniques for WCAG&nbsp;2.2](https://www.w3.org/WAI/WCAG22/Techniques/)</cite> a number of times. Unlike the Web Content Accessibility Guidelines (<abbr title="Web Content Accessibility Guidelines">WCAG</abbr>), the Techniques document does not list requirements; rather, it serves to non-exhaustively educate authors about _how_ to use specific technologies to comply with the WCAG. I don't find much utility in the technology-agnostic goals enumerated by the WCAG without the accompanying technology-specific techniques to meet those goals.

{{<toc>}}

Security and privacy
--------------------

One of the defining differences between textual websites and advanced Web&nbsp;2.0 sites/apps is safety. Most browser vulnera&shy;bilities are related to modern Web features like JavaScript and WebGL. The simplicity of basic textual websites _should_ guarantee some extra safety; however, webmasters need to take additional measures to ensure limited use of "modern" risky features.

### TLS

All of the simplicity in the world won't protect a page from unsafe content injection by an intermediary. Proper use of TLS protects against page alteration in transit and ensures a limited degree of privacy. Test your TLS setup with <a translate="no" href="https://testssl.sh/">testssl.sh</a> and [Webbkoll](https://webbkoll.dataskydd.net/).

If your OpenSSL (or equivalent) version is outdated or you don't want to download and run a shell script, SSL Labs' [SSL Server Test](https://www.ssllabs.com/ssltest/) should be equivalent to testssl.sh. Mozilla's [HTTP Observatory](https://observatory.mozilla.org/) offers a subset of Webbkoll's features and is a bit out of date, but it also gives a beginner-friendly score. Most sites should strive for at least a 50, but a score of 100 or even 120 shouldn't be too hard to reach.

A false sense of security is far worse than transparent insecurity. Don't offer broken TLS ciphers, including TLS 1.0 and 1.1. Vintage computers can run TLS 1.2 implemen&shy;tations such as BearSSL surprisingly efficiently, leverage a TLS terminator, or they can use a plain unencrypted connection. A broken cipher suite is security theater.

### Scripts and the Content Security Policy

Consider taking hardening measures to maximize the security benefits made possible by the simplicity of textual websites, starting with script removal.

JavaScript and WebAssembly are responsible for the bulk of modern web exploits. Ideally, a text-oriented site can enforce a scripting ban at the [<abbr title="Content Security Policy">CSP</abbr>](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP) level.

<figure>
<figcaption>

This is the CSP for my website:

</figcaption>

```
content-security-policy: default-src 'none';
img-src 'self' data:;
style-src 'sha256-g8fT13xy415WmQo4vYgG4v4xJiNmrhPYQ9PGDGfXX5Y=';
style-src-attr 'none';
frame-ancestors 'none'; base-uri 'none'; form-action 'none';
manifest-src https://seirdy.one/manifest.min.ca9097c5e38b68514ddcee23bc6d4d62.webmanifest;
upgrade-insecure-requests;
sandbox allow-same-origin
```

</figure>

`default-src: 'none'` implies `script-src: 'none'`, causing a compliant browser to forbid the loading of scripts. Furthermore, the `sandbox` CSP directive forbids a [wide variety](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/sandbox) of potentially insecure actions. While `script-src` restricts script loading, `sandbox` can also restrict script execution with stronger defenses against script injection (e.g. by a browser addon).[^1] I added the `allow-same-origin` parameter so that these addons will still be able to function.[^2]

### If you must enable scripts

Please use progressive enhancement (<abbr title="progressive enhancement">PE</abbr>)[^3] throughout your site; every feature possible should be optional, and scripting is no exception.

I'm sure you're a great person, but your readers might not know that; don't expect them to trust your website. Your scripts should look as safe as possible to an untrusting eye. Avoid requesting permissions or using [sensitive APIs](https://browserleaks.com/javascript).

Finally, consider using your CSP to restrict script loading. If you must use inline scripts, selectively allow them with a hash or nonce. Some [recent directives](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/trusted-types) restrict and enforce proper use of [trusted types](https://web.dev/trusted-types/).

### Third-party content

Third-party content will complicate the CSP, allow more actors to track users, possibly slow page loading, and create more points of failure. Some privacy-conscious users actually block third-paraty content: while doing so is fingerprintable, it can reduce the amount of data collected about an already-identified user. Avoid third-party content, if at all possible.

About fonts
-----------

I recommend setting the default font to `sans-serif`. If you really want, you could use serif instead of sans-serif; however, serif fonts tend to look worse on low-res monitors. Not every screen's <abbr title="Dots Per Inch">DPI</abbr> has three digits. Accommodate users' default zoom levels by keeping your font size the same as most similar websites.

To ship custom fonts is to assert that branding is more important than user choice. That might very well be a reasonable thing to do; branding isn't evil! That being said, textual websites in particular don't benefit much from branding. Beyond basic layout and optionally supporting dark mode, authors generally shouldn't dictate the presentation of their websites; that should be the job of the user agent. Most websites are not important enough to look completely different from the rest of the user's system.

A personal example: I set my preferred browser font to `sans-serif`, and map it to my preferred font in my computer's fontconfig settings. Now every website that uses sans-serif will have my preferred font. Sites with sans-serif blend into the users' systems instead of sticking out.

### But most users don't change their fonts...

The "users don't know better and need us to make decisions for them" mindset isn't without merits; however, in my opinion, it's overused. Using system fonts doesn't make your website harder to use, but it does make it smaller and stick out less to the subset of users who care enough about fonts to change them. This argument isn't about making software easier for non-technical users; it's about branding by asserting a personal preference.

### Can't users globally override stylesheets instead?

It's not a good idea to require users to automatically override website stylesheets. Doing so would break websites that use fonts such as Font Awesome to display vector icons. We shouldn't have these users constantly battle with websites the same way that many ad- and script-blocking users (myself included) already do when there's a better option.

That being said, many users _do_ actually override stylesheets. We shouldn't _require_ them to do so, but we should keep our pages from breaking in case they do. Pages following this article's advice will probably work perfectly well in these cases without any extra effort.

### But wouldn't that allow a website to fingerprint with fonts?

I don't know much about fingerprinting, except that you can't do font enumeration or accurately calculate font metrics without JavaScript. Since text-based websites that follow these best-practices don't send requests after the page loads and have no scripts, they shouldn't be able to fingerprint via font enumeration.

Other websites can still fingerprint via font enumeration using JavaScript. They don't need to stop at seeing what sans-serif maps to: they can see all the available fonts on a user's system, the user's canvas fingerprint, window dimensions, etc. Some of these can be mitigated with Firefox's [protections against fingerprinting](https://support.mozilla.org/en-US/kb/firefox-protection-against-fingerprinting), but these protections understandably override user font preferences.

Ultimately, surveillance self-defense on the web is an arms race full of trade-offs. If you want both privacy and customizability, the web is not the place to look; try Gemini or Gopher instead.

Against lazy loading
--------------------

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

Users on poor connections have better things to do than idly wait for pages to load. They might open multiple links in background tabs to wait for them all to load at once, and/or switch to another task and come back when loading finishes. They might also open links while on a good connection before switching to a poor connection. For example, I often open several links on Wi-Fi before going out for a walk in a mobile-data dead-zone. A Reddit user reading an earlier version of this article described a [similar experience](https://i.reddit.com/r/web_design/comments/k0dmpj/an_opinionated_list_of_best_practices_for_textual/gdmxy4u/) riding the train.

Unfortunately, pages with lazy loading don't finish loading off-screen images in the background. To load this content ahead of time, users need to switch to the loading page and slowly scroll to the bottom to ensure that all the important content appears on-screen and starts loading. Website owners shouldn't expect users to have to jump through these ridiculous hoops.

A similar attribute that I _do_ recommend is the [`decoding`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/Img#attr-decoding) attribute. I typically use `decoding="async"` so that image decoding can be deferred.

### Would pre-loading or pre-fetching solve the issues with lazy-loading?

Pre-loading essential resources is fine, but speculatively pre-loading content that the user may or may not request isn't.

A large number of users with poor connections also have capped data, and would prefer that pages don't decide to predictively load many pages ahead-of-time for them. Some go so far as to disable this behavior to avoid data overages. Savvy privacy-conscious users also generally disable pre-loading since pre-loading behavior is fingerprintable.

Users who click a link _choose_ to load a full page. Loading pages that a user hasn't clicked on is making a choice for that user. I encourage adoption of "link" HTTP headers to pre-load essential and above-the-fold resources when possible, but doing so does not resolve the issues with lazy-loading: the people who are harmed by lazy loading are more likely to have pre-fetching disabled.

### Can't users on poor connections disable images?

I have two responses:

1. If an image isn't essential, you shouldn't include it inline.
2. Yes, users could disable images. That's _their_ choice. If your page uses lazy loading, you've effectively (and probably unintention&shy;ally) made that choice for a large number of users.

### Related issues

Pages should finish making all network requests while loading, save for a form submission. I singled out lazy-loading, but other factors can violate this constraint.

One example is pagination. It's easier to download one long article ahead of time, but inconvenient to load each page separately. Displaying content all at once also improves searchability. The single-page approach has obvious limits: don't expect users to happily download a single-page novel.

Another common offender is infinite-scrolling. This isn't an issue without JavaScript. Some issues with infinite-scrolling were summed up quite nicely in [a single panel on xkcd](https://xkcd.com/1309/).

About custom colors
-------------------

Some users' browsers set default page colors that aren't black-on-white. For instance, Linux users who enable GTK style overrides might default to having white text on a dark background. Websites that explicitly set foreground colors but leave the default background color (or vice-versa) end up being difficult to read. Don't strain your eyes trying to read this example:

<figure>
<a href="http://bettermotherfuckingwebsite.com/">
{{< picture name="website_colors" alt="Screenshot of a website with gray text on a darker grey background. Details in the caption." >}}
</a>
<figcaption>

This is an unreadable screenshot of a website [promoting browser style overrides](http://bettermotherfuckingwebsite.com/) (specifically, the "A little less contrast" section). I had set my browser foreground and background colors to white and dark gray, respectively. The website overrode the foreground colors while assuming that everyone browses with a white background.

</figcaption>
</figure>

A second opinion: {{% indieweb-person first-name="Chris" last-name="Siebenmann" url="https://utcc.utoronto.ca/~cks/" %}} describes this in more detail in <cite>[AWebColours&shy;Problem](https://utcc.utoronto.ca/~cks/space/blog/web/AWebColoursProblem)</cite>. In short: when setting colors, always set both the foreground and the background color. Don't set just one of the two.

Chris also describes the importance of visited link colors in <cite>[VisitedLinks<wbr>Usability](https://utcc.utoronto.ca/~cks/space/blog/web/VisitedLinksUsability)</cite>.

### Color overrides and accessibility

Even if you set custom colors, ensure that the page is compatible with color overrides: elements shouldn't be distinguished solely by foreground and background color. [Technique C25](https://www.w3.org/WAI/WCAG22/Techniques/css/C25) for the <cite>Web Content Accessibility Guidelines (<abbr title="Web Content Accessibility Guidelines">WCAG</abbr>)&nbsp;2.2</cite> describes how doing so can meet the WCAG&nbsp;2.2's [Success Criterion&nbsp;1.4.8](https://www.w3.org/WAI/WCAG22/Understanding/visual-presentation). Specifically, it describes using default colors in combination with visible borders. The latter helps distinguish elements from surrounding content without relying on a custom color palette.

This page's [canonical location](https://seirdy.one/2020/11/23/website-best-practices.html) is an example application of Technique C25 (and the related [Technique G148](https://www.w3.org/WAI/WCAG22/Techniques/general/G148)). It only uses non-default colors when a user agent requests a dark color scheme (using the `prefers-color-scheme` CSS media query; see the next subsection) and for lightening borders. Any image with a solid background may match the page background; to ensure that their dimensions are clear, I surrounded them with borders. I also set a custom color for the borders and ensure that the image backgrounds don't match the border colors. I included horizontal rules (`<hr>`) further down to break up next/prev post navigation as well as separate footers, since these elements lack heading-based delineation. When overriding color schemes or disabling CSS altogether, the page layout remains clear.

The aforementioned techniques ensure a clear page layout while respecting user-specified color schemes.

### Dark themes

If you do explicitly set colors, please also include a dark theme using a media query: `@media (prefers-color-scheme: dark)`. For more info, read the relevant docs [on MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-color-scheme). Dark themes are helpful for readers with photosensitivity (like me!) or migraines, and people in dark environments.

When setting colors, especially with a dark background, I recommend checking your page's contrast using Advanced Perceptual Contrast Algorithm (<abbr title="Advanced Perceptual Contrast Algorithm">APCA</abbr>) values. You can do so in an [online checker](https://uglyduck.ca/lazy-dev-dark-mode/) or Chromium's developer tools (you might have to enable them in a menu for experimental preferences). Blue and purple links on a black background have much worse perceptual contrast than yellow or green links.

Note that the APCA isn't fully mature as of early 2022. Until version 3.0 of the WCAG is ready, pages should also conform to the contrast ratios described in the WCAG&nbsp;2.2's success criteria 1.4.3 (Contrast: Minimum, level AA) or 1.4.6 (Contrast: Enhanced, level AAA).

CSS filters such as `invert` are expensive to run, so use them sparingly. Simply inverting your page's colors to provide a dark theme could slow it down or cause a user's fans to spin.

Darker backgrounds draw less power on devices with OLED screens; however, backgrounds should never be solid black. White text on a black background causes halation, especially among astigmatic readers. There has been some [experimental](https://www.laurenscharff.com/research/AHNCUR.html) and plenty of [anecdotal](https://jessicaotis.com/academia/never-use-white-text-on-a-black-background-astygmatism-and-conference-slides/) evidence to support this. I personally like a foreground and background of `#ececec` and `#0c0c0c`, respectively. These shades seem to be as far apart as possible without causing accessibility issues: `#0c0c0c` is barely bright enough to create a soft "glow" capable of minimizing halos, but won't ruin contrast on cheap displays.

"Just disable dark mode" is a poor response to users complaining about halation: it ignores the utility of dark themes described at the beginning of this section.

If you can't bear the thought of parting with your solid-black background, worry not: there exists a CSS media feature and client-hint for contrast preferences called `prefers-contrast`. It takes the parameters `no-preference`, `less`, and `more`. You can serve increased-contrast pages to those who request `more`, and vice versa. Check [prefers-contrast on MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-contrast) for more information.

Image optimiza&shy;tion {#image-optimization}
-----------------------

Some image optimization tools I use:

- [`pngquant`](https://pngquant.org) (lossy)
- [`oxipng`](https://github.com/shssoichiro/oxipng) (lossless)
- [`jpegoptim`](https://github.com/tjko/jpegoptim) (lossless or lossy)
- [`cwebp`](https://developers.google.com/speed/webp/docs/cwebp) (lossless or lossy)
- `avifenc` (lossless or lossy), included in <a href="https://github.com/AOMediaCodec/libavif" translate="no">libavif</a>

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

<figure id="png-pipeline">
<figcaption>

This is a sample command to compress a PNG image using ImageMagick, `pngquant`, and `oxipng`. It shrinks the image, turns it grayscale, reduces the color palette, and then applies lossless Zopfli compression:

</figcaption>

<pre>
<code>convert <var translate="yes">ORIGINAL_FILE</var> &bsol;
  -resize 75% -colorspace gray -format png - &bsol;
  | pngquant -s 1 12 - &bsol;
  | oxipng -o max -Z --fix - --out <var translate="yes">OUTPUT_FILE</var>
</code></pre>

</figure>

It might seem odd to create a lossless WebP from a lossy PNG, but I've found that it's often the best way to get the smallest possible image at the minimum acceptable quality for screenshots with solid backgrounds.

In general, avoid using inline images just for decoration. Only use an image if it has a clear purpose that significantly adds to the content in a way that text can't replace, and provide alt-text as a fallback. Any level of detail that isn't necessary for getting the point across should be removed with lossy compression and cropping. Some conventional wisdom for image compression doesn't hold up when compressing this aggressively; for instance, I've found that extremely aggressive dithering and PNG compression of small black-and-white images consistently surpasses JPEG compression.

If you want to include a profile photo (e.g., if your website is part of the IndieWeb and uses an [h-card](https://microformats.org/wiki/h-card)), I recommend re-using one of your favicons. Doing so should be harmless since most browsers will fetch and cache favicons anyway.

If you really want to go overboard with PNG optimization, you can try a tool like [Efficient Compression Tool](https://github.com/fhanau/Efficient-Compression-Tool).

### Dark image variants

A `<picture>` element allows selection of sources based on any CSS media query. When images have light backgrounds, I like to include dark variants too.

<figure>
<figcaption>
A minimal example of a <code>picture</code> with a dark variant:
</figcaption>

```
<source type=image/png
  srcset=/p/dark.png
  media="screen and (prefers-color-scheme: dark)">
<source type=image/png
  srcset=/p/light.png>
```

</figure>

Requiring the `screen` media type prevents selection of dark variants when printing. Printer paper is almost always white, so dark images could waste ink. Ink waste is a sensitive issue among many students: school printers sometimes charge students who exceed a given ink quota. Ask me how I know!

Light and dark variants of legacy formats (PNG, JPG, GIF), WebP, and AVIF can cause some of my `<picture>` imagesets to have up to six image variants. I could fully automate the process using my static site generator (Hugo) if I wanted to. Since I do want to inspect each image and compress to the minimum acceptable quality, I settled for partial automation using shell scripts and [a Hugo shortcode](https://git.sr.ht/~seirdy/seirdy.one/tree/master/layouts/shortcodes/picture.html).

### SVG images

I only recommend using SVG in images; avoid using them in embeds, objects, or directly in the body. Remember that users may save images and open them in a non-browser image viewer with reduced SVG compatibility. To maintain maximum compatibility, stick to the subset of [SVG Static](https://www.w3.org/TR/SVG11/feature#SVG-static)'s [secure static processing mode](https://www.w3.org/TR/SVG/conform.html#secure-static-mode) that appears in the [SVG Tiny Portable<wbr>/Secure (<abbr title="Portable/Secure">PS</abbr>)](https://datatracker.ietf.org/doc/draft-svg-tiny-ps-abrotman/) spec. SVG Tiny PS is a subset of [SVG Tiny&nbsp;1.2](https://www.w3.org/TR/SVGTiny12/intro.html), which is a supported export format in most vector drawing programs. Ignore the elements specifically required for SVG Tiny PS; your image can be a standard SVG that only utilizes a tiny subset of the full SVG spec.

The above advice might seem daunting, but it’s usually easy to use existing tools to generate an SVG Tiny file and manually edit it to support the SVG secure static mode. SVGs that conform to this subset should be compatible with Qt5's SVG implemen&shy;tation, librsvg (used by Wikipedia and GNOME), and most operating systems' icon renderers.

Two tools that can optimize the size of an SVG file are [SVGO](https://github.com/svg/svgo) and the now-discontinued [svgcleaner](https://github.com/RazrFalcon/svgcleaner). Don't overdo lossy compression with these tools, since lossy compression can sometimes _reduce_ the effectiveness of gzip and Brotli compression.

Layout
------

This is possibly the most subjective item I'm including, and the item with the most exceptions. Consider it more of a weak suggestion than hard advice. Use your own judgement.

The first or second heading in the DOM, and the highest heading level, should be the page title marking the start of your main content (i.e. it should come after the site title, site navigation links, etc). Only if this is impossible should you consider adding a "skip link" instead. Visually-impaired users generally prefer navigating by headings.

A simple layout looks good at a variety of window sizes, rendering responsive layout changes unnecessary. Textual websites really don't need more than a single column; readers should be able to scan a page top-to-bottom, left-to-right (or right-to-left, depending on the locale) exactly once to read all its content. Verify this using the horizontal-line test: mentally draw a horizontal line across your page, and make sure it doesn't intersect more than one (1) item. Keeping a single-column layout that doesn't require responsive layout changes ensures smooth window re-sizing.

Exceptions exist: one or two very simple responsive changes won't hurt. The main anti-patterns are adjusting the relative order of elements, and layout shifts dramatic enough to cause confusion.

<figure>
<figcaption>

The only responsive layout change on [my website](https://seirdy.one/) is a single CSS declaration to switch between inline and multi-line navigation links at the top of the page:

</figcaption>

```
@media print, (min-width: 32rem) {
  header nav li {
    display: inline;
  }
}
```

</figure>

Nontrivial use of width-selectors, in CSS or imagesets, is actually a powerful vector for [JS-free fingerprinting](https://matt.traudt.xyz/posts/2016-09-04-how-css-alone-can-help-track-you/). This is one of the reasons why I didn't recommend resolution- or dimension-aware imagesets in the [image optimization section](#image-optimization).

Achieving this type of layout entails using the WCAG&nbsp;2.2 techniques <cite>[C27: Making the DOM order match the visual order](https://www.w3.org/WAI/WCAG22/Techniques/css/C27.html)</cite> as well as <cite>[C6: Positioning content based on structural markup](https://www.w3.org/WAI/WCAG22/Techniques/css/C6)</cite>.

### What about sidebars?

Sidebars are probably unnecessary, and can be quite annoying to readers who re-size windows frequently. This is especially true for tiling window manager users like me: we frequently shrink windows to a fraction of their original size. When this happens on a website with a sidebar, one of two things happens:

1. The site's responsive design kicks in: the sidebar vanishes and its elements move elsewhere. This can be quite CPU-heavy, as the browser has to both re-wrap the text _and_ handle a complex layout change. Frequent window re-sizers will experience lag and battery loss, and might need a moment to figure out where everything went.
2. The site doesn't use responsive design. The navbar and main content are now squeezed together. Readers will probably close the page.

Neither situation looks great.

### Sidebar alternatives

Common items in sidebars include tag clouds, an author bio, and an index of entries; these aren't useful while reading an article. Consider putting them in the article footer or--even better--dedicated pages. This does mean that readers will have to navigate to a different page to see that content, but they probably prefer things that way; almost nobody who clicked on "An opinionated list of best practices for textual websites" did so because they wanted to read my bio.

Don't boost engagement by providing readers with information they didn't ask for; earn engagement with good content, and let readers navigate to your other pages _after_ they've decided they want to read more.

### Accessible skimming

Keeping an identical source order, DOM order, and visual order should also result in a logical <kbd>Tab</kbd> order. Just to be sure, always test the order of keyboard-driven focus.

Measuring tab-order is nice, but it doesn't go far enough. Users of [switch access](https://en.wikipedia.org/wiki/Switch_access) controls find it slow and frustrating to navigate long lists of focusable items. Screen readers make it difficult to consume poorly-organized content non-linearly. The list goes on: nearly every reader reliant upon assistive technologies struggles to skim through poorly-organized pages.

Related items need to be semantically grouped together. Group navigation links together in `<nav>` elements; sections under headings, `<section>` elements, or other landmarks; lists under `<ol>`, `<ul>`, or `<dl>`; etc. to give assistive technologies the means to skip over multiple items at once.

### Line length

The WCAG recommends a max line length of 80 characters (40 characters for <abbr title="Chinese, Japanese, and Korean">CJK</abbr> languages) as a AAA guideline in [Success Criterion 1.4.8 Visual Presentation](https://www.w3.org/TR/WCAG22/#visual-presentation). However, studies seem to have mixed results; some people find it easier to read lines around 90 characters long, while others struggle beyond the 50-character mark. I think the WCAG over-simplified a complex issue. Then again, the AAA level was never intended to be a requirement.

Some of my links display long link-text; short line lengths can break these link texts too much, which can slightly hurt readability. Of course, narrow viewports will obviously make short line lengths non-negotiable. I decided to give article bodies a width of `38em`, which typically corresponds to just under 90 characters. I opted to use `em` instead of `ch` for consistency and for better compatibility with some uncommon browsers (NetSurf, Dillo, and others).

I also ensured that my site works very well with CSS overrides, window-resizing, zoom levels past 200%, and most "reading mode" implementations. This should help accommodate a wide range of line-length preferences while still looking accessible enough by default.

When setting max line lengths, use a CSS media query to ensure that printed versions of a page use the full page width. This should save some paper.

<figure>
<figcaption>
I opted to wrap all max-width rules in a media query to ensure that they only get called for the `screen` media type:
</figcaption>

```
@media screen {
  html {
    max-width: 45em;
    padding: 0 3%;
  }

  .e-content {
    margin: auto;
    max-width: 38em;
  }
}
```

</figure>

Narrow viewports
----------------

A single element wider than the viewport will trigger horizontal scrolling for the entire page. This is especially problematic for long pages that already require excessive vertical scrolling.

Not every phone has a giant screen: millions of people around the world use Web-enabled feature phones. The Jio Phone&nbsp;2, for instance, is narrow enough to fall through a belt loop: it sports a screen that's just over 3.6&nbsp;cm (1.44&nbsp;inches) wide. Furthermore, some programs sport browser windows in sidebars (c.f. Mozilla's [side view](https://addons.mozilla.org/en-US/firefox/addon/side-view/), Vivaldi [Web Panels](https://help.vivaldi.com/desktop/panels/web-panels/)). Users who leverage floating or tiling windows rather than maximizing everything could use viewports of arbitrary dimensions.

Long words, especially in headings, can trigger horizontal overflow. Test in a viewport that's under 240 pixels wide (<abbr title="Device Pixel Ratio">DPR</abbr>=1) and observe any words that trail off of the edge of the screen. Add soft hyphens to these words using the `&shy;` entity.

Most modern browsers support the `hyphens` CSS3 property, but full automatic hyphenation is usually an overkill solution with a naive implemen&shy;tation. Automatic hyphenation will insert hyphens wherever it can, not necessarily between the best syllables. At the time of writing, humans are still better at hyphenating than most software implemen&shy;tations. I'm also not aware of a CSS property that only breaks syllables when necessary to avoid horizontal scrolling.

Users employing machine translation will not benefit from your soft hyphens, so don't expect them to always work as intended. Translation tools might also replace short words with long ones. Soft hyphens and automatic hyphenation are both flawed solutions, but I find soft hyphens to be less problematic.

Where long inline `<code>` elements can trigger horizontal scrolling, consider a scrollable `<pre>` element instead. Making a single element horizontally scrollable is far better than making the entire page scrollable in two dimensions.

### Indented elements

Most browser default stylesheets were not optimized for narrow viewports, so narrow-viewport optimization is one of few good reasons to override the defaults. The best example of widescreen bias in browser stylesheets is indentation.

The HTML standard's section 4.4.4 [covers blockquotes](https://html.spec.whatwg.org/multipage/grouping-content.html#the-blockquote-element). It recommends placing a `<blockquote>` element inside a `<figure>` and citations in a `<figcaption>` to show a semantic relationship between a quotation and its citation.

Browser default stylesheets typically give `<figure>` elements extra margins on the left and right. `<blockquote>` elements have a large indent. Combining these two properties gives the final quotation an excessive visual indent, wasting precious vertical screen space. When such a blockquote contains `<ol>` or `<ul>` elements, the indentation alone may fill most of a narrow viewport!

I chose to remove the margins in `<figure>` elements. I don't find the margins useful because I typically use them to annotate non-centered non-phrasing content, such as `<blockquote>` and `<pre>` elements, and my image-based figures tend to have longer captions. If you're reading this page with its own stylesheet enabled, in a CSS&nbsp;2 compliant browser, you might have noticed the blockquotes on it are formatted with a minimal indent and a thick gray border on the left rather than a full indent. These two adjustments allow blockquotes containing bulleted lists to fit on most narrow viewports, even when wrapped by a `<figure>` element.

### When indentation helps

Excessive indentation can make reading difficult for narrow viewports, but preserving some indentation is still useful.

For now, I've decided to keep the indents on list elements such as `<ol>` and `<ul>`, since I often fill them with links (see this article's [table of contents](#toc) for an example). This indentation provides important negative space. Readers with hand tremors [depend on this space](https://axesslab.com/hand-tremors/) to scroll without accidentally selecting an interactive element.

On lists without visible bullets, I dropped the default indentation. I had to find other ways to ensure adequate space between links. Some examples:

- The [webmention list](#webmentions) below this article separates links with timestamps and some paragraph spacing.
- The [homepage posts list](https://seirdy.one/#posts) and the list of related articles at the top of [one of my posts](https://seirdy.one/2022/02/02/floss-security.html) separates links with descriptions

Once again, deviating from defaults created additional work to remove an accessibility hazard.

Tor
---

Many people use Tor out of necessity. On Tor, additional constraints apply.

For one, Tor users are encouraged to set the Tor Browser Bundle's (<abbr title="Tor Browser Bundle">TBB</abbr>) [security settings](https://tb-manual.torproject.org/en-US/security-settings/) to "safest". This disables scripts, MathML, some fonts, SVG images, and [other features](https://gitweb.torproject.org/torbutton.git/tree/modules/security-prefs.js). If your site has any SVG images, the Tor browser will download these just like Firefox would (to avoid fingerprinting) but will not render them.

Additionally, hopping between nodes in Tor circuits incurs latency, worsening the impacts of requiring multiple requests and round-trips. Try to minimise the number of requests to view a page.

If you use a CDN or some over&shy;complicated website security stack, make sure it doesn't block Tor users or require them to enable JavaScript to complete a CAPTCHA. Tor Browser users are supposed to avoid fingerprinting vectors like JS and browser extensions, so requiring a JavaScript-based CAPTCHA will effectively block many Tor users.

Tor users are unable to leverage media queries or client-hints to signal special needs. Pages need to be as accessible as possible *by default*. This should be a given, but it's doubly important when serving fingerprinting-averse readers.

### Hidden services

To go above and beyond, try mirroring your site to a Tor hidden service to reduce the need for exit nodes. Mirroring allows you to keep a separate version of your site optimized for the Tor browser.

Normally, optimizing specifically for a given user agent's quirks (especially in a separate version of a website) is a bad practice; however, the Tor Browser is a special case because there's no alternative available: Tor users should all use the same browser to avoid standing out. On top of that, the Tor Browser sometimes pretends to have Firefox's capabilities: progressive enhancement and graceful degradation won't work when a browser lies about its functionality.

For example, my website's clearnet version uses some SVG images. Some browsers can't handle a given image format. The typical solution is to use a `<picture>` element containing `<source>` children with varying formats and a fallback `<img>` element using a legacy image format.

The Tor browser will download whichever format Firefox would, rather than whichever formats it actually supports. A `<picture>` element containing an SVG and a raster fallback won't help: the Tor browser will avoid fingerprinting by selecting the SVG format, not a fallback format. The image will not be rendered, so users will have downloaded the image only to see a white box.

I address the issue by not using any SVG images on [my hidden service](http://wgq3bd2kqoybhstp77i3wrzbfnsyd27wt34psaja4grqiezqircorkyd.onion/).

Optimal loading
---------------

Nearly every Internet user has to deal with unreliable connections every now and then, even the top 1%. Optimal loading matters most in these situations. Broadly, it covers three categories: reducing payload size, delivering content early, and reducing the number of round trips.

### Blocking resources

HTML is a blocking resource: images and stylesheets will not load until the user agent loads and parses the HTML that calls them. To start loading above-the-fold images before the HTML parsing finishes, send a `link` HTTP header.

<figure>
<figcaption>

My website includes a `link` header to load an SVG that serves as my IndieWeb photo and favicon:

</figcaption>

```
link: </favicon.072dbf7bc4323646b9ee96243fbd71b2.svg>; rel=preload; as=image
```

</figure>

Reducing load time is especially useful for users with unreliable connections. For much of the world, connectivity comes in short bursts during which loading time is precious. Chances of a connection failure or packet loss increase with time.

### Inline content

In addition to HTML, CSS is also a blocking resource. You could pre-load your CSS using a `link` header. Alternatively: if your CSS is under a kilobyte, consider inlining it in the `<head>` using a `<style>` element. Simply inlining stylesheets can pose a security threat, but the `style-src` <abbr title="Content Security Policy">CSP</abbr> directive can mitigate this if you include a hash of your inline stylesheet sans trailing whitespace.

You can do the same with images by using a `data:` URI; my 32-pixel PNG site icon is under 200 bytes and inlines quite nicely. On this site's hidden service, it's often the only image on a page (recall that the hidden service replaces SVGs with PNGs). Inlining this image and the stylesheet allows my hidden service's homepage to load in a single request, which is a welcome improvement given the round-trip latency that plagues onion routing implemen&shy;tations.

### Layout shifts

Loading content with unknown dimensions, such as images, can create layout shifts; the <abbr title="Web Incubator Community Group">WICG</abbr>'s <cite>[Layout Instability API](https://wicg.github.io/layout-instability/#sec-intro)</cite> describes the phenomenon in detail. Avoid layout shifts by including dimensions in HTML attributes. The simplest way to do so is by including `width` and `height` values, but the `style` attribute could work too. I recommend staying away from the `style` attribute, or at least selectively allowing its use with the `style-src-attr` CSP directive.

### Other server-side tweaks

In-depth server configuration is a bit out of scope, so I'll keep each improvement brief.

Compression--especially static compression--dramatically reduces download sizes. My full-text RSS feed is about a quarter of a megabyte, but the Brotli-compressed version is around 70 kilobytes. Caddy supports this with a `precompressed` directive; Nginx requires a [separate module](https://github.com/google/ngx_brotli) for Brotli compression.

When serving many resources at once (e.g., if a page has many images), HTTP/2 could offer a speed boost through multiplexing. HTTP/3 is unlikely to help textual websites much, so run a benchmark to see if it's worthwhile.

Consider caching static assets indefinitely with a year-long duration in the "cache-control" header, possibly with an "immutable" parameter. If you have to update a static asset, cache-bust it by altering the URL. This approach should eliminate the need for an "etag" header on static assets.

Using [OCSP stapling](https://en.wikipedia.org/wiki/OCSP_stapling) eliminates the need to connect to a certificate authority, saving users a DNS lookup and allowing them to instead re-use a connection.

Consider the trade-offs involved in enabling 0-<abbr title="Round-Trip Time">RTT</abbr> for TLS 1.3. On one hand, it shaves off a round-trip during session resumption; on the other hand, it can enable replay attacks. 0-RTT shouldn't be too unsafe for idempotent GET requests of static content. For dynamic content, evaluate whether your backend is vulnerable to replay attacks described in [appendix E.5](https://www.rfc-editor.org/rfc/rfc8446.html#appendix-E.5) of the spec.

Non-Browsers: Reading mode
--------------------------

Fully standards-compliant browsers aren't the only programs people use. They also use "reading mode" tools and services.

Reading modes leverage article extractors such as [Readability.js](https://github.com/mozilla/readability) (integrated into Firefox, Epiphany, Brave, Vivaldi, and others), [DOM Distiller](https://chromium.googlesource.com/chromium/dom-distiller/) (integrated into Chromium), and [Trafilatura](https://trafilatura.readthedocs.io/en/latest/) (powers a variety of tools and services). A host of other proprietary options exist: Diffbot powers services like Instapaper, Mozilla's Pocket has its own secret parsers, and countless "send to e-reader" services have amassed loyal users. Safari's proprietary fork of Readability has grown quite complex compared to upstream; Edge's Immersive Reader is [a mystery to me](https://techcommunity.microsoft.com/t5/discussions/documentation-on-huerestics-used-during-article-distillation-in/m-p/3266436).

I don't recommend catering to each tool's non-standard quirks. Studying their design reveals that they observe open standards, to varying degrees. Readability, DOM Distiller, and Trafilatura understand plain-old, semantic HTML (<abbr title="Plain-Old, Semantic HTML">POSH</abbr>).

POSH should be enough for most use-cases, but some authors want to go further. For example, they may want a byline or published date to show up in these modes.

Most extractors fetch these values using open standards for structured data. The most well-supported option is [microformats](https://microformats.org/wiki/microformats) (Readability is one of the few that supports the newer microformats2). Some support [schema.org](https://schema.org/) vocabularies in Microdata or JSON-LD syntaxes, or [Dublin Core](https://www.dublincore.org/) vocabularies in RDFa. Most parse `<meta>` tags from the document `<head>`, but others don't due to misuse and overly aggressive <abbr title="Search Engine Optimization">SEO</abbr>.

Sorry, that was a lot of jargon for a single paragraph. Unfortunately, describing those terms is out of scope for this post. If you'd like to dive down this rabbit hole, read about the "Semantic Web".

Again: avoid catering to non-standard implemen&shy;tations' quirks, especially undocumented proprietary ones. Let's not repeat the history of the [browser wars](https://en.wikipedia.org/wiki/Browser_wars). More information about standard and non-standard behavior of reading modes is in the article <cite>[Web Reading Mode: The non-standard rendering mode](https://www.ctrl.blog/entry/browser-reading-mode-parsers.html)</cite> by {{<indieweb-person first-name="Daniel" last-name="Aleksandersen" url="https://www.daniel.priv.no/">}}.

Reading modes aren't the only non-browser user agents out there. Plain-text feed readers and link previewers are some other options. I singled out reading modes because of their widespread adoption and value. Decide which other kinds of agents are important to you (if any), and see if they expose a hole in your semantics.

Machine trans&shy;lation
------------------------

Believe it or not, the entire world doesn't speak your website's languages. Browsers like Chromium, Microsoft Edge, and Safari have integrated machine translation to translate entire pages. Users can also leverage online website translators such as Google Translate or Bing. These "webpage translators" are far more complex than their plain-text predecessors.

Almost every word on your site can be re-written. Prepare for headings to change length, paragraphs to grow and shrink, or hyphenation to disappear. Your site's layout should make sense even when the length of each textual element is changed.

Incorrect spelling and poor grammar in an original work can reduce the accuracy of a machine-translated derivative. Be sure to proofread.

### POSH helps translation engines

To ensure that pages get machine-translated properly, make proper use of semantic HTML. Daniel wrote about this topic too in <cite>[Semantic markup improves the quality of machine-translated texts](https://www.ctrl.blog/entry/html-semantic-improve-machine-translation.html)</cite>; I highly encourage giving his article a read.

Elements to pay close attention to include `<code>`, `<samp>`, `<var>`, `<kbd>`, `<abbr>`, and `<address>`. The semantic information conveyed by these elements supplies important context to translation algorithms.

Only after <abbr title="Plain-Old, Semantic HTML">POSH</abbr> is insufficient should you attempt to "override" behavior with the `translate` HTML attribute. Setting `translate="no"` or `translate="yes"` should override the behavior of standards-compliant translation engines. If you're unsure whether or not to use a `translate` attribute, search the relevant word or phrase on [Keybot](https://www.keybot.com/) to see how human translators approached it.

For example: machine translation will leave `<code>` and `<samp>` blocks as-is. Perhaps you could annotate comments within code with a `translate="yes"` attribute. However, translation engines should leave variables within those comments as-is.

[Google's style guide](https://developers.google.com/style/placeholders) recommends annotating format placeholders in code blocks with the `<var>` element; consider doing so and adding a `translate="yes"` attribute to placeholder values, at your discretion. For an example, check this article's code sample [describing my PNG optimization pipeline](#png-pipeline).

### Changing text direction

Consider the implications of translating between left-to-right (LTR) and right-to-left (RTL) languages. Do a search through your stylesheets for keywords like "left" and "right" to ensure that styles don't depend too heavily on text direction. Once you've cleared the low-hanging fruit, try translating the page to a language like Arabic.

Websites following this page's layout advice shouldn't need much adjustment. {{<indieweb-person first-name="Ahmed" last-name="Shadeed" url="https://ishadeed.com/">}}'s <cite>[RTL Styling 101](https://rtlstyling.com/posts/rtl-styling/)</cite> is a comprehensive guide to what can go wrong and how to fix issues.

In defense of link under&shy;lines
----------------------------------

Some typographers insist that [underlined on-screen text is obsolete](https://practicaltypography.com/underlining.html), and hyperlinks are no exception. I disagree.

One reason is that underlines make it easy to separate multiple consecutive inline links:

{{< picture name="underlines" alt="two lines with two consecutive hyperlinks each, one line with and one without underlines." >}}

Underlines also make it easy for readers with color vision deficiencies to distinguish the beginnings and ends of links from surrounding text. A basic WCAG Level A requirement is for information to not be conveyed solely through color:

<figure itemscope itemtype="https://schema.org/Quotation">
	<blockquote>
		<p>Color is not used as the only visual means of conveying information, indicating an action, prompting a response, or disting&shy;uishing a visual element. (Level A)</p>
	</blockquote>
	<figcaption class="h-cite" itemprop="citation">
		&mdash; <cite itemprop="isPartOf" itemscope itemtype="https://schema.org/CreativeWork"><a class="u-url p-name" itemprop="url" href="https://www.w3.org/TR/WCAG22/"><span itemprop="name">WCAG&nbsp;2.2</span></a></cite>, <a href="https://www.w3.org/TR/WCAG22/#distinguishable">section 1.4.1</a>
	</figcaption>
</figure>

Readers already expect underlined text to signify a hyperlink. Don't break fundamental affordances for aesthetics.

Testing
-------

If your site is simple enough, it should automatically handle the vast majority of edge-cases. Different devices and browsers all have their quirks, but they generally have one thing in common: they understand <abbr title="Plain-Old, Semantic HTML">POSH</abbr>.

In addition to standard testing, I recommend testing with unorthodox setups that are unlikely to be found in the wild. If a website doesn't look good in one of these tests, there's a good chance that it uses an advanced Web feature that can serve as a point of failure in other cases. Simple sites should be able to look good in a variety of situations out of the box.

Your page should easily pass the harshest of tests without any extra effort if its HTML meets basic standards for well-written code (overlooking bad formatting and a lack of comments). Even if you use a complex static site generator, the final HTML should be simple, readable, and semantic.

### Sample unorthodox tests

These tests start out pretty reasonable, but gradually get more ridiculous. Once again, use your judgement.

1. Evaluate the heaviness and complexity of your scripts (if any) by testing with your browser's <abbr title="just-in-time">JIT</abbr> compilation disabled.[^4]
2. Test using the Tor browser with the safest security level enabled (disables JS and other features).
3. Load just the HTML. No CSS, no images, etc. Try loading without inline CSS as well for good measure.
4. Print out the site in black-and-white, preferably with a simple laser printer.
5. Test with accessibility aids such as screen readers, magnifiers, and switch controls.
6. Ensure the page responds correctly to browser zoom. No sizes or dimensions should remain "fixed" across zoom levels.
7. Test keyboard navigability with the tab key and with [caret navigation](https://en.wikipedia.org/wiki/Caret_navigation). Even without specifying tab indexes, tab selection should follow a logical order if you keep the layout simple.
8. Test in textual browsers: lynx, links, w3m, ELinks, edbrowse, EWW, Netrik, etc.
9. Test in an online website translator tool.
10. Read the (prettified/indented) HTML source itself and parse it with your brain. See if anything seems illogical or unnecessary. Imagine giving someone a printout of your page's <body> along with a whiteboard. If they have a basic knowledge of HTML tags, would they be able to draw something resembling your website?
11. Test on something ridiculous: try your old e-reader's embedded browser, combine an HTML-to-EPUB converter and an EPUB-to-PDF converter, or stack multiple article-extraction utilities on top of each other. Be creative and enjoy breaking your site. When something breaks, examine the breakage and see if you can fix it by simplifying your page.
12. Build a time machine. Travel decades--or perhaps centuries--into the future. Keep going forward until the WWW is breathing its last breath. Test your site on future browsers. Figuring out how to transfer your files onto their computers might take some time, but you have a time machine so that shouldn't be too hard. When you finish, go back in time to [meet Benjamin Franklin](https://xkcd.com/567/).

I'm still on step 11, trying to find new ways to break this page. If you come up with a new test, please [share it](mailto:~seirdy/seirdy.one-comments@lists.sr.ht).

Future updates
--------------

This article is, and will probably always be, an ongoing work-in-progress. Some areas I have yet to cover:

* How purely-cosmetic animations harm users with cognitive disabilities (e.g. attention disorders).
* Best practices for combining alt-text, figure captions, and image transcripts.
* How exposing new content on hover is inaccessible to users with magnifiers, hand tremors, switch access, and touchscreens.
* Notes on improving support for braille displays.
* How to work well with caret-based navigation.
* Ways to keep tap targets large. The WCAG recommends tap targets at least 44 pixels tall and wide, large enough to easily tap on a touchscreen. Google recommends raising that to 48 pixels, going so far as to make tap target size a ranking factor in search.
* How to phrase sentences such that some meaning can be inferred without understanding numbers, for readers with dyscalculia.
* Keypad-based navigation on feature phones (c.f. KaiOS devices).
* Ways to improve comprehension by readers who struggle to understand non-literal language (cognitive disabilities, non-native speakers unfamiliar with idioms, etc.). I might wait until the W3C <cite>[Personalization Help and Support 1.0](https://w3c.github.io/personalization-semantics/help/index.html)</cite> draft specification matures and its vocabularies gain adoption before going in depth.

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
		<li>Perform&shy;ance is a feature.</li>
		</ul>
	</blockquote>
	<figcaption class="h-cite" itemprop="citation">
		&mdash; {{<indieweb-person first-name="David" last-name="Copeland" url="https://naildrivin5.com/">}}, <cite itemprop="isPartOf" itemscope itemtype="https://schema.org/CreativeWork"><a class="u-url p-name" itemprop="url" href="https://brutalist-web.design/"><span itemprop="name">Brutalist Web Design</span></a></cite>
	</figcaption>
</figure>

The [250kb club](https://250kb.club/) gathers websites at or under 250kb, and also rewards websites that have a high ratio of content size to total size.

The [10KB Club](https://10kbclub.com/) does the same with a 10kb homepage budget (excluding favicons and webmanifest icons). It also has guidelines for note&shy;worthiness, to avoid low-hanging fruit like mostly-blank pages.

My favorite website club has to be the [<abbr title="eXtreme HyperText Movement for Luddites">XHTML</abbr> Club](https://xhtml.club/) by {{<indieweb-person first-name="Bradley" last-name="Taunt" url="https://tdarb.org">}}, the creator of the original [1mb.club](https://1mb.club).

Also see [Motherfucking Website](https://motherfuckingwebsite.com/). Motherfucking Website inspired several unofficial sequels that tried to gently improve upon it. My favorite is [Best Motherfucking Website](https://bestmotherfucking.website/).

The [WebBS calculator](https://www.webbloatscore.com/) compares a page's size with the size of a PNG screenshot of the full page content, encouraging site owners to minimize the ratio of the two.

One resource I found useful (that eventually featured this article!) was the "Your page content" section of {{<indieweb-person first-name="Bill" last-name="Dietrich" url="https://www.billdietrich.me">}}'s comprehensive guide to [setting up your personal website](https://www.billdietrich.me/YourPersonalWebSite.html#PageContent).

If you've got some time on your hands, I _highly_ recommend reading the <cite>[Web Content Accessibility Guidelines (WCAG)&nbsp;2.2](https://www.w3.org/TR/WCAG22/)</cite>. The WCAG 2 standard is technology-neutral, so it doesn't contain Web-specific advice. For that, check the <cite>[How to Meet WCAG (Quick Reference)](https://www.w3.org/WAI/WCAG22/quickref)</cite>. It combines the WCAG with its supplementary [list of techniques](https://www.w3.org/WAI/WCAG22/Techniques/).

The WCAG are an excellent starting point for learning about accessibility, but make for a poor stopping point. One of my favorite resources for learning about what the WCAG _doesn't_ cover is [Axess Lab](https://axesslab.com/articles/).


[^1]: Many addons function by injecting content into pages; this significantly weakens many aspects of the browser security model (e.g. site and origin isolation) and should be avoided if at all possible. On sensitive pages with content such as public key fingerprints, I recommend setting a blank `sandbox` directive even if it means breaking these addons.

[^2]: Some addons will have reduced functionality; for instance, [Tridactyl](https://github.com/tridactyl/tridactyl) can't create an `<iframe>` for its command window. I consider this to be worthwhile since the most important functionality is still available, and because authors shouldn't feel compelled to support security weakening. I say this as someone who uses Tridactyl often.

[^3]: Here's an [overview of PE](https://en.wikipedia.org/wiki/Progressive_enhancement) and [my favorite write-up on the subject](https://whalecoiner.com/articles/progressive-enhancement).

[^4]: Consider disabling the JIT for your normal browsing too; doing so removes whole classes of vulnera&shy;bilities. In Firefox, navigate to `about:config` and toggle these options:<pre><code>javascript.options.ion<br>javascript.options.baselinejit<br>javascript.options.native_regexp<br>javascript.options.asmjs<br>javascript.options.wasm</code></pre>In Chromium and derivatives, run the browser with `--js-flags='--jitless'`; in the Tor Browser, set the security level to "Safer".



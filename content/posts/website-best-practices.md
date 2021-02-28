---
date: "2020-11-23T12:21:35-08:00"
description: A lengthy guide to making small sites that focus on content rather than
    form.
outputs:
  - html
  - gemtext
tags:
  - web
  - rant
  - minimalism
title: An opinionated list of best practices for textual websites
---
_The following applies to minimal websites that focus primarily on text. It does not apply to websites that have a lot of non-textual content. It also does not apply to websites that focus more on generating revenue or pleasing investors than being good websites._

This is a "living document" that I add to as I receive feedback. See the [changelog](https://git.sr.ht/~seirdy/seirdy.one/log/master/item/content/posts/website-best-practices.md).

I realize not everybody's going to ditch the Web and switch to Gemini or Gopher today (that'll take, like, a month at the longest). Until that happens, here's a non-exhaustive, highly-opinionated list of best practices for websites that focus primarily on text:

- Final page weight under 50kb without images, and under 200kb with images. Page weight should usually be much smaller; these are upper-bounds for exceptional cases.
- Works in Lynx, w3m, links (both graphics and text mode), Netsurf, and Dillo
- Works with popular article-extractors (e.g. Readability) and HTML-to-Markdown converters. This is a good way to verify that your site uses simple HTML and works with most non-browser article readers (e.g. ebook converters, PDF exports).
- No scripts or interactivity (preferably enforced at the CSP level)
- No cookies
- No animations
- No fonts--local or remote--besides `sans-serif` and `monospace`. More on this below.
- No referrers
- No requests after the page finishes loading
- No 3rd-party resources (preferably enforced at the CSP level)
- No lazy loading (more on this below)
- No custom colors OR explicitly set the both foreground and background colors. More on this below.
- A maximum line length for readability
- Server configured to support compression (gzip, optionally Brotli and zstd as well). It's a free speed boost.
- Supports dark mode via a CSS media feature and/or works with most "dark mode" browser addons. More on this below.
- A good score on Mozilla's [HTTP Observatory](https://observatory.mozilla.org/). A bare minimum would be 50, but it shouldn't be too hard to hit 100.
- Optimized images. More on image optimization below.
- All images labeled with alt-text. The page should make sense without images.
- Maybe HTTP/2. There are some cases in which HTTP/2 can make things slower. Run some tests to find out.

I'd like to re-iterate yet another time that this only applies to websites that primarily focus on text. If graphics, interactivity, etc. are an important part of your website, less (possibly none) of this article applies.

Earlier revisions of this post generated some responses I thought I should address below. Special thanks to the IRC and [Lobsters](https://lobste.rs/s/akcw1m) users who gave good feedback!

About fonts
-----------

If you really want, you could use serif instead of sans-serif; however, serif fonts tend to look worse on low-res monitors. Not every screen's DPI has three digits.

To ship custom fonts is to assert that branding is more important than user choice. That might very well be a reasonable thing to do; branding isn't evil! It isn't _usually_ the case for textual websites, though. Beyond basic layout and optionally supporting dark mode, authors generally shouldn't dictate the presentation of their websites; that should be the job of the user agent. Most websites are not important enough to look completely different from the rest of the user's system.

A personal example: I set my preferred fonts in my computer's fontconfig settings. Now every website that uses sans-serif will have my preferred font. Sites with sans-serif blend into the users' systems instead of sticking out.

### But most users don't change their fonts...

The "users don't know better and need us to make decisions for them" mindset isn't without merits; however, in my opinion, it's overused. Using system fonts doesn't make your website harder to use, but it does make it smaller and stick out less to the subset of users who care enough about fonts to change them. This argument isn't about making software easier for non-technical users; it's about branding by asserting a personal preference.

### Can't users globally override stylesheets instead?

It's not a good idea to require users to automatically override website stylesheets. Doing so would break websites that use fonts such as Font Awesome to display vector icons. We shouldn't have these users constantly battle with websites the same way that many adblocking/script-blocking users (myself included) already do when there's a better option.

That being said, many users _do_ actually override stylesheets. We shouldn't _require_ them to do so, but we should keep our pages from breaking in case they do. Pages following this article's advice will probably work perfectly well in these cases without any extra effort.

### But wouldn't that allow a website to fingerprint with fonts?

I don't know much about fingerprinting, except that you can't do font enumeration without JavaScript. Since text-based websites that follow these best-practices don't send requests after the page loads and have no scripts, fingerprinting via font enumeration is a non-issue on those sites.

Other websites can still fingerprint via font enumeration using JavaScript. They don't need to stop at seeing what sans-serif maps to; they can see all the available fonts on a user's system, the user's canvas fingerprint, window dimensions, etc. Some of these can be mitigated with Firefox's `privacy.resistFingerprinting` setting, but that setting also understandably overrides user font preferences.

Ultimately, surveillance self-defense on the web is an arms race full of trade-offs. If you want both privacy and customizability, the web is not the place to look; try Gemini or Gopher instead.

About lazy loading
------------------

For users on slow connections, lazy loading is often frustrating. I think I can speak for some of these users: mobile data near my home has a number of "dead zones" with abysmal download speeds, and my home's Wi-Fi repeater setup occasionally results in packet loss rates above 60% (!!).

Users on poor connections have better things to do than idly wait for pages to load. They might open multiple links in background tabs to wait for them all to load at once, or switch to another window/app and come back when loading finishes. They might also open links while on a good connection before switching to a poor connection. For example, I often open 10-20 links on Wi-Fi before going out for a walk in a mobile-data dead-zone. A Reddit user reading an earlier version of this article described a [similar experience](https://i.reddit.com/r/web_design/comments/k0dmpj/an_opinionated_list_of_best_practices_for_textual/gdmxy4u/) riding the train.

Unfortunately, pages with lazy loading don't finish loading off-screen images in the background. To load this content ahead of time, users need to switch to the loading page and slowly scroll to the bottom to ensure that all the important content appears on-screen and starts loading. Website owners shouldn't expect users to have to jump through these ridiculous hoops.

### Wouldn't this be solved by combining lazy loading with pre-loading/pre-fetching?

A large number of users with poor connections also have capped data, and would prefer that pages don't decide to predictively load many pages ahead-of-time for them. Some go so far as to disable this behavior to avoid data overages. Savvy privacy-conscious users also generally disable pre-loading since linked content may employ dark patterns like tracking without consent.

Users who click a link _choose_ to load a full page. Loading pages that a user hasn't clicked on is making a choice for that user.

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

If you do explicitly set colors, please also include a dark theme using a media query: `@media (prefers-color-scheme: dark)`. For more info, read the relevant docs [on MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-color-scheme)

Image optimization
------------------

Some image optimization tools I use:

- [`pngquant`](http://pngquant.org) (lossy)
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

It might seem odd to create a lossless WebP from a lossy PNG, but I've found that it's often the best way to get the smallest possible image at the minimum acceptable quality for screenshots with solid backgrounds.

In general, avoid using inline images just for decoration. Only use an image if it significantly adds to your content, and provide alt-text as a fallback.

If you want to include a profile photo (e.g., if your website is part of the IndieWeb), I recommend re-using one of your favicons. Since most browsers will fetch your favicons anyway, re-using them should be relatively harmless.

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

### What about sidebars?

Sidebars are probably unnecessary, and can be quite annoying to readers who re-size windows frequently. This is especially true for tiling window manager users like me: we frequently shrink windows to a fraction of their original size. When this happens on a website with a sidebar, one of two things happens:

1. The site's responsive design kicks in: the sidebar vanishes and its elements move elsewhere. This can be quite CPU-heavy, as the browser has to both re-wrap the text _and_ handle a complex layout change. Frequent window re-sizers will experience lag and battery loss, and might need a moment to figure out where everything went.
2. The site doesn't use responsive design. The navbar and main content are now squeezed together. Readers will probably close the page.

Neither situation looks great.

### Sidebar alternatives

Common items in sidebars include article tags, an author bio, and an index of entries; these aren't useful while reading an article. Consider putting them in the article footer or--even better--dedicated pages. This does mean that readers will have to navigate to a different page to see that content, but they probably prefer things that way; almost nobody who clicked on "An opinionated list of best practices for textual websites" did so because they wanted to read my bio.

Don't boost engagement by providing readers with information they didn't ask for; earn engagement with good content, and let readers navigate to your other pages _after_ they've decided they want to read more.

Testing
-------

If your site is simple enough, it should automatically handle the vast majority of edge-cases. Different devices and browsers all have their quirks, but they generally have one thing in common: they understand semantic, backward-compatible HTML.

In addition to standard testing, I recommend testing with unorthodox setups that are unlikely to be found in the wild. If a website doesn't look good in one of these tests, there's a good chance that it uses an advanced Web feature that can serve as a point of failure in other cases. Simple sites should be able to look good in a variety of situations out of the box.

Your page should easily pass the harshest of tests without any extra effort if its HTML meets basic standards for well-written code (overlooking bad formatting and a lack of comments). Even if you use a complex static site generator, the final HTML should be simple, readable, and semantic.

### Sample unorthodox tests

These tests start out pretty reasonable, but gradually get more insane as you go down. Once again, use your judgement.

1. Load just the HTML. No CSS, no images, etc. Try loading without inline CSS as well for good measure.
2. Print out the site in black-and-white, preferably with a simple laser printer.
3. Test with a screen reader.
4. Test keyboard navigability with the tab key. Even without specifying tab indices, tab selection should follow a logical order if you keep the layout simple.
5. Test in textual browsers: lynx, links, w3m, edbrowse, EWW, etc.
6. Read the (prettified/indented) HTML source itself and parse it with your brain. See if anything seems illogical or unnecessary. Imagine giving someone a printout of your page's `<body>` along with a whiteboard. If they have a basic knowledge of HTML tags, would they be able to draw something resembling your website?
7. Test in an online website translator tool.
8. Test on something ridiculous: try your old e-reader's embedded browser, combine an HTML-to-EPUB converter and an EPUB-to-PDF converter, or stack multiple article-extraction utilities on top of each other. Be creative and enjoy breaking your site. When something breaks, examine the breakage and see if you can fix it by simplifying your page.
9. Build a time machine. Travel decades--or perhaps centuries--into the future. Keep going forward until the WWW is breathing its last breath. Test your site on future browsers. Figuring out how to transfer your files onto their computers might take some time, but you have a time machine so that shouldn't be too hard. When you finish, go back in time to [meet Benjamin Franklin](https://xkcd.com/567/).

I'm still on step 7, trying to find new ways to break this page. If you come up with a new test, please [share it](mailto:~seirdy/seirdy.one-comments@lists.sr.ht).

Other places to check out
-------------------------

The [250kb club](https://250kb.club/) gathers websites at or under 250kb, and also rewards websites that have a high ratio of content size to total size.

The [10KB Club](https://10kbclub.com/) does the same with a 10kb homepage budget (excluding favicons and webmanifest icons). It also has guidelines for noteworthiness, to avoid low-hanging fruit like mostly-blank pages.

Also see [Motherfucking Website](https://motherfuckingwebsite.com/). Motherfucking Website inspired several unofficial sequels that tried to gently improve upon it. My favorite is [Best Motherfucking Website](https://bestmotherfucking.website/).

The [WebBS calculator](https://www.webbloatscore.com/) compares a page's size with the size of a PNG screenshot of the full page content, encouraging site owners to minimize the ratio of the two.


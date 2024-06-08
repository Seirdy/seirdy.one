---
date: "2024-04-19T04:08:01-04:00"
title: "Classic web badges"
outputs:
    - html
description: "My curation of over 70 88x31 badges, representing what I and this site use and stand for."
image: "b/sticker_352x124.png"
---
My collection of over 70 88x31 badges, representing what I and this site use and stand for. If you have a badge you'd like me to add, just ask; it needs to have a format under 3&#160;kb and avoid excessively flashy animations for me to consider it. [See some tools I use for image optimization]({{<relref "/posts/website-best-practices.md#image-optimization">}}).

## My badge

Use this to link to me!

<a href="https://seirdy.one/">{{<picture name="b/sticker_88x31" alt="My favicon, a white colon and semicolon on a black backround, next to the word “Seirdy”." width="176" height="62" class="pix">}}</a>

Note that this image's URL is cache-busted. It will change any time I alter my badge, and is **not** hotlink-friendly. If you wish to hotlink, use one of these URLs:

- `https://seirdy.one/sticker_88x31.png`
- `https://seirdy.one/sticker_88x31.gif`

{{<codefigure>}}{{<codecaption lang="HTML">}}

Template markup to embed my 88x31 badge.

{{</codecaption>}}

```figure
<a href="https://seirdy.one/">
  <img width="88" height="31"
       src="https://seirdy.one/p/b/sticker_88x31.png"
       alt="Square icon of a colon and semicolon, next to the word “Seirdy”."/>
</a>
```

{{</codefigure>}}

### Suggestions for embedding my badge

- Use `image-rendering: pixelated;` in your CSS for most 88x31 badges, so upscaling filters don't ruin pixel art.

- Double the width and height in your HTML to `width="176" height="62"` to make them easier to read on higher-resolution screens.

- The more consecutive badges you have, the shorter your alt-text should be. Balance the need for detail against the need to skim.

- If you want to detect my button programmatically, consider the [`.well-known/button.json` schema](https://codeberg.org/LunarEclipse/well-known-button).

## About this site

### Site design standards

Read more about the design of this site in my [site design standards page]({{<relref "/meta/site-design.md">}}).

<a href="https://anybrowser.org/campaign/">{{<picture name="b/any_browser" alt="The text “any browser you like.” next to a light prism." width="176" height="62" class="pix">}}</a>
<a href="https://dd-b.net/lynx-enhanced.html">{{<picture name="b/lynx_enh" alt="Lynx Enhanced." width="176" height="62" class="pix">}}</a>
<a href="https://web.archive.org/web/20230607005614/http://www.ermel.org/handcoded/">{{<picture name="b/handcoded" alt="100% hand-coded HTML." width="176" height="62" class="pix">}}</a>
{{<picture name="b/cookie_free" alt="This site is certified 100% cookie free!" width="176" height="62" class="pix">}}
{{<picture name="b/javascript-zero" alt="Proudly zero JavaScript!" width="176" height="62" class="pix">}}
{{<picture name="b/web11" alt="Web 1.1." width="176" height="62" class="pix">}}
{{<picture name="b/is_it_slow_say_so" alt="Is it slow? Say so!" width="176" height="62" class="pix">}}
{{<picture name="b/dark-mode" alt="Made for Dark Mode!" width="176" height="62" class="pix">}}
{{<picture name="b/mobilefriendly" alt="Mobile friendly." width="176" height="62" class="pix">}}
<a href="https://git.sr.ht/~seirdy/seirdy.one/tree/master/item/linter-configs/vnu_filter.jq">{{<picture name="b/html5" alt="W3C valid HTML5." width="176" height="62" class="pix">}}</a>
<a href="https://git.sr.ht/~seirdy/seirdy.one/tree/master/item/linter-configs/vnu_filter.jq">{{<picture name="b/valid-css" alt="W3C valid CSS." width="176" height="62" class="pix">}}</a>
<a href="https://validator.w3.org/feed/check.cgi?url=https%3A%2F%2Fseirdy.one%2Fatom.xml">{{<picture name="b/valid-atom" alt="Valid Atom feed." width="176" height="62" class="pix">}}</a>
<a href="https://validator.w3.org/feed/check.cgi?url=https%3A%2F%2Fseirdy.one%2Findex.xml">{{<picture name="b/valid-rss" alt="Valid RSS feed." width="176" height="62" class="pix">}}</a>
<a href="{{<relref "/meta/wcag-conformance.md">}}">{{<picture name="b/wcag22" alt="W3C WAI-AA WCAG 2.2." width="176" height="62" class="pix">}}</a>
<a href="https://web.archive.org/web/20240507225939/https://humanstxt.org/">{{<picture name="b/humanstxt" alt="humans dot TXT" width="176" height="62" class="pix">}}</a>

### Software that seirdy.one runs on

<a href="https://fedoraproject.org/">{{<picture name="b/fedora" alt="Powered by Fedora™." width="176" height="62" class="pix">}}</a>
<a href="https://nginx.org/">{{<picture name="b/nginx" alt="Nginx powered." width="176" height="62" class="pix">}}</a>
<a href="https://llvm.org/">{{<picture name="b/llvm" alt="LLVM compiler infrastructure." width="176" height="62" class="pix">}}</a>
<a href="https://www.torproject.org/">{{<picture name="b/tor" alt="The Tor Project." width="176" height="62" class="pix">}}</a>
<a href="https://gohugo.io/">{{<picture name="b/hugo" alt="Logo for the Hugo static site generator." width="176" height="62" class="pix">}}</a>
<a href="https://www.w3.org/developers/tools/">{{<picture name="b/heartvalidator" alt="I heart validator." width="176" height="62" class="pix">}}</a>

### Other info about this site

<a href="https://www.mabsland.com/Adoption.html">{{<picture name="b/panda_14c" alt="Smug panda fursona next to the text “Web 14”." width="176" height="62" class="pix">}}</a>
<a href="https://tildeverse.org/">{{<picture name="b/tildeverse" alt="Tildeverse." width="176" height="62" class="pix">}}</a>
<a href="https://indieweb.org/Webmention">{{<picture name="b/webmentions" alt="Webmentions supported." width="176" height="62" class="pix">}}</a>
<a href="https://internet.nl/faqs/ipv6/">{{<picture name="b/ipv6" alt="The word “IPv6” next to a green checkmark." width="176" height="62" class="pix">}}</a>
<a href="https://creativecommons.org/licenses/by-sa/4.0/">{{<picture name="b/cc-by-sa" alt="Creative Commons BY-SA license." width="176" height="62" class="pix">}}</a>
<a href="https://www.gnu.org/licenses/agpl-3.0.en.html">{{<picture name="b/agplv3" alt="AGPL v3: Free Software. It stands for GNU Affero General Public Licence, version 3." width="176" height="62" class="pix">}}</a>

### Notes on "About this site" badges

The W3C Valid HTML5 badge isn't offered by the new Nu HTML Checker because [HTML5 is about conformance, not validity](https://html5doctor.com/html5-check-it-before-you-wreck-it-with-miketm-smith/). I use it anyways because my markup does fully conform _and_ is well-formed polygot XHTML5, despite false-positives from validators; [see my conformance statement]({{<relref "/meta/site-design.md#conformance">}}).

I build Nginx, Conduit, Webmentiond, and other software for seirdy.one using LLVM in a Chimera Linux container, due to LLVM's release-build-optimized sanitizers such as ControlFlowIntegrity.

## Ideological affinity, web-related

{{<picture name="b/anonymize" alt="Anonymize the web now!" width="176" height="62" class="pix">}}
<a href="https://justinjackson.ca/webmaster/">{{<picture name="b/fckingwww" alt="The dark green text “fucking webmaster” on a shell prompt in a terminal window." width="176" height="62" class="pix">}}</a>
<a href="https://www.w3.org/QA/Tips/iso-date">{{<picture name="b/iso" alt="ISO-8601 now! YYYY-MM-DD." width="176" height="62" class="pix">}}</a>
<a href="https://yesterweb.org/no-to-web3/">{{<picture name="b/keep" alt="Keep the Web free. Say no to Web3." width="176" height="62" class="pix">}}</a>
{{<picture name="b/nn" alt="I support Net Neutrality." width="176" height="62" class="pix">}}
{{<picture name="b/noblink" alt="No <blink> tags! 3.0." width="176" height="62" class="pix">}}
{{<picture name="b/frames-suck" alt="The text “Campaign against frames!” next to a crossed-out webpage full of frames." width="176" height="62" class="pix">}}
{{<picture name="b/right2repair" alt="I support right to repair." width="176" height="62" class="pix">}}
<a href="https://www.w3.org/Promotion/WIP/">{{<picture name="b/wip" alt="The text “Web Interoperability Pledge” next to a drawing of gears." width="176" height="62" class="pix">}}</a>
<a href="https://archive.webstandards.org/bannerx.html">{{<picture name="b/wpsnowbord" alt="A wasp next to the words “standards NOW!”" width="176" height="62" class="pix">}}</a>
<a href="https://web.archive.org/web/20060206224207fw_/http://www.subreality.com/yellow.htm">{{<picture name="b/yellow_ribbon" alt="Yellow ribbon: online friendship means something!" width="176" height="62" class="pix">}}</a>
{{<picture name="b/tiredaf" alt="Tired A-F of: paywalls, advertisements, notifications, marketing emails, followers, likes, influencers, artificial scarcity, parasocial interaction." width="176" height="62" class="pix">}}

### Notes on "Ideological affinity, Web-related" badges

I included "Right to repair" in this section because I think that page-alteration (via adblockers, inspect-element, userstyles, etc.) counts as exercising one's right to (software) repair. Free software, accessibility, and Right to Repair are interlinked. I previously microblogged [in defense of content blocking from a right-to-repair perspective]({{<relref "/notes/in-defense-of-content-blocking.md">}}).

## Ideological affinity, other

I might eventually move these to a separate page under the "About" section of my site.

{{<picture name="b/antinazi" alt="No nazi. No fascism. No racism." width="176" height="62" class="pix">}}
{{<picture name="b/animegay" alt="Anime is gay as hell but I approve!" width="176" height="62" class="pix">}}
{{<picture name="b/brolove" alt="The words “It's okay to give your bros some love” next to two anime boys kissing." width="176" height="62" class="pix">}}
{{<picture name="b/catboys" alt="The words “catboys meow!” next to a silhouette of a cat head flapping its ears." width="176" height="62" class="pix">}}
{{<picture name="b/genderfluid" alt="genderfluid flag." width="176" height="62" class="pix">}}
{{<picture name="b/trans-rights" alt="Trans rights now!" width="176" height="62" class="pix">}}
{{<picture name="b/adhd" alt="ADHD." width="176" height="62" class="pix">}}
<a href="https://www.autisticasfxxk.com/">{{<picture name="b/autisticasfxxk.com" alt="The words “autistic as fuck” flash over a pick background. The word “fuck” is censored." width="176" height="62" class="pix">}}</a>
<a href="https://www.defectivebydesign.org/">{{<picture name="b/dbd" alt="Defective by design. Eliminate DRM now!" width="176" height="62" class="pix">}}</a>
<a href="https://en.wikipedia.org/wiki/Illegal_number?useskin=vector">{{<picture name="b/aacs" alt="The characters “8 8 8 C 0” over the vertical strips of the digital free speech flag." width="176" height="62" class="pix">}}</a>
{{<picture name="b/emulate-now" alt="Emulate Now!" width="176" height="62" class="pix">}}

## Things I use

See [my "uses" page]({{<relref "/about/uses.md">}}) for some more information.

{{<picture name="b/linux" alt="Xenia the Linux fox next to the words “Linux now!”" width="176" height="62" class="pix">}}
<a href="https://fediverse.party/en/fediverse/">{{<picture name="b/fediverse" alt="Join the fediverse." width="176" height="62" class="pix">}}</a>
<a href="https://www.gutenberg.org/">{{<picture name="b/gutenberg" alt="Project Gutenberg." width="176" height="62" class="pix">}}</a>
<a href="https://archive.org/?noscript=true">{{<picture name="b/internetarchive" alt="Internet Archive." width="176" height="62" class="pix">}}</a>
<a href="https://wiby.me/about/">{{<picture name="b/wiby" alt="Wiby.me search." width="176" height="62" class="pix">}}</a>
<a href="https://neovim.io/">{{<picture name="b/neovim" alt="Made with NeoVim." width="176" height="62" class="pix">}}</a>
<a href="https://ffmpeg.org/">{{<picture name="b/ffmpeg" alt="FFmpeg." width="176" height="62" class="pix">}}</a>
<a href="https://github.com/yt-dlp/yt-dlp">{{<picture name="b/yt-dl" alt="The word “youtube-dl” flashes on a command prompt." width="176" height="62" class="pix">}}</a>
<a href="https://matrix.org/">{{<picture name="b/matrix" alt="Matrix." width="176" height="62" class="pix">}}</a>
<a href="https://github.com/gorhill/uBlock">{{<picture name="b/ublock-origin" alt="uBlock Origin now!" width="176" height="62" class="pix">}}</a>

## Friendly sites

These are some people/websites I think are cool! I might eventually move these to a separate page under the "About" section of my site.

### Reciprocal

Sites that link back to me:

<a href="https://tea.cuddleslut.fr/">{{<picture name="b/tea_banner" alt="the word “tea” over a nonbinary flag next to a blushing personified teacup." width="176" height="62" class="pix">}}</a>
<a href="https://daudix.codeberg.page/about/">{{<picture name="b/daudix" alt="Daudix." width="176" height="62" class="pix">}}</a>
<a href="https://dj-chase.com/">{{<picture name="b/dj-chase" alt="DJ Chase." width="176" height="62" class="pix">}}</a>
<a href="https://astrid.tech/">{{<picture name="b/astriddottech" alt="astrid dot tech in glitchy distorted letters." width="176" height="62" class="pix">}}</a>
<a href="https://slatecave.net/railstation">{{<picture name="b/slatecave" alt="slatecave.net." width="176" height="62" class="pix">}}</a>
<a href="https://www.theresnotime.co.uk/">{{<picture name="b/theresnotime" alt="fox head over the words “TheresNoTime”." width="176" height="62" class="pix">}}</a>
<a href="https://itzzen.net/">{{<picture name="b/itzzen" alt="www dot itzzen dot net." width="176" height="62" class="pix">}}</a>
<a href="https://ezrizhu.com/">{{<picture name="b/ezri" alt="ezri" width="176" height="62" class="pix">}}</a>

### Other personal sites

<a href="https://keithhacks.cyou/">{{<picture name="b/keith" alt="the word “keith” after a tilde and a bone, with a rainbow border." width="176" height="62" class="pix">}}</a>
<a href="https://moth.monster/">{{<picture name="b/moth" alt="The word “moth” in a brown-on-orange palette next to a flat inverted moth icon." width="176" height="62" class="pix">}}</a>
<a href="https://tilde.town/~georgemoody/">{{<picture name="b/georgemoody" alt="Georgemoody." width="176" height="62" class="pix">}}</a>
<a href="https://owlsroost.xyz/">{{<picture name="b/owlsroost" alt="Owl’s Roost." width="176" height="62" class="pix">}}</a>
<a href="https://easrng.net/">{{<picture name="b/easrng" alt="easrng." width="176" height="62" class="pix">}}</a>
<a href="https://viatrix.is-hella.gay/">{{<picture name="b/vivi-8831" alt="Viatrix." width="176" height="62" class="pix">}}</a>

### Other sites

<a href="https://eightyeightthirty.one/">{{<picture name="b/eightyeightthirtyone" alt="eighty eight thirty dot one." width="176" height="62" class="pix">}}</a>
<a href="https://yesterweb.org/">{{<picture name="b/yesterweb" alt="YesterWeb: reclaim the net." width="176" height="62" class="pix">}}</a>
<a href="https://www.egscomics.com/">{{<picture name="b/egs" alt="El Goonish Shive." width="176" height="62" class="pix">}}</a>
<a href="https://xkcd.com/">{{<picture name="b/xkcd" alt="xkcd." width="176" height="62" class="pix">}}</a>

### Notes on "Friendly sites" badges

The Yesterweb is winding down its social activity after admin burnout, but it remains an important place during the Old Web revival of the late-2010s to early-2020s. I'm keeping the badge even if the rest of the shuts down (though it'll probably stick around in archived form).

## Other

<a href="https://www.nbcuni.co.jp/rondorobe/anime/lain/">{{<picture name="b/lain" alt="Close-up of Lain Iwakura’s eyes with a static filter." width="176" height="62" class="pix">}}</a>
<a href="https://ooo.eeeee.ooo/">{{<picture name="b/miku" alt="The text “This site is Miku-approved” next to Hatsune Miku." width="176" height="62" class="pix">}}</a>
{{<picture name="b/graphicdesign" alt="The words “graphic design is my passion” next to a bad drawing of a frog. Sarcasm implied." width="176" height="62" class="pix">}}
{{<picture name="b/ilovehorror" alt="I heart horror." width="176" height="62" class="pix">}}

## Credits

Many were sourced from [88x31db.com](https://88x31db.com/), which itself sources from other directories.

The following badges come from the sites they link to:

- Any browser you like
- 100% hand-coded HTML
- Atom and RSS validation badges
- Web-14 censorship panda
- AGPLv3 license
- humans.txt
- Say no to Web3
- Web Interoperability Pledge
- Standards NOW!
- Yellow ribbon
- Autistic as fxxk
- Defective by Design
- Wiby.me
- All "friendly sites" badges except xkcd (I don't know who made that)

Other credits:

- The W3C CSS badge is from {{<mention-work role="doc-credit" itemtype="Article" itemprop="citation">}}{{<cited-work name="The W3C “validation” icons" url="https://www.w3.org/QA/Tools/Icons" extraName="headline">}} by the <abbr itemscope="" itemtype="https://schema.org/Organization" itemprop="publisher" title="World Wide Web Consortium">W3C</abbr>{{</mention-work>}}

- I took the WAI-AA WCAG 2.2 badge from {{<mention-work role="doc-credit" itemtype="WebPage" itemprop="citation">}}{{<cited-work name="Adding WCAG Conformance Logos" url="https://www.w3.org/WAI/standards-guidelines/wcag/conformance-logos/" extraName="headline">}} by the <abbr itemscope="" itemtype="https://schema.org/Organization" itemprop="publisher" title="Web Accessibility Initiative">WAI</abbr>{{</mention-work>}}.

- I cropped the "I ❤ Validator" badge from {{<mention-work role="doc-credit" itemtype="Article" itemprop="citation">}}{{<cited-work name="W3C launches Validator Donation and Sponsorship Campaign" url="https://www.w3.org/news/2008/w3c-launches-validator-donation-and-sponsorship-campaign/" extraName="headline">}} by the <abbr itemscope="" itemtype="https://schema.org/Organization" itemprop="publisher" title="World Wide Web Consortium">W3C</abbr>{{</mention-work>}}.

- The El Goonish Shive badge is from [an old archived version of its website](https://web.archive.org/web/20071223104609/http://www.egscomics.com:80/banners.html).

- Tildeverse badge made by {{<indieweb-person itemprop="mentions" name="DJ Chase" url="https://dj-chase.com/">}}.

- Linux Now badge with Xenia the Linux Fox [made by Volt](https://meow.social/@voltbun/109600348286574222).

- "Emulate Now!" badge from [Neon with a Zero on Tumblr](https://ne0nwithazero.tumblr.com/post/702936474323206144).

## Appendix

Here's how I made my badge!

{{<codefigure>}}{{<codecaption lang="Shell">}}

Code to generate my 88x31 button using [my favicon.svg file](../../favicon.svg), ImageMagick, `rsvg-convert`, and `pngquant`.

{{</codecaption>}}

```figure
magick -background black -size 56x31 -fill white \
  -gravity center -font "Iosevka-Term" -pointsize 16 'label:Seirdy' \
  tmp.png
rsvg-convert favicon.svg -aw 31 \
  | convert - tmp.png +append -background white -splice 1x0+31+0 \
    -shave 1x1 -bordercolor white -border 1 - \
  | pngquant -s 1 28 - >sticker_88x31.png
rm tmp.png
```

{{</codefigure>}}

After generating it, I compressed it as much as possible using [Efficient-Compression-Tool](https://github.com/fhanau/Efficient-Compression-Tool).


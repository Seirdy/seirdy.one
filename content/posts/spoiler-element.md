---
title: "Proposal: an HTML element for spoilers"
description: "An informal proposal for dedicated elements for spoiler tags in HTML: use-cases, syntax, semantics, recommended UA behavior, and comparisons with <details>."
date: 2023-11-12T13:48:00-08:00
outputs:
    - html
    - gemtext
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/Abk95iMHVwXLGBw956'
    - title: 'Lobsters'
      url: 'https://lobste.rs/s/v1yooo/proposal_html_element_for_spoilers'
    - title: 'WICG Discourse'
      url: 'http://discourse.wicg.io/t/standardized-spoiler-tag/5814/15?u=seirdy'
    - title: 'IndieNews'
      url: 'https://news.indieweb.org/en'
    - title: 'jstpst'
      url: 'https://www.jstpst.net/f/just_post/9051/proposal-an-html-element-for-spoilers'
    - title: 'WHATWG HTML issue tracker'
      url: 'https://github.com/whatwg/html/issues/9926'
---
<section role="doc-introduction">

## Introduction

{{<quotation>}}

<blockquote itemprop="text" role="doc-epigraph">

I wish it were possible to look up any medical issue without being exposed to the most graphic photographs ever taken by man or beast.

</blockquote>
{{< quotecaption partOfType="SocialMediaPosting">}}
{{<indieweb-person name="Velveteen" url="https://velveteen.one/" itemprop="author">}}, {{<cited-work name="Post on akko.wtf" url="https://akko.wtf/objects/8fd2f79b-9529-441d-8b6f-079ac4a8f599">}}
{{< /quotecaption >}}
{{</quotation>}}

While browsing the <abbr title="Web Incubator Community Group">WICG</abbr> discussion forms, I stumbled upon [a proposal for a standardized `<spoiler>` element in HTML5](https://discourse.wicg.io/t/standardized-spoiler-tag/5814). I made two comments, and stopped myself before writing a third; this called for a blog post. _I think HTML should have a spoiler element._

</section>

{{<toc>}}

<section>

## Prior art {#prior-art}

Spoilers are already implemented in several places around the Web, but without a standard set of semantics.

A useful reference is the markup used in the Matrix protocol. Matrix messages may include a standardized subset of HTML, with some additional features provided by HTML attributes.[^1]

{{<codefigure>}}{{<codecaption lang="HTML">}}

The following syntax creates a spoiler in Matrix:

{{</codecaption>}}

```figure
<span data-mx-spoiler="optional placeholder text">hidden content</span>
```

{{</codefigure>}}

{{<image-figure id="spoiler-matrix">}}

<figcaption itemprop="caption">

A screenshot of how Element, a Matrix client, renders a spoiler element:

</figcaption>
{{<picture name="spoiler" alt="screenshot of small faded text reading “optional placeholder text” followed by blurred regular text.">}}

{{</image-figure>}}

The visual result is typically the placeholder text followed by blurred or blacked-out hidden contents, revealed upon user interaction. Children aren't limited to text; this is a common approach to hiding images.

{{<image-figure id="spoiler-fedi">}}

<figcaption itemprop="caption">

An image marked sensitive on Firefish (a Fediverse server) shows a blurred placeholder. [Original thread](https://pleroma.envs.net/notice/AZNKmYaNv9UOa9e3wO).

</figcaption>
{{<picture name="spoiler-fedi" alt="screenshot: a post by @freeplay@kitsunes.club shows a blurred image under placeholder text reading “NSFW: Click to show”.">}}

{{</image-figure>}}

{{<codefigure>}}{{<codecaption>}}

More special syntax for spoilers:

{{</codecaption>}}

```figure
||optional placeholder text|Fluffychat and Discord hide this.||
>!Reddit hides this.<
[spoiler=optional placeholder text]BBCode hides this[/spoiler]
```

{{</codefigure>}}

[BBCode](https://www.bbcode.org/posting-a-spoiler-with-bbcode.php) is the oldest example of dedicated spoiler syntax I know of.

</section>
<section>

## Comparison with `details`

On the <abbr>WICG</abbr> forum, one user asked about the differences between `spoiler` and `details`. The two elements have very much in common; I'd even go so far as to say that `spoiler` elements could also make use of `summary` children for placeholder text.[^3] That being said, the semantics and behavior have important differences.

### Semantics

While a disclosure widget exists to allow toggling information, a spoiler exists to make information _inaccessible without consent:_ invisible, inaudible, unreadable. A disclosure widget helps divert user's attention away from hidden text; a spoiler protects users from hidden text.

Following the examples in [the "Prior Art" section](#prior-art), `summary` can be an _optional_ first-child of a `spoiler` while remaining a mandatory first-child of `details`.

### Behavior

Semantic differences should impact how activation works. Spoiler text should not be revealed until the placeholder text has been read. Unread spoiler text may include off-screen placeholders, placeholders that a screen/braille-reader hasn't reached yet, and perhaps even spoiler text whose placeholders haven't reached a magnifier's viewport. Spoilers shouldn't be revealed by accident.

For visual users, placeholder text should be in the viewport for a minimum duration. A user-agent should expose a setting to increase this duration. Ideally, it could allow users to supply keywords for sensitive or non-sensitive topics for auto-hiding or auto-revealing spoilers. Spoiler text matching sensitive topics should require some form of additional confirmation.

Functionality such as find-in-page may indicate a match obscured by a spoiler, but shouldn't activate the spoiler. It may expand a disclosure widget.

### Presentation

`details` is a block element; `spoiler` can be either an inline or block element. A few words within a paragraph can be hidden behind a spoiler. `details` tends to work more effectively on larger sections of content. A `spoiler` should obscure content, but not the size of said content; it _obscures_ content without _removing_ it.

For printouts, behavior should mirror `details`. Print hidden if it's hidden in the browser, and print revealed if it's been revealed in the browser.

</section>
<section>

## Use-cases

Several overlapping use-cases exist:

- "Spoilers" for plot-twists. These are common on wikis such as TV Tropes.
- A warning for imagery that may be inappropriate in a public setting (you might want to hide erotic or gory content when you're on the train).
- Content-warnings for potentially triggering topics.
- Hiding a joke's punchline, or the answer to a riddle.
- Hiding user-generated content that's been flagged by other users, awaiting moderation.

I could go on. This is an immensely useful feature that HTML doesn't adequately address right now.

</section>
<section>

## Potential attributes

Some semantic configurability should be possible with HTML attributes:


`preview`
: A boolean attribute for `spoiler`. Hidden content could have a preview available or have no preview at all. A "true" value could show a partial preview of a sensitive image (e.g. a version with a reduced resolution and saturation, passed through a heavy blur filter); a "false" value could simply hide the content behind censor bars or filler content.

`preview-alt`
: An attribute for any element that supports the `alt` attribute. This can supply alt-text for hidden versions of media without overly descriptive language, analogous to blurred or pixelated previews. "Black-and-white photo of a large wound" could be an image's "preview-alt" text, while the actual alt text could describe the image more..._vividly_.[^4]

`loading`
: `img`, `iframe`, and other elements already support `loading="lazy"` to enable native lazy loading. [A thread on the WICG forums](https://discourse.wicg.io/t/add-loading-lazy-attribute-to-details-element/6060) proposes allowing the attribute on container elements to apply to their children, singling out `details` in particular. As `spoiler` hides content, hidden children may have loading deferred until their parent `spoiler` element activates.

</section>
<section>

## Considerations

### Considerations for user-agents

- Many browser developer tools allow viewing a page's media; for example, the Network Inspector allows rendering the body of an individual request. A request for an image inside a `spoiler` should not unnecessarily bypass this. Browsers with such features shouldn't ship `spoiler` support until a developer-tools toggle for "show spoiler contents" is ready. Should this also apply to spoiler text?

- Users who frequently visit a website may wish for a site-specific setting to auto-show sensitive media. This is a common setting on social media sites.

- A simple click-to-toggle would interfere with selection, as repeated clicking is a common way to select text. We should come up with an alternative.

### Considerations for authors

- In some situations, could alt-text be _more_ sensitive than visual media? If so, perhaps `preview-alt` could apply even without a parent `spoiler` element.

- Good preview-alt-text is descriptive enough to inform the decision to toggle media, but not so descriptive that it needs a spoiler of its own. Reaching that balance is extremely difficult.

- This might be a situation in which SEO-style keyword-stuffing might actually have real merit, to accurately trigger users' own keyword filters.

- Authors may wish to provide a JavaScript polyfill for clients that lack support, and perhaps preface their content or links with a `noscript` warning for clients lacking support for both `spoiler` and scripting.

- How should authors describe severity levels? An image containing blood could depict a minor scrape or severe medical gore. We'll need guidelines on how to do this, just as we have guidelines on alt-text.

### Privacy considerations

- User keyword filters may present a fingerprinting vector. Anonymity-focused browsers like the Tor Browser probably shouldn't expose this functionality. Perhaps spoilers combined with lazy-loading should be disqualified from auto-revealing.

- A user who consistently declines to reveal spoilers with certain keywords in the placeholder text may be fingerprinted accordingly. The Tor Browser's "safest" mode disables lazy loading and JavaScript, which should close this fingerprinting vector.

### Further work

We may need to create additional corresponding <abbr title="Accessible Rich Internet Applications">ARIA</abbr> roles for spoilers. I can't decide on an ideal existing one.

We may also need to define a vocabulary for well-known spoilers, and encourage authors to use that vocabulary when relevant. This could improve how well auto-revealing spoilers works. Of course, I'm not proposing that any content matching that vocabulary should receive a spoiler; I'm only proposing to choose that vocabulary when writing spoiler-text, if it's relevant. I don't think we should be prescriptive about what to use spoilers on across the entire Web.

There should be a way to spoiler a whole page, or a whole website, if the primary focus of the page/website is a sensitive topic. This is common on sites devoted to erotic or age-gated content.

Other areas may benefit from standardized spoiler-like semantics. Someday, chapter indicators in media containers could come with Sponsorblock-inspired vocabulary; some chapters could be marked "sensitive" and auto-pause while displaying a reason. If other spoiler-like semantics exist, we should create mappings between proposed HTML semantics and existing semantics. Perhaps such an exercise would change how we develop HTML semantics for spoilers.

</section>
<section>

## Snarky thoughts: conflicts of interests

Ad companies probably won't want to hide ads containing sexual/erotic, anxiety-inducing, or shock content behind spoilers; they profit _from_ what spoilers protect against. Sites with such ads probably won't benefit from hiding such content behind spoilers if ads are exempt.

A good solution would be for ads to identify themselves as such along with the psychological weaknesses they prey on (porn addictions, anxiety, eating disorders, gambling addictions, etc.) so that user-agents could selectively or globally block them. For some reason, I don't think adtech companies would like this very much. More research is required to find a form of basic compassion that allows dominant advertising business models to exist.

</section>

<section role="doc-acknowledgments">

## Ack&shy;nowledge&shy;ments {#acknowledgements}

Thanks to {{<indieweb-person itemprop="mentions" name="Athena Martin" url="https://alm.website/me">}} for providing feedback on an initial draft. She raised concerns about user-agents without support, the possibility of specifying machine-readable severity levels, and printouts.

Thanks to {{<indieweb-person itemprop="mentions" name="~keith" url="https://keithhacks.cyou/">}} for bringing up good points concerning prescriptivity of spoiler norms.

Thanks to {{<indieweb-person itemprop="mentions" name="Locria Cyber" url="https://www.1a-insec.net/">}} for reminding me about BBCode.

</section>


[^1]: This format is called `org.matrix.custom.html`. The {{<mention-work itemtype="TechArticle">}}<cite itemprop="name headline" class="p-name">Matrix Specification Client-Server API</cite>, section 11.2.2.6: <a class="u-url" itemprop="url" href="https://spec.matrix.org/v1.8/client-server-api/#spoiler-messages">“Spoiler messages”</a>{{</mention-work>}} specifies the spoiler syntax, semantics, and recommended client behavior.

[^3]: Note that `summary` was originally specified as a block-level button, not an inline element. This may require changes to the definition of `summary`. I don't believe that the changes should significantly impact conformant pages, but non-conforming pages that incorrectly use `summary` elements without the required `details` parent may be impacted. Perhaps we really do need a new element for spoiler summaries.

[^4]: I came up with the idea of this attribute when I was browsing some Wikipedia articles on medical topics and ended up on the article for "maggot therapy". I had uBlock Origin configured to make large media click-to-load, and the figure captions told me which ones would be safe to load when others were in the room. However, [figure captions aren't a replacement for alt-text]({{<relref "website-best-practices.md#putting-images-in-context">}}).



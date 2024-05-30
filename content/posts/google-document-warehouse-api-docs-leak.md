---
title: "Takeaways from the Google Content Warehouse API documentation leak"
description: "My thoughts on Google's Content Warehouse API doc leak, what we can learn from its ranking factors, and why the following SEO hype is overblown."
date: "2024-05-30T04:47:38-04:00"
tags:
    - search
    - web
outputs:
    - html
    - gemtext
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AiPaH6gN6VboAEbG5I'
    - title: 'The Mojeek Discourse'
      url: 'https://community.mojeek.com/t/takeaways-from-the-google-cloud-warehouse-api-documentation-leak/1079'
    - title: 'jstpst'
      url: 'https://www.jstpst.net/f/just_post/10039/takeaways-from-the-google-cloud-warehouse-api-documentation'
---
<section role="doc-introduction" itemprop="backstory">

<h2 id="Introduction">Introduction</h2>

In March, the official Elixir client for Google APIs [received an accidental commit for internal non-public APIs](https://github.com/googleapis/elixir-google-api/commit/d7a637f4391b2174a2cf43ee11e6577a204a161e). The commit added support for Google's Content Warehouse API, which includes Google's 14,000+ search ranking factors. Oops! Some people noticed this after its redaction earlier this month, and the news broke on May 28. You can read through the [Content Warehouse API reference on HexDocs](https://hexdocs.pm/google_api_content_warehouse/0.4.0/api-reference.html). I skimmed through these and read some blog posts by others who looked more deeply.

In particular, I referenced {{<mention-work itemtyep="citation" itemtype="BlogPosting">}}{{<cited-work name="Secrets from the Algorithm: Google Search’s Internal Engineering Documentation Has Leaked" extraNme="headline" url="https://ipullrank.com/google-algo-leak">}} by {{<indieweb-person itemprop="author" first-name="Mike" last-name="King" url="https://ipullrank.com/author/ipullrank">}}{{</mention-work>}}. Note that Mike King's article doubles as an advertisement for his company's services and for the legitimacy of search engine optimization (<abbr>SEO</abbr>) companies in general. I don't endorse that message. I disagree with some of its claims, and elaborate on them in the coming sections. That said, I found the article well-researched. It cross-references information against other leaks, too.

</section>

## Thoughts on individual ranking factors

Google has over 14,000 ranking factors. I have not and will not read them all. I went through what other bloggers found notable, the [`PerDocData` page](https://hexdocs.pm/google_api_content_warehouse/0.4.0/GoogleApi.ContentWarehouse.V1.Model.PerDocData.html), and what looked interesting when I searched for keywords I thought would reveal important ranking factors.

### Small personal sites and commercial sites

Google determines if your site is a <q cite="https://hexdocs.pm/google_api_content_warehouse/0.4.0/GoogleApi.ContentWarehouse.V1.Model.QualityNsrNsrData.html">small personal site</q>[^1] and calculates a `commercialScore` in `PerDocData` which <q cite="https://hexdocs.pm/google_api_content_warehouse/0.4.0/GoogleApi.ContentWarehouse.V1.Model.PerDocData.html#module-attributes">indicates [the] document is commercial (i.e. sells something)</q>. The docs have no information about whether either signal is positive or negative. Given how Google results look today and the language it uses in its documentation for manual reviewers,[^2] I conclude that personal sites don't receive a significant boost. If anything, they may be demoted instead.

I feel disappointed. I always considered the bias against small sites unintentionally emergent from them having no SEO budget. If a solution already exists, why doesn't Google use it to even this gap? A more optimistic interpretation is that this factor will have weight when it's ready and resistant to manipulation, but I don't see incentives lining up to make that happen.

### Font size‽

Google tracks "weighted font size" to notice key terms. Separation of content/semantics and form/presentation is baked into the DNA of the Web. Google should stick to semantic HTML elements such as `<dfn>` and `<dt>`, or at _least_ `<strong>` and `<em>`.

I worry that people will interpret this piece of API documentation as advice and run with it. [Search engines have the power to incentivize good behavior]({{<relref "/notes/accessibility-and-search-indexes">}}), and this piece of information has the opposite effect. Visual emphasis should derive from semantic meaning, dammit!

This might have no weight in production. Perhaps Google uses the font size factor during A/B testing, comparing how results change when considering both styling and semantics. Google _tracking_ something isn't evidence that Google uses it in production. [A closer read of the docs shows Google tracking ten font metrics](https://hexdocs.pm/google_api_content_warehouse/0.4.0/GoogleApi.ContentWarehouse.V1.Model.GoodocFontSizeStats.html), and I don't believe that attributes such as `medianLineSpan` and `fontId` are ranking factors. It's still plausible that font size impacts ranking since Google does track font size separately as an attribute of anchor text.[^3]

### Chrome user data

Google uses Chrome and click data, much like how Brave Search uses Brave data.[^4] I don't like this, as it lends itself to clickbait and chasing engagement rather than actual quality. At least, unlike Brave, Google doesn't measure clicks on _competitor engines._ This contradicts _many_ official docs and spokespeople. I would put a disclaimer like the one in the earlier section, but Mike King cross-referenced this against other leaks that confirm as much. Plausible deniability seems low.

### Manual review

{{<quotation>}}

<blockquote itemprop="text">

`golden` (type: `boolean()`, default: `nil`) - Flag for indicating that the document is a gold-standard document. This can be used for putting additional weight on human-labeled documents in contrast to automatically labeled annotations.

</blockquote>
{{< quotecaption partOfType="APIReference">}}
{{<cited-work name="Google Content Warehouse API documentation: GoogleApi.ContentWarehouse.V1.Model.NlpSaftDocument" url="https://hexdocs.pm/google_api_content_warehouse/0.4.0/GoogleApi.ContentWarehouse.V1.Model.NlpSaftDocument.html#module-attributes" extraName="headline">}}
{{< /quotecaption >}}
{{</quotation>}}

The existence of manual review to evaluate Google's ranking has never been secret, but evidence that manually reviewed documents can have a ranking adjustment is new.

Manual ranking can combine with modifications to your ranking algorithm to bias your centrality algorithm around handpicked pages, which is how Marginalia achieves its anti-SEO bias.[^5] Personalized PageRank is one such algorithm, documented in the original PageRank paper. I like the use of manual review for "gold-standard documents" when applied to centrality algorithm biasing. However, I don't know how I feel about manual reviewer scores directly appearing as a result ranking factor.

Like font size, we don't know whether Google actually uses manual review in production ranking factors. Google might catalog it here to run tests of expected-versus-actual ranking. Directly or indirectly, it shows that Google does take manual reviews into account in some way.

### Bias against new sites

It's not just you. Google has a bias against new sites due to their spam potential.[^6] Contrary to what official statements say, Google has a "sandbox" for new sites. Google also uses domain registration information.[^7] Mike King's post says this comes from Google Domains itself, but I haven't found evidence to back this up. Current domain registration records are public. An organization such as Google can use them to build a catalog of historical registration information without tapping into its domain registry. Anybody with `whois` can do this!

### Truncation

Google does truncate pages to a certain number of tokens,[^8] like most engines, instead of reading long pages indefinitely. I find this strange: based on keyword matches, I'm sure Google has read to the end of some of my longest blog posts. Some fill almost 100 pages printed out (yeah…I have a problem). Google uses a limited number of historic versions of pages,[^9] so this isn't due to historical versions of my page. Perhaps the token limit is just that high.

### Author name mismatches

Google extracts the same piece of metadata (e.g., published/updated timestamps or author names) from wherever it exists (the URL, byline, natural-language processing, structured data, the sitemap, etc.). For authors, it does seem to care about mismatches. Public documentation allows an author entity to have many names, and this factor doesn't necessarily contradict that. I imagine that ensuring author name consistency could create bias against people who do specify different authors in different parts of the same page (plural systems come to mind), especially when we consider false positives. I'm uncertain; this is speculation on my part.

## A cold shower: this isn't as significant as some SEOs claim

We only have API documentation. We don't know about any hidden knowledge, whether any of these factors have a ranking weight of "zero", whether any of these conditionally apply, which are only used internally for testing, etc. As I said in prior disclaimers, some factors might exist for testing purposes. Serious conclusions drawn from this leak are, to some degree, speculation.

I wouldn't panic over how SEO companies use this leak to game the algorithm and ruin search more. Given their track record of missing the forest for the trees and the ever-changing hidden weighting factors we can't see, we have little reason for concern. I imagine certain people in the SEO industry jumping to conclusions based on word choice in these API docs, not realizing how words' original legacy meanings and current meanings are different.

For example, per-page metadata includes integer attributes such as `crawlerPageRank` and `pagerank2`, but PageRank is no longer a useful way to build a ranking algorithm for the entire Web. The attribute might no longer carry weight, or the decades-old PageRank centrality algorithm might not populate this anymore. To put this in perspective, the docs mention a `HtmlrenderWebkitHeadlessProto` but Google's known to use a Chromium-based browser to render pages. Chromium hasn't used WebKit in a decade; it hard-forked WebKit to make Blink in 2013.

Per-page metadata also includes a `toolbarPagerank` integer attribute that hearkens back to the ancient Toolbar PageRank; this also probably doesn't carry weight today. You can read more about Google's use of PageRank and Toolbar in {{<mention-work itemtype="NewsArticle">}}{{<cited-work name="RIP Google PageRank score: A retrospective on how it ruined the web" extraName="headline" url="https://searchengineland.com/rip-google-pagerank-retrospective-244286">}} by {{<indieweb-person itemprop="author" first-name="Danny" last-name="Sullivan" url="https://dannysullivan.com/">}}{{</mention-work>}}.

<section role="doc-conclusion">

## Conclusion: my takeaways

I still despise how the SEO industry and Google have started an arms race to incentivize making websites worse for actual users, selecting against small independent websites. I do maintain that we can carve out a non-toxic sliver of SEO: "search engine compatibility". Few features uniquely belong in search engine, browser, reading mode, feed reader, social media link-preview, etc. compatibility. If you specifically ignore search engine compatibility but target everything else, you'll implement it regardless. [I call this principle <dfn>"agent optimization"</dfn>]({{<relref "/notes/agent-optimization.md">}}). I prefer the idea of optimizing for generic agents to optimizing for search engines, let alone one (1) search engine, in isolation. Naturally, user-agents (including browsers) come first; nothing should have significant conflict with them.

If you came to this article as an SEO, I don't think I can convince you to stop. Instead, remember that it's easy to miss the forest for the trees. Don't lose sleep over _one in fourteen thousand ranking criteria_ without other data backing up its importance and current relevance.

Consider my rule of thumb, whose relevance will outlast this leak: assume Google looks at whatever information it can _if it helps Google draw the conclusions its public guidelines say it tries to draw,_ even if those guidelines say it doesn't use that information. The information Google uses differs from what it tells the public (yes, Google lied), and changes with time; however, Google's intent makes for less of a moving target. This leak might contradict _how_ Google determines what it should rank well, but not _what_ it looks for. A good reference for what Google looks for is [Google's search rater guidelines](https://static.googleusercontent.com/media/guidelines.raterhub.com/en//searchqualityevaluatorguidelines.pdf) for manual reviewers.

Google lied, but don't uncritically fall for the coming SEO hype.

</section>


[^1]: See [the `smallPersonalSite` attribute of `QualityNsrNsrData`](https://hexdocs.pm/google_api_content_warehouse/0.4.0/GoogleApi.ContentWarehouse.V1.Model.QualityNsrNsrData.html).

[^2]: See the conclusion, or snippets of the Google Search Central documentation [such as this page describing the <abbr>EEAT</abbr> principle: experience, expertise, authoritativeness, and trustworthiness](https://developers.google.com/search/docs/fundamentals/creating-helpful-content).

[^3]: [`AnchorsAnchor` has a `fontSize` member](https://hexdocs.pm/google_api_content_warehouse/0.4.0/GoogleApi.ContentWarehouse.V1.Model.AnchorsAnchor.html#module-attributes) with no extra documentation.

[^4]: I'd always assumed (in private, due to a lack of evidence) that the Chrome User Experience Report (<abbr>CrUX</abbr>) played a role in search rankings. I don't know if or how this data overlaps with CrUX.

[^5]: [The creator of Marginalia documents initial experiments in a 2021 blog post](https://www.marginalia.nu/log/26-personalized-pagerank/), and later [confirmed this on "Hacker" "News"](https://news.ycombinator.com/item?id=32349094). In 2023, [Marginalia switched away from PageRank to a different centrality algorithm](https://www.marginalia.nu/log/73-new-approach-to-ranking/).

[^6]: See [the `hostAge` attribute of `PerDocData`](https://hexdocs.pm/google_api_content_warehouse/0.4.0/GoogleApi.ContentWarehouse.V1.Model.PerDocData.html#module-attributes).

[^7]: See [`RegistrationInfo`](https://hexdocs.pm/google_api_content_warehouse/0.4.0/GoogleApi.ContentWarehouse.V1.Model.RegistrationInfo.html). It defines `createdDate` and `expiredDate` attributes.

[^8]: See docs for [`numTokens` in `DocProperties`](https://hexdocs.pm/google_api_content_warehouse/0.4.0/GoogleApi.ContentWarehouse.V1.Model.PerDocData.html#module-attributes): <q cite="https://hexdocs.pm/google_api_content_warehouse/0.4.0/GoogleApi.ContentWarehouse.V1.Model.DocProperties.html#module-attributes">we drop some tokens in mustang and also truncate docs at a max cap</q>.

[^9]: See [the `urlHistory` attribute of `CompositeDocIndexingInfo`](https://hexdocs.pm/google_api_content_warehouse/0.4.0/GoogleApi.ContentWarehouse.V1.Model.CompositeDocIndexingInfo.html#module-attributes).



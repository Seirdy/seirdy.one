---
title: "Scrapers I block (and allow), with explanations"
description: "Here’s my thought process when deciding whether to block a scraper from seirdy.one, the scrapers I block, the scrapers I allow, and the ways I block them."
date: 2024-12-10T00:37:54-05:00
tags:
    - web
    - AI
outputs:
    - html
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/objects/c022c39f-5cab-49c8-bf84-7504326e87dc'
    - title: 'BlueSky'
      url: 'https://bsky.app/profile/seirdy.one/post/3lcwjwqkc5k2z'
    - title: 'jstpst'
      url: 'https://jstpst.net/f/articles/12091/scrapers-i-block-and-allow-with-explanations'
---
<section role="doc-introduction" itemprop="backstory">

## Introduction

[An old version of my <span translate="no">robots.txt</span> file](https://git.sr.ht/~seirdy/seirdy.one/blob/b9536a6a9d592d644d53a65b952bd7c95a0faa04/static/robots.txt) was full of documentation on each user-agent I blocked. Over time, other websites started using my <span translate="no">robots.txt</span> file as a reference. I'm humbled by how useful others find my <span translate="no">robots.txt</span> file.[^1]

Unfortunately, a plain text file in a browser window isn't the most readable experience for everybody. It has no headings for quick navigation, inconsistent support for soft line-wrapping, and poor support for hyperlinks.

I'm compiling documentation on the bots I block here, including my thought process for deciding whether to block or allow a bot. This isn't an alternative to larger resources on bad-bot lists, but a secondary resource for them to cite. If you compile a larger list of bots, feel free to cite this page.

At the same time, I hope to make this an alternative to generic bad-bot lists with more nuance. I even go so far as explaining why I _allow_ certain commonly-blocked bots.

[Skip to the list of bots I block](#bots-blocked) if that's all you're here for.

</section>

## Criteria for bad-bot blocking

Bots I block fall into one of the following categories:

- Bots that only serve to power adtech on _other_ sites. My site has no ads, but [I allow bots such as Google's AdsBot](#adsbot).

- Intellectual property snitches. I forbid robots that scan for plagiarism, trademark/copyright violations, brand protection, etc.

- Robots that power invasive background checks that border on cyberstalking.

- Scrapers that build datasets to train Generative AI (<abbr>GenAI</abbr>), such as large language models (<abbr>LLMs</abbr>). I don't block search clients used by <abbr>GenAI</abbr> research assistants; I only block scrapers used to _train_ <abbr>GenAI</abbr> models.

### On contradictions between intellectual-property snitches and <abbr>GenAI</abbr> scrapers

Some people think opposing <abbr>GenAI</abbr> scraping is support for intellectual property, and opposing intellectual property means support for <abbr>GenAI</abbr> scraping.

My distaste for modern intellectual property protections comes from seeing how they stifle creativity. My view on the relationship between IP and <abbr>GenAI</abbr> scrapers us that much of (not all of) IP law _and_ <abbr>GenAI</abbr> are bad for creators. Policies on scraping, such as parts of the EU "CDSM Directive" relevant to the Text and Data Mining Protocol (discussed later), have the potential to strike the right balance between them on the Web. I do not welcome copyright snitches that work against remix culture, and <abbr>GenAI</abbr> scrapers that devalue and replace creative labor (remix or not), on seirdy.one.

## How I block bots

Here's how I block bots, from the most polite approaches to the most severe restrictions.

### X-Robots

`X-Robots` tags control _what to do with a page after it has been crawled._ They do _not_ opt out of mere crawling: they opt-out of processing pages after they've been discovered by a crawler.

I set `X-Robots` tags in every page that forbid training Generative AI algorithms but accept just about everything else. [Google Search Central lists its supported directives](https://developers.google.com/search/docs/crawling-indexing/robots-meta-tag).

{{<mention-work itemtype="BlogPosting">}}<span itemscope="" itemprop="publisher" itemtype="https://schema.org/Organization">DeviantArt</span> popularized the `NoAI` `X-Robots` tag in {{<cited-work name="UPDATE All Deviations Are Opted Out of AI Datasets" url="https://www.deviantart.com/team/journal/UPDATE-All-Deviations-Are-Opted-Out-of-AI-Datasets-934500371" extraName="headline">}}{{</mention-work>}}, wich [Cohost](https://web.archive.org/web/20241207040446/https://cohost.org/staff/post/272195-cohost-now-sets-devi) and [Misskey](https://github.com/misskey-dev/misskey/pull/10833) since implemented. The [img2dataset scraper](https://github.com/rom1504/img2dataset/pull/218) respects it.

### <span translate="no">robots.txt</span>

<span translate="no">robots.txt</span> is meant to opt out of crawling, to reduce server load. It does _not_ opt you out of further processing of crawled pages. Data miners can still fetch your pages without crawling them: they can fetch archived snapshots, use data collection in users' browsers or browser extensions, download or buy datasets, etc. `X-Robots` tags are the only standard vendor-neutral format for opting out of processing of crawled pages.

**There is no way to opt out of both crawling and further processing.** A page's policies on permitted forms of processing can only be found by visiting the page and reading those policies in `X-Robots` tags.

That said, many robots do not respect `X-Robots` tags, or an `X-Robots` tag doesn't exist to prevent the type of processing I want to prevent (e.g. IP-snitching). Often, a <span translate="no">robots.txt</span> entry is the only documented way to opt out of something. In these cases, I compromise and hijack my <span translate="no">robots.txt</span> to opt out.

### Comparing <span translate="no">robots.txt</span>, X-Robots, and the <abbr>TDM</abbr> Reservation Protocol

Ideally, `X-Robots` would support per-engine rules in a standard format, such as <span translate="no">robots.txt</span>. Unfortunately, it doesn't. Unlike <span translate="no">robots.txt</span>, it has per-page rules that persist on archives of a given page, potentially saved in other data sets.

A successor to `X-Robots` called the [Text and Data Mining (<abbr>TDM</abbr>) Reservation Protocol](https://w3c.github.io/tdm-reservation-protocol/) may close the gap between `X-Robots` and <span translate="no">robots.txt</span>. It allows setting policies on data-mining to forbid <abbr>LLM</abbr> training, among other things.

The `noai` `X-Robots` directive makes the same mistake as the "Do Not Track" HTTP request header, in that it's a vague polite request with incentive for compliance. Crawlers generally respect <span translate="no">robots.txt</span> because they get caught and banned if they don't; indexers respect `noindex` because it prevents duplicate, internal, and shallow pages from getting indexed. There's no incentive to respect `noai`.

The <abbr>TDM</abbr> Reservation Protocol is less like "Do Not Track" and more like Global Privacy Control: observance of the <abbr>TDM</abbr> Reservation Protocol could be a way to qualify for an exception under the European Union's "CDSM Directive". It could have a clear legal meaning and legal incentive, which gives companies a very good reason to respect it. After the <abbr>TDM</abbr> Reservation Protocol finalizes and is shown to work, I may adopt it.

### User-Agent regex denial

I block certain bots by matching their User-Agent strings against a regular expression and serving them a "403: Forbidden" HTTP error. I don't want to welcome these robots on seirdy.one. They typically don't obey (or have a history of disobeying) `X-Robots` or <span translate="no">robots.txt</span>. **This is a last resort.** I _need_ well-behaved robots to read my `X-Robots` tags and <span translate="no">robots.txt</span> so they can know that I'm opting out of data collection. By doing so, they can also skip my site when scraping third-party datasets and drop existing copies of my pages from their datasets.

## Currently-relevant bots I block in <span translate="no">robots.txt</span> {#bots-blocked}

Here's the list of bots, their product tokens, and information on the bots.

A <dfn>product token</dfn> populates the `User-Agent` line in a <span translate="no">robots.txt</span> entry. It doesn't necessarily map to the robots' `User-Agent` HTTP request headers, but it should have a strong resemblance.

{{<quotation>}}

<blockquote itemprop="text">

The product token **SHOULD** be a substring of the identification string that the crawler sends to the service. For example, in the case of HTTP RFC9110, the product token **SHOULD** be a substring in the User-Agent header.

</blockquote>
{{<quotecaption partOfType="TechArticle">}}
{{<cited-work rend="true" name="<abbr title=\"Request for Comments\">RFC</abbr> 9309: Robots Exclusion Protocol" extraName="headline" url="https://www.rfc-editor.org/rfc/rfc9309.html">}}
{{</quotecaption>}}

{{</quotation>}}

### peer39 crawler


Product tokens
: `peer39_crawler`
: `peer39_crawler/1.0`

Reason
: Adtech

Information
: {{<mention-work itemtype="Article">}}{{<cited-work url="https://www.peer39.com/crawler-notice" name="Peer39 Crawler Notice" extraName="headline">}}{{</mention-work>}}
: Relevant quote: <q cite="https://www.peer39.com/crawler-notice">By allowing us access, you enable the maximum number of advertisers to confidently purchase advertising space on your pages. Our comprehensive data insights help advertisers understand the suitability and context of your content, ensuring that their ads align with your audience's interests and needs. This alignment leads to improved user experiences, increased engagement, and ultimately, higher revenue potential for your publication.</q>

### TurnItInBot


Product tokens
: `turnitinbot`

Reason
: Intellectual property snitch.

Information
: {{<mention-work itemtype="Article">}}{{<cited-work url="https://www.turnitin.com/robot/crawlerinfo.html" name="TurnItInBot General Information Page" extraName="headline">}}{{</mention-work>}}
: Relevant quote: <q cite="https://www.turnitin.com/robot/crawlerinfo.html">This robot collects content from the Internet for the sole purpose of helping educational institutions prevent plagiarism. In particular, we compare student papers against the content we find on the Internet to see if we can find similarities.</q>

Commentary
: TurnItIn also offers false-positive-ridden <abbr>LLM</abbr>-detection services, described in {{<mention-work itemtype="Article">}}{{<cited-work name="Beyond Surveillance: The Case Against AI Proctoring and AI Detection" url="https://bccampus.ca/2024/10/16/beyond-surveillance-the-case-against-ai-proctoring-ai-detection/" extraName="headline">}} by {{<indieweb-person first-name="Ian" last-name="Linkletter" url="https://libguides.bcit.ca/prf.php?id=2c1673be-7cd6-11ed-8528-0266e2e2286e" itemprop="author">}}{{</mention-work>}}. This forces students with original papers to adjust their writing styles, distancing themselves from <abbr>LLM</abbr> stylometric fingerprints.n Nn-native English speakers find this especially hard.

### BLEXBot


Product tokens
: `BLEXBot`

Reason
: An intersection of adtech and search engine optimization. The mention of detecting <q>legal issues</q> on the page was also concerning.

Information
: [BLEXBot information page (unencrypted, no TLS)](http://webmeup-crawler.com/)
: [Archive of BLEXBot information page (with TLS)](https://web.archive.org/web/20241112175427/http://webmeup-crawler.com/)
: Relevant quote: <q cite="http://webmeup-crawler.com/">BLEXBot assists internet marketers to get information on the link structure of sites and their interlinking on the web, to avoid any technical and possible legal issues and improve overall online experience.</q>

Commentary
: This one doesn't seem too major, compared to the others. I might have over-reacted.

### CheckMark Network's crawler


Product tokens
: `CheckMarkNetwork/1.0 (+https://www.checkmarknetwork.com/spider.html)`

Reason
: Intellectual property snitch

Information
: {{<mention-work itemtype="Article">}}{{<cited-work url="https://www.checkmarknetwork.com/spider.html/" name="Crawler Policy – CheckMark Network" extraName="headline">}}{{</mention-work>}}
: Relevant homepage quotes: <q cite="https://www.checkmarknetwork.com/">We provide comprehensive trademark monitoring and specialized watch packages in all jurisdictions.</q> and <q cite="https://www.checkmarknetwork.com/">The Internet is just way too big to effectively police alone.</q>

Commentary
: The product token is awful. It should just be `CheckMarkNetwork`, a subset of the User-Agent string excluding variable version indicators and URLs.

### BrandVerity


Product tokens
: `BrandVerity/1.0`

Reason
: Intellectual property snitch

Information
: {{<mention-work itemtype="Article">}}{{<cited-work url="https://www.brandverity.com/why-is-brandverity-visiting-me" name="Why Is Brandverity Visiting Me" extraName="headline">}}{{</mention-work>}} \[sic\]
: {{<mention-work itemtype="Article">}}{{<cited-work url="https://www.brandverity.com/products/paid-search-monitoring/" name="Paid Search (PPC) Monitoring Tools & Software" extraName="headline">}}{{</mention-work>}}
: Relevant homepage quote: <q cite="https://www.brandverity.com/">Maximize CTRs and minimize CPCs by identifying and removing harmful ads from appearing on your most popular branded keywords. Protect your affiliate channel from abuse by policing and taking down unauthorized ads.</q>

### PiplBot


Product tokens
: `PiplBot`

Reason
: Invasive background checks

Information
: {{<mention-work itemtype="Article">}}{{<cited-work url="https://pipl.com/bot" name="PiplBot" extraName="headline">}}{{</mention-work>}}
: {{<mention-work itemtype="Article">}}{{<cited-work url="https://pipl.com/why-pipl" name="Why Pipl" extraName="headline">}}{{</mention-work>}}
: Relevant quote: <q cite="https://pipl.com/why-pipl">Pipl assembles online identity information from multiple independent sources to create the most complete picture of a digital identity and connect it to real people and their offline identity records. When all the fragments of online identity data are collected, connected, and corroborated, the result is a more trustworthy identity.</q>

### OpenAI <abbr>GenAI</abbr> training-data scrapers


Product tokens
: `GPTBot`

Reason
: <abbr>GenAI</abbr> training-data scraper

Information
: {{<mention-work itemtype="Article">}}{{<cited-work url="https://platform.openai.com/docs/bots" name="Overview of OpenAI Crawlers" extraName="headline">}}{{</mention-work>}}
: Relevant quote: <q cite="https://platform.openai.com/docs/bots">GPTBot is used to make our generative AI foundation models more useful and safe. It is used to crawl content that may be used in training our generative AI foundation models. Disallowing GPTBot indicates a site’s content should not be used in training generative AI foundation models.</q>

Commentary
: The other two bots listed, `OAI-SearchBot` and `ChatGPT-User`, aren't used for training <abbr>LLMs</abbr>. If you don't want your work to train an OpenAI <abbr>LLM</abbr>, blocking them won't accomplish that. It could serve as a form of protest against the company.

### Google-Extended


Product tokens
: `Google-Extended`

Reason
: <abbr>GenAI</abbr> training-data opt-out signal, not an actual bot

Information
: {{<mention-work itemtype="Article">}}{{<cited-work url="https://developers.google.com/search/docs/crawling-indexing/google-common-crawlers" name="Google’s common crawlers" extraName="headline">}}{{</mention-work>}}
: Relevant quote: <q cite="https://developers.google.com/search/docs/crawling-indexing/google-common-crawlers">`Google-Extended` is a standalone product token that web publishers can use to manage whether their sites help improve Gemini Apps and Vertex AI generative APIs, including future generations of models that power those products. Grounding with Google Search on Vertex AI does not use web pages for grounding that have disallowed Google-Extended. Google-Extended does not impact a site's inclusion or ranking in Google Search.</q>

### Applebot-Extended


Product tokens
: `Applebot-Extended`

Reason
: <abbr>GenAI</abbr> training-data opt-out signal, not an actual bot

Information
: {{<mention-work itemtype="Article">}}{{<cited-work url="https://support.apple.com/en-us/119829#datausage" name="About Applebot" extraName="headline">}}{{</mention-work>}}
: Relevant quote: <q cite="https://support.apple.com/en-us/119829">With Applebot-Extended, web publishers can choose to opt out of their website content being used to train Apple’s foundation models powering generative AI features across Apple products, including Apple Intelligence, Services, and Developer Tools.</q>

### Anthropic's ClaudeBot


Product tokens
: `ClaudeBot`

Reason
: <abbr>GenAI</abbr> training-data scraper

Information
: {{<mention-work itemtype="Article">}}{{<cited-work url="https://support.anthropic.com/en/articles/8896518-does-anthropic-crawl-data-from-the-web-and-how-can-site-owners-block-the-crawler" name="Does Anthropic crawl data from the web, and how can site owners block the crawler?" extraName="headline">}}{{</mention-work>}}

Commentary
: Anthropic AI was _extremely late_ in posting <span translate="no">robots.txt</span> guidance, after it already scraped plenty of data. It does seem well-behaved now.

### Meta <abbr>GenAI</abbr> training-data scrapers


Product tokens
: `FacebookBot`
: `Meta-ExternalAgent`

Reason
: <abbr>GenAI</abbr> training-data scraper.
: Extreme lack of trust in Meta/Facebook.

Information
: {{<mention-work itemtype="Article">}}{{<cited-work url="https://developers.facebook.com/docs/sharing/webmasters/web-crawlers" name="Meta Web Crawlers" extraName="headline">}}{{</mention-work>}}
: {{<mention-work itemtype="Article">}}{{<cited-work url="https://developers.facebook.com/docs/sharing/bot/" name="About FacebookBot" extraName="headline">}}{{</mention-work>}}
: Relevant quotes: <q cite="https://developers.facebook.com/docs/sharing/webmasters/web-crawlers">The Meta-ExternalAgent crawler crawls the web for use cases such as training AI models or improving products by indexing content directly.</q> and <q cite="https://developers.facebook.com/docs/sharing/bot/">FacebookBot crawls public web pages to improve language models for our speech recognition technology.</q>

Commentary
: `FacebookBot` used to be the opt-out signal for <abbr>GenAI</abbr> data scraping. After hundreds of sites opted out, Meta quietly introduced `Meta-ExternalAgent` as their new <abbr>GenAI</abbr> data scraping product token and dropped <abbr>GenAI</abbr> from their descrption of `FacebookBot`. This effectively required everyone to learn how to opt-out once again; in that time, they scraped plenty of sites that had previously opted out. I block both product tokens for good measure.

### Cotoyogi


Product tokens
: `Cotoyogi`

Reason
: <abbr>GenAI</abbr> training-data scraper

Information
: [Bot info page](https://ds.rois.ac.jp/center8/crawler/)
: [Parent page indicates it builds <abbr>LLMs</abbr> from the data](https://ds.rois.ac.jp/center8/)

### Webz.io


Product tokens
: `Webzio-extended`

Reason
: <abbr>GenAI</abbr> training-data opt-out signal, not an actual bot

Information
: {{<mention-work itemtype="Article">}}{{<cited-work url="https://webz.io/bot.html" name="An Overview of the Webz.io Duo of Crawlers" extraName="headline">}}{{</mention-work>}}
: Relevant quote: <q cite="https://webz.io/bot.html">This bot takes things a step further. It analyzes your content to see if you’ve indicated it’s forbidden for AI usage, letting big data applications know if the data is allowed for AI purposes. This indicator will be clearly marked on the data itself and reflected in our Terms of Service.</q>

### Kangaroo Bot


Product tokens
: `Kangaroo Bot`

Reason
: <abbr>GenAI</abbr> training-data scraper

Information
: {{<mention-work itemtype="Article">}}{{<cited-work url="https://kangaroollm.com.au/kangaroo-bot/" name="Kangaroo Bot: Powering Australia's AI Data Collection" extraName="headline">}}{{</mention-work>}}

### Open Web Search GenAI-targeted opt=out


Product tokens
: `GenAI`

Reason
: <abbr>GenAI</abbr> training-data opt-out signal, not an actual bot

Information
: {{<mention-work itemtype="Article">}}{{<cited-work url="https://openwebsearch.eu/owler/" name="Owler - Open Web Search" extraName="headline">}}{{</mention-work>}}
: Relevant quote: <q cite="https://openwebsearch.eu/owler/#owler-opt-out">we also support the user-agent identifier GenAI, representing any data use for the purposes of training generative AI models...OpenWebSearch.EU forwards any information about the publishers' usage preferences to the users of our web index and all additional data products we publish through an INDEX as well as a GENAI Metadata field, both represented as boolean values.</q>

Commentary
: I'm actually a fan of the Open Web Search project. It's important to have open indexes of the Web such as the Common Crawl and Open Web Search for projects like upstart search engines, and for research. This is a signal visible to all users of the Open Web Search project's index indicating that I don't want to train <abbr>GenAI</abbr>. I very much want Owler to visit my site!

## Certain Semrush product tokens


Product tokens
: `SemrushBot-OCOB`
: `SemrushBot-FT`

Reason
: Intellectual property snitch.
: <abbr>LLM</abbr>-based slop generation tool I do not wish to support.

Information
: {{<mention-work itemtype="Article">}}{{<cited-work url="https://www.semrush.com/bot/" name="SemrushBot" extraName="headline">}}{{</mention-work>}}
: Relevant quote: <q cite="https://www.semrush.com/bot/">block SemrushBot-OCOB from crawling your site for ContentShake AI tool</q> and <q cite="https://www.semrush.com/bot/">block SemrushBot-FT from crawling your site for Plagiarism Checker and similar tools</q>

## Velen


Product tokens
: `VelenPublicWebCrawler`

Reason
: <abbr>GenAI</abbr> training-data scraper

Information
: {{<mention-work itemtype="Article">}}{{<cited-work url="https://velen.io/" name="Velen Crawler" extraName="headline">}}{{</mention-work>}}
: Relevant quote: <q cite="https://velen.io/">Our goal with this crawler is to build business datasets and machine learning models to better understand the web.</q>

## Historical bots I might not block

It's harmless to block these, but I might stop including some of these lest others cargo-cult obsolete entries.

### NPBot


Product tokens
: `NPBot`

Reason
: Intellectual property snitch.

Information
: [Archived NameProtect bot info page](https://web.archive.org/web/20031008144550/http://nameprotect.com/botinfo.html)

### SlySearch/iThenticate


Product tokens
: `SlySearch`

Reason
: A predecessor of TurnItInBot.

Information
: [Archived copy of SlySearch homepage](https://web.archive.org/web/20060207051223/http://www.slysearch.com:80/static/home.html).

## Bots I ban with User-Agent rules

These robots either don't respect <span translate="no">robots.txt</span>, have a history of disrespecting it, or have a sufficiently bad reputation. I withheld some entries that I block for more personal reasons. I use case-insensitive regular expression rules to ban their traffic on the server/reverse-proxy level.

Be aware that version numbers in User-Agent strings may change.

{{<codefigure>}}{{<codecaption lang="nginx">}}

In my Nginx configs, I set the `$blocked_agent` variable on bad user agents. A safe `if` directive against `$blocked_agent` returns a 403 HTTP error. Here's a tiny sample of how I set `$blocked_agent` in the `http` context:

{{</codecaption>}}

```figure
map $http_user_agent $blocked_agent {
  default                           0;
  ~*(?:ai[0-9]bot|allenai\.org)     1;
  ~*(?:chatglm.spider|chatglm\.cn)  1;
}
```

{{</codefigure>}}

### ChatGLM


User-Agent strings
: <samp>Mozilla/5.0 (compatible; ChatGLM-Spider/1.0; +https://chatglm.cn/)</samp>

Information
: [Official ChatGLM website](https://chatglm.cn/)

Regex filter
: `chatglm.spider|chatglm\.cn`

Commentary
: Only hit my site twice. No documentation on <span translate="no">robots.txt</span> compliance.

### Ai2Bot


User-Agent strings
: <samp>Mozilla/5.0 (compatible) AI2Bot (+https://www.allenai.org/crawler)</samp>
: <samp>Mozilla/5.0 (compatible) Ai2Bot-Dolma (+https://www.allenai.org/crawler)</samp>

Information
: {{<mention-work itemtype="Article">}}{{<cited-work url="https://allenai.org/crawler" name="Crawling notice | Ai2" extraName="headline">}}{{</mention-work>}}
: Relevant quotes: <q cite="https://allenai.org/crawler">The AI2 Bot explores certain domains to find web content. This web content is used to train open language models</q> and <q cite="https://allenai.org/crawler">This user agent string can be used to filter or reject traffic from our crawler if desired.</q>

Regex filter
: `ai[0-9]bot|allenai\.org`

Commentary
: This robot used a _slightly_ different User-Agent string to reach my site than the one advertised on the crawling notice (I saw a <samp>-Dolma</samp> suffix in my logs).

## FriendlyCrawler


User-Agent strings
: <samp>Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/605.1.15 (KHTML, like Gecko; compatible; FriendlyCrawler/1.0) Chrome/120.0.6099.216 Safari/605.1.15</samp>

Information
: {{<mention-work itemtype="BlogPosting">}}{{<cited-work url="https://imho.alex-kunz.com/2024/01/25/an-update-on-friendly-crawler/" name="An Update on FriendlyCrawler" extraName="headline">}} by {{<indieweb-person first-name="Alexander" last-name="Kunz" url="https://www.alex-kunz.com/contact/" itemprop="author">}}{{</mention-work>}} has good coverage of this bot.

## PerplexityBot


User-Agent strings
: <samp>Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; PerplexityBot/1.0; +https://docs.perplexity.ai/docs/perplexity-bot)</samp>

Product tokens
: `PerplexityBot`

Information
: {{<mention-work itemtype="Article">}}{{<cited-work url="https://www.perplexity.ai/hub/technical-faq/how-does-perplexity-follow-robots-txt" name="How does Perplexity follow robots.txt?" extraName="headline">}}{{</mention-work>}}

Commentary
: {{<mention-work itemtype="BlogPosting">}}{{<indieweb-person itemprop="author" first-name="Robb" last-name="Knight" url="https://rknight.me/">}} wrote {{<cited-work url="https://rknight.me/blog/perplexity-ai-is-lying-about-its-user-agent/" name="Perplexity AI Is Lying about Their User Agent" extraName="headline">}}{{</mention-work>}}, disobeying <span translate="no">robots.txt</span> in the process too. {{<mention-work itemtype="NewsArticle">}}<a itemscope="" itemtype="https://schema.org/Organization" itemprop="publisher" href="https://www.wired.com/">WIRED</a> confirmed these findings in {{<cited-work url="https://www.wired.com/story/perplexity-is-a-bullshit-machine/" name="Perplexity Is a Bullshit Machine">}}{{</mention-work>}}.

  Perplexity doesn't train new <abbr>LLMs</abbr>, but it has lost enough of my trust.

## Exceptions: scrapers I allow, despite meeting some block-criteria

### AdsBot

Advertising-averse webmasters often block Google's AdsBot and its cousins. I allow it, but place the following [well-known resources](https://en.wikipedia.org/wiki/Well-known_URI) in my site's root:

- `/ads.txt`
- `/app-ads.txt` (possibly redundant)

These files contain the list of authorized ad sellers for a domain. I use a standard placeholder to declare that there exist _no_ authorized ad sellers for `seirdy.one`. Any client-side malware that injects ads into my site won't make money via ad networks adhering to this specification.

{{<codefigure>}}{{<codecaption lang="text">}}

These are the contents of my `/ads.txt` and `/app-ads.txt`.

{{</codecaption>}}

```figure
placeholder.example.com, placeholder, DIRECT, placeholder
```

{{</codefigure>}}

You can read more in the ads.txt specification on {{<mention-work itemtype="Article">}}{{<cited-work url="https://iabtechlab.com/ads-txt/" name="Ads.txt - Authorized Digital Sellers" extraName="headline">}} by the <span itemscope="" itemprop="publisher" itemtype="https://schema.org/Organization"><abbr title="International Advertising Bureau">IAB</abbr> Tech Lab</span>{{</mention-work>}}. I learned about this technique via [an article from GrapheneOS describing their use of `/ads.txt`](https://grapheneos.org/articles/sitewide-advertising-industry-opt-out).

### CCBot and Owler

I allow CCBot, the robot powering [Common Crawl](http://commoncrawl.org/). Common Crawl crawls the web to build a public index that anybody can use. People often use it for research; the [Web Data Commons](https://webdatacommons.org/) is my favorite example. People also use it to build new search engines, since building an index is one of the hardest parts of starting one: [Alexandria and initial versions of Stract]({{<relref "/posts/search-engines-with-own-indexes/#smaller-indexes-or-less-relevant-results">}}) use the Common Crawl as their index (Stract has since switched to its own crawler).

Ever since Google used Common Crawl to power initial versions of Bard's <abbr>LLM</abbr> (later renamed to Gemini, Google's brand name shared across all its generative-AI products), many sites started to block CCBot in their <span translate="no">robots.txt</span> file. I understand why: an open index for anybody to use also invites use for <abbr>LLM</abbr> training, so sites blocking <abbr>LLM</abbr> training-data scrapers would want to block CCBot. I personally find the non-<abbr>GenAI</abbr> utility of Common Crawl too large to ignore.

The Open Web Search Project [shares similar goals with Common Crawl](https://openwebsearch.eu/common-goals-with-common-crawl/), so I allow [their "Owler" crawler](https://openwebsearch.eu/owler/) for similar reasons. I block their `GenAI` product token only to add metadata to their data set indicating to users that I'm opting out of <abbr>GenAI</abbr> training.

### Some <abbr>SEO</abbr> crawlers: MJ12bot, AhrefsBot, etc.

I frown on most Search Engine Optimization (<abbr>SEO</abbr>) services, given how they've contributed to turning the most reachable Web pages into "content" that optimizes for ranking well on search algorithms at the cost of having genuine, useful writing that shows a love for a topic. I call this phenomenon [the "Living Dead Internet Theory"]({{<relref "/notes/living-dead-internet-theory/">}}). I still permit most <abbr>SEO</abbr> crawlers, though.

Many of them have other uses. MJ12bot powers Majestic's web index, which Majestic uses for [historical exploration](https://blog.majestic.com/company/new-15-year-plus-historic-index/), a (now offline?) search engine, and [The Majestic Million](https://majestic.com/reports/majestic-million). The Majestic Million also partially powers [Tranco](https://tranco-list.eu/), which in turn supports a large body of research. Ahrefs is another <abbr>SEO</abbr> company that uses AhrefsBot to find <abbr>SEO</abbr> backlinks, but also started using its index for the Yep.com search engine.

For the ones that don't have other uses, **I don't have an issue with backlink-finding. I have issues with other <abbr>SEO</abbr> tools,** such as keyword research and analytics to optimize "content" for engagement rather than to write about what an author feels like sharing.[^2] My understanding is that crawling mostly powers backlink-finding.

### <abbr>LLM</abbr> clients

<abbr>GenAI</abbr> companies use these bots to power <abbr>LLM</abbr>-based tools. They don't _train_ <abbr>GenAI</abbr> but function as clients _of_ <abbr>LLMs</abbr> to e.g. fetch search results. These include:

- `cohere-ai`
- OpenAI's `OAI-SearchBot`, `ChatGPT-User`
- `YouBot` of You.com. I am not sure about this one.

## To-do

I need to investigate Diffbot. It fetches data for a commercial dataset useful for <abbr>LLM</abbr> training; it also powers article extraction for services such as Instapaper. I need to weigh the range of its uses as I did for CCBot before I make a decision.

I should invest more time thinking about bots that don't fit my current criteria but aren't well-behaved (too many requests, not obeying robot directives such as `X-Robots` or robots.txt). Even if my site can weather their load, I should still use this page to alert others about them if possible.

<section role="doc-conclusion">

## Conclusion

I hope this helps more webmasters learn not just about certain bots worth blocking, but also about the nuance involved. I split things across <span translate="no">robots.txt</span>, `X-Robots`, and banned User-Agent strings in my server configs. I allow certain often-blocked bots to slip through.

</section>

<section role="doc-acknowledgments">

## Ack&shy;nowledge&shy;ments and other resources {#acknowledgements}

I found most bots via my server logs, but some third party collections proved helpful.


[Dark Visitors](https://darkvisitors.com/)
: I don't recommend using this as an authoritative source, as it's not terribly detailed and invests little nuance in each entry's explanation. Several inaccurate entries and false-positives exist. Still, Dark Visitors is useful resource for anybody willing to fact-check what they find.

[ai.robots.txt](https://github.com/ai-robots-txt/ai.robots.txt)
: Like Dark Visitors, this is a repository of information about GenAI-related robots with some inaccuracies and false-positives. Fact-check any findings before accepting them.

[Matomo's Device Detector repository](https://github.com/matomo-org/device-detector)
: Browsing Device Detector's `bots.yml` using `yq` helped me learn about a few entries.

[Cloudflare Verified Bots](https://radar.cloudflare.com/traffic/verified-bots)
: I don't recall actually discovering a bot to block via Cloudflare Radar, but I'm linking it here as it's a helpful bot catalog in general. Be aware of errors in its bot categorization. Several bots listed under "AI Crawler" aren't actually training or even related to <abbr>GenAI</abbr>. Some "Search Engine Crawler" entries are non-crawling scrapers that only fetch favicons for search results. This is a good starting point for further research if you fact-check entries yourself.

Helpful individuals
: Thanks to {{<indieweb-person itemprop="mentions" name="jmjl" url="https://tilde.green/~jmjl/">}} for pointing me out to the Open Web Search adding a `GenAI` product token for opting out of <abbr>GenAI</abbr> training.

</section>


[^1]: I also got some secondhand embarrassment from some sites that copied my <span translate="no">robots.txt</span> file verbatim, even preserving _my_ sitemap URL at the end!

[^2]: I know "not all analytics" optimize engagement. Not all analytics are problematic for the same reason; different kinds of analytics are problematic for different reasons.



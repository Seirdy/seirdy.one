---
date: "2021-03-10T12:51:06-08:00"
description: "A cursory review of all the non-metasearch, indexing search engines I have been able to find."
outputs:
    - html
    - gemtext
tags:
    - web
footnote_heading: Notes
title: A look at search engines with their own indexes
---
This is a cursory review of all the indexing search engines I have been able to find.

The three dominant English search engines with their own indexes[^1] are Google, Bing, and Yandex (<abbr title="Google, Bing, Yandex">GBY</abbr>). Many alternatives to GBY exist, but almost none of them have their own results; instead, they just source their results from GBY.

With that in mind, I decided to test and catalog all the different indexing search engines I could find. I prioritized breadth over depth, and encourage readers to try the engines out themselves if they'd like more information.

I primarily evaluated English-speaking search engines because that's my primary language. With some difficulty, I could probably evaluate a Spanish one; however, I wasn't able to find many Spanish-language engines powered by their own crawlers.

This page is a "living document" that I plan on updating indefinitely. Check for updates once in a while if you find this page interesting. Feel free to send me suggestions, updates, and corrections; I'd especially appreciate help from those who speak languages besides English and can evaluate a non-English indexing search engine. Contact info is in the article footer.

Rationale
---------

Google, Microsoft (the company behind Bing), and Yandex aren't just search engine companies; they're content and ad companies as well. For example, Google hosts video content on YouTube and Microsoft hosts social media content on LinkedIn. This gives these companies a powerful incentive to prioritize their own content. They are able to do so even if they claim that they treat their own content the same as any other: since they have complete access to their search engines' inner workings, they can tailor their content pages to better fit their algorithms and tailor their algorithms to work well on their own content. They can also index their own content without limitations but throttle indexing for other crawlers.[^2]

One way to avoid this conflict of interest is to _use search engines that aren't linked to major content providers;_ i.e., use engines with their own independent indexes.

There's also a practical, non-ideological reason to try other engines: different providers have different results. Websites that are hard to find on one search engine might be easy to find on another, so using more indexes and ranking algorithms results in access to more content.

Methodology
-----------

I focused almost entirely on "organic results" (the classic link results), and didn't focus too much on (often glaring) privacy issues, "enhanced" or "instant" results (e.g. Wikipedia sidebars, related searches, Stack Exchange answers), or other elements.

I compared results for esoteric queries side-by-side; if the first 20 results were (nearly) identical to another engine's results (though perhaps in a slightly different order), they were likely sourced externally and not from an independent index.

I tried to pick queries that should have a good number of results and show variance between search engines. An incomplete selection of queries I tested:

- "vim", "emacs", "neovim", and "nvimrc": Search engines with relevant results for "nvimrc" typically have a big index. Finding relevant results for the text editors "vim" and "emacs" instead of other topics that share the name is a challenging task.
- "vim cleaner": should return results related to a [line of cleaning products](https://en.wikipedia.org/wiki/Vim_%28cleaning_product%29) rather than the Correct Text Editor.
- "Seirdy": My site is relatively low-traffic, but my nickname is pretty unique and visible on several of the highest-traffic sites out there.
- "Project London": a small movie made with volunteers and <abbr title="Free, Libre, Open-Source Software">FLOSS</abbr> without much advertising. If links related to the movie show up, the engine's really good.
- "oppenheimer": a name that could refer to many things. Without context, it should refer to the physicist who worked on the atomic bomb in Los Alamos. Other historical queries: "magna carta" (intermediate), "the prince" (very hard).

General indexing search-engines
-------------------------------

### Large indexes, good results

These are large engines that pass all the above tests and more.

- Google: the biggest index. Allows submitting pages and sitemaps for crawling, but requires login. Powers a few other engines:
  - Startpage
  - (discontinued) Runnaroo
  - SAPO (Portuguese interface, can work with English results)
- Bing: the runner-up. Allows submitting pages and sitemaps for crawling, but requires login. Its index powers many other engines:
  - Yahoo
  - DuckDuckGo[^3]
  - AOL
  - Qwant[^4]
  - Ecosia
  - Ekoru
  - Privado
  - Findx
  - Disconnect Search[^5]
  - PrivacyWall
  - Lilo
  - SearchScene
  - Peekier
  - Oscobo
  - Million Short
  - Yippy search[^6]
  - Lycos
  - Givero
  - Swisscows
  - Ask.moe[^7]
  - Partially powers MetaGer by default; this can be turned off
  - At this point, I stopped adding Bing-based search engines. There are just too many.
- Yandex: originally a Russian search engine, it now has an English version. Some Russian results bleed into its English site. Allows submitting pages and sitemaps for crawling, but requires login. Powers:
  - Epic Search (went paid-only as of June 2021)
  - Occasionally powers DuckDuckGo's link results instead of Bing.
- Mojeek: Claims to be privacy-oriented. Quality isn’t at Google/Bing/Yandex’s level, but it’s not bad either. If I had to use Mojeek as my default general search engine, I’d live. Partially powers [eTools.ch](https://www.etools.ch/).
- [Petal Search](https://petalsearch.com/). A search engine by Huawei that recently switched from searching for Android apps to general search in order to reduce dependence on Western search providers. Despite its surprisingly good results, I wouldn't recommend it due to privacy concerns. Requires an account to submit sites. I discovered this via my access logs. Be aware that in some jurisdictions, it doesn't use its own index: in Russia and some EU regions it uses Yandex and Qwant, respectively.

### Smaller indexes, relevant results

These engines pass most of the tests listed in the "methodology" section.

- [Right Dao](https://rightdao.com): very fast, good results. Passes the tests fairly well. It plans on including query-based ads if/when its user base grows.[^8]
- [Gigablast](https://gigablast.com/): It's been around for a while and also sports a classic web directory. Searches are a bit slow, and it charges to submit sites for crawling. It powers [Private.sh](https://private.sh). Gigablast is tied with Right Dao for quality.
- [Gowiki](https://gowiki.com): Very young, small index, but shows promise. I discovered this in the seirdy.one access logs. Currently only available in the US.

### Smaller indexes, hit-and-miss

These engines fail badly at a few important tests. Otherwise, they seem to work well enough.

- [seekport](http://www.seekport.com/): The interface is in German but it supports searching in English just fine. The default language is selected by your locale. It's really good considering its small index; it hasn't heard of less common terms (e.g. "Seirdy"), but it's able to find relevant results in other tests.
- [Exalead](https://www.exalead.com/search/): slow, quality is hit-and-miss. Its indexer claims to crawl the DMOZ directory, which has since shut down and been replaced by the [Curlie](https://curlie.org) directory. No relevant results for "Oppenheimer" and some other history-related queries. Allows submitting individual URLs for indexing, but requires solving a Google reCAPTCHA and entering an email address.
- [ExactSeek](https://www.exactseek.com/): small index, disproportionately dominated by big sites. Failed multiple tests. Allows submitting individual URLs for crawling, but requires entering an email address and receiving a newsletter. Webmaster tools seem to heavily push for paid <abbr title="search-engine optimization">SEO</abbr> options. It also powers SitesOnDisplay and [Blog-search.com](https://blog-search.com).
- [Meorca](https://meorca.com/): a search engine that claims not to "index pornography or illegal content websites". It also features a public blog with a marketplace and free games. Allows submitting URLs, but requires a full name, email, phone number, and "business name" to do so. Discovered in the seirdy.one access logs.
- [Infotiger](https://alpha.infotiger.com/): Allows choosing between multiple different sorting algorithms (date, text length, PageRank, and "AND"). Supports English and German. The legacy version allows submitting links via a web-form or email, but I don't know if that has an impact on the more recent alpha version.
- [search.tl](http://www.search.tl/): Generalist search for one <abbr title="top-level domain">TLD</abbr> at a time (defaults to .com). I'm not sure why you'd want to always limit your searches to a single TLD, but now you can.[^9] There isn't any visible UI for changing the TLD for available results; you need to add/change the `tld` URL parameter. For example, to search .org sites, append `&tld=org` to the URL. It seems to be connected to [Amidalla](http://www.amidalla.de/), but Amidalla doesn't seem to currently be operational. Amidalla allows users to manually add URLs to its index and directory; I have yet to see if doing so impacts search.tl results.
- [Kozmonavt](https://kozmonavt.ml/): Has a small index of almost 5 million sites. If I want to find the website for a certain project, Kozmonavt works well (provided its index has crawled said website). It works poorly for learning things and finding general information. I cannot recommend it for anything serious since it lacks contact information, a privacy policy, or any other information about the org/people who made it. Discovered in the seirdy.one access logs.
- Burf.co: Very small index, but seems fine at ranking more relevant results higher. Allows site submission without any extra steps. Down as of late June 2021.
- [ChatNoir](https://www.chatnoir.eu/): An experimental engine by researchers that uses the [Common Crawl](https://commoncrawl.org/) index. The engine is [open source](https://github.com/chatnoir-eu). See the [announcement](https://groups.google.com/g/common-crawl/c/3o2dOHpeRxo/m/H2Osqz9dAAAJ) on the Common Crawl mailing list (Google Groups).

### Unusable engines, irrelevant results

Results from these search engines don't seem at all useful.

- YaCy: community-made index; slow. Results are awful/irrelevant, but can be useful for intranet or custom search.
- Scopia: only seems to be available via the [MetaGer](https://metager.org) metasearch engine after turning off Bing and news results. Tiny index, very low-quality.
- [Active Search Results](https://www.activesearchresults.com): very poor quality
- [Crawlson](https://crawlson.com): young, slow. In this category because its index has a cap of 10 URLs per domain. I initially discovered Crawlson in the seirdy.one access logs.
- [Anoox](https://www.anoox.com/): Results are few and irrelevant; fails to find any results for basic terms. Allows site submission. It's also a lightweight social network and claims to be powered by its users, letting members vote on listings to alter rankings.
- [Yioop!](https://www.yioop.com): A FLOSS search engine that boasts a very impressive [feature-set](https://www.seekquarry.com/): it can parse sitemaps, feeds, and a variety of markup formats; it can import pre-curated data in forms such as access logs, Usenet posts, and WARC archives; it also supports feed-based news search. Despite the impressive feature set, Yioop's results are few and irrelevant due to its small index. It allows submitting sites for crawling. Like Meorca, Yioop has social features such as blogs, wikis, and a chat bot API.

### Semi-independent indexes

Engines in this category fall back to GBY when their own indexes don't have enough results. As their own indexes grow, they claim that this should happen less often.

- [Brave Search](https://search.brave.com/): Many tests (including all the tests I listed in the "Methodology" section) resulted results identical to Google, revealed by a side-by-side comparison with Google, Startpage, and a Searx instance with only Google enabled. Brave claims that this is due to how Cliqz (the discontinued engine acquired by Brave) used query logs to build its page models and was optimized to match Google.[^10] The index is independent, but optimizing against Google resulted in too much similarity for the real benefit of an independent index to show.
- [Plumb](https://plumb.one/): Almost all queries return no results; when this happens, it falls back to Google. It's fairly transparent about the fallback process, but I'm concerned about _how_ it does this: it loads Google's Custom Search scripts from `cse.google.com` onto the page to do a client-side Google search. This can be mitigated by using a browser addon to block `cse.google.com` from loading any scripts. Plumb claims that this is a temporary measure while its index grows, and they're planning on getting rid of this. Allows submitting URLs, but requires solving an hCaptcha. This engine is very new; hopefully as it improves, it could graduate from this section. Its Chief Product Officer [previously founded](https://archive.is/oVAre) the Gibiru search engine which shares the same affiliates and (for now) the same index; the indexes will diverge with time.
- [Neeva](https://neeva.com): Combines Bing results with results from its own index. Bing normally isn't okay with this, but Neeva managed to get an agreement with Bing that allowed result-mixing. As of right now, results are mostly identical to Bing but original links not found by Bing frequently pop up. Long and esoteric queries are less likely to feature original results. Requires signing up with an email address to use; after the (rather long) free trial it requires payment as an alternative to ads.

Non-generalist search
---------------------

These indexing search engines don't have a Google-like "ask me anything" endgame; they're trying to do something different.

- Wiby: [wiby.me](https://wiby.me) and [wiby.org](https://wiby.org): I love this one. It focuses on smaller independent sites that capture the spirit of the "early" web. It's more focused on "discovering" new interesting pages that match a set of keywords than finding a specific resources. I like to think of Wiby as an engine for surfing, not searching. Runnaroo occasionally features a hit from Wiby. If you have a small site or blog that isn't very "commercial", consider submitting it to the index.
- [Search My Site](https://searchmysite.net): Similar to Wiby, but only indexes user-submitted personal and independent sites. It optionally supports IndieAuth.
- Quor: Seems to mainly index large news sites. Site is down as of June 2021; originally available at www dot quor dot com.
- [Ninfex](https://ninfex.com/): a "people-powered" search engine that combines aspects of link aggregators and search. It lets users vote on submissions and it also displays links to forums about submissions.

Other languages
---------------

I'm unable to evaluate these engines properly since I don't speak the necessary languages. English searches on these are a hit-or-miss. I might have made a few mistakes in this category.

### Big indexes

- Baidu: Chinese. Very large index; it's a major engine alongside GBY. Offers webmaster tools for site submission.
- Qihoo 360: Chinese. I'm not sure how independent this one is.
- Sogou: Chinese
- Yisou: Chinese
- [Naver](https://search.naver.com): Korean. Allows submitting sitemaps and feeds. Discovered via some Searx metasearch instances.
- [Seznam](https://www.seznam.cz/): Czech, seems relatively privacy-friendly. Discovered in the seirdy.one access logs. It allows site submission with webmaster tools.
- [Cốc Cốc](https://coccoc.com/search): Vietnamese
- [go.mail.ru](https://go.mail.ru/): Russian

### Smaller indexes

- [Parsijoo](https://www.parsijoo.ir/): Persian
- [search.ch](https://search.ch): Regional search engine for Switzerland; users can restrict searches to their local regions.
- [fastbot](https://www.fastbot.de/): German
- [Moose.at](https://www.moose.at): German (Austria-based)

Misc
----

- Ask.com: the main site shut down, but subdomains like [uk.ask.com](https://uk.ask.com) are still alive. They claim to outsource search results. The results seem similar to Google, Bing, and Yandex; however, I can't pinpoint exactly where their results are coming from.
- Not evaluated: Apple's search. It's only accessible through a search widget in iOS and macOS and shows very few results. This might change; see the next section.
- Not evaluated: Kagi Search. It's in a closed beta and I haven't yet gotten an invitation.
- Partially evaluated: [Infinity Search](https://infinitysearch.co): young, small index. It recently split into a paid offering with the main index and [Infinity Decentralized](https://infinitydecentralized.com/), the latter of which allows users to select from community-hosted crawlers. I managed to try it out before it became a paid offering, and it seemed decent; however, I wasn't able to run the tests listed in the "Methodology" section. Allows submitting URLs and sitemaps into a text box, no other work required.

Upcoming engines
----------------

These engines aren't ready yet; their indexes are either in a proof-of-concept phase with a handful of sites, or aren't available yet.

- Apple: given the activity of the AppleBot crawler lately, their index will almost certainly grow to a size large enough to power a general search engine soon. Check your server's access logs; there's a good chance it's crawled your site if you have a few backlinks.

Graveyard
---------

These engines were originally included in the article, but have since been discontinued.

- [wbsrch](https://wbsrch.com/): In addition to its generalist search, it also had many other utilities related to domain name statistics. Failed multiple tests. Its index was a bit dated; it had an old backlog of sites it hadn't finished indexing. It also had several dedicated per-language indexes.

Acknowledgements
----------------

Some of this content came from the [Search Engine Map](https://www.searchenginemap.com/) and [Search Engine Party](https://searchengine.party/). A few web directories also proved useful.

Matt from Gigablast also gave me some helpful information on GBY which I included in the "Rationale" section. He's written more about big tech in the [Gigablast blog](https://gigablast.com/blog.html).

<span class="h-card vcard"><a class="p-name url fn n" href="http://nafmusings.xyz/"><span class="p-given-name given-name">Nicholas</span> A. <span class="p-family-name family-name">Ferrell</span></a></span> of [The New Leaf Journal](https://thenewleafjournal.com/) wrote a [great post](https://thenewleafjournal.com/a-2021-list-of-alternative-search-engines-and-search-resources/) on alternative search engines. He also gave me some [useful details](https://lists.sr.ht/~seirdy/seirdy.one-comments/%3C20210618031450.rb2twu4ypek6vvl3%40rkumarlappie.attlocal.net%3E) about Seznam, Naver, Baidu, and Goo.


[^1]: Yes, "indexes" is an acceptable plural form of the word "index". The word "indices" sounds weird to me outside a math class.

[^2]: Matt from Gigablast told me that indexing YouTube or LinkedIn will get you blocked if you aren't Google or Microsoft. I imagine that you could do so by getting special permission if you're a megacorporation.

[^3]: DuckDuckGo has a crawler called DuckDuckBot. This crawler doesn't impact the linked results displayed; it just grabs favicons and scrapes data for a few instant answers. DuckDuckGo's help pages claim that the engine uses over 400 sources; my interpretation is that at least 398 sources don't impact organic results. I don't think DuckDuckGo is transparent enough about the fact that their organic results are proxied. Compare DuckDuckGo side-by-side with Bing and Yandex and you'll see it's sourcing organic results from one of them (probably Bing).

[^4]: Qwant claims to also use its own crawler for results, but it's still mostly Bing. Try a side-by-side comparison; I found that it doesn't seem to have anything besides Bing results.

[^5]: Disconnect Search allows users to have results proxied from Bing or Yahoo, but Yahoo sources its results from Bing.

[^6]: Yippy claims to be powered by a certain IBM brand (a brand that could correspond to any number of products) and annotates results with the phrase "Yippy Index", but a side-by-side comparison with Bing and other Bing-based engines revealed results to be nearly identical.

[^7]: Ask.moe was working on a [FLOSS indexer](https://git.sr.ht/~danskeren/spider.moe); its search page stated an intention to switch to it from Bing at one point. This statement has since been removed.

[^8]: This is based on a statement Right Dao made in [on Reddit](https://reddit.com/comments/k4clx1/_/ge9dwmh/?context=1) ([archived](https://web.archive.org/web/20210320042457/https://i.reddit.com/r/degoogle/comments/k4clx1/right_dao_a_new_independent_search_engine_that/ge9dwmh/?context=1)).

[^9]: Some search engines support the `site:` search operator to limit searches to subpages/subdomains of a single site or TLD. `site:.one`, for instance, limits searches to websites with the ".one" TLD.

[^10]: More information can be found in [this HN subthread](https://news.ycombinator.com/item?id=27593801) and some posts on the Cliqz tech blog ([one](https://0x65.dev/blog/2019-12-06/building-a-search-engine-from-scratch.html), [two](https://0x65.dev/blog/2019-12-10/search-quality-at-cliqz.html)).



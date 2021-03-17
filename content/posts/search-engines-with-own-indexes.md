---
date: "2021-03-10T12:51:06-08:00"
description: "A cursory review of all the non-metasearch, indexing search engines
    I have been able to find."
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

Methodology
-----------

I mainly evaluated link results, and didn't focus too much on (often glaring) privacy issues, "enhanced" or "instant" results (e.g. Wikipedia sidebars, related searches, Stack Exchange answers), or other elements.

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
  - Runnaroo
  - SAPO (Portuguese interface, can work with English results)
- Bing: the runner-up. Allows submitting pages and sitemaps for crawling, but requires login. Its index powers many other engines:
  - Yahoo
  - DuckDuckGo[^2]
  - AOL
  - Qwant[^3]
  - Ecosia
  - Ekoru
  - Privado
  - Findx
  - Disconnect Search[^4]
  - PrivacyWall
  - Lilo
  - SearchScene
  - Peekier
  - Oscobo
  - Million Short
  - Yippy search[^5]
  - Lycos
  - Givero
  - Swisscows
  - Ask.moe[^6]
  - Partially powers MetaGer by default; this can be turned off
  - At this point, I stopped adding Bing-based search engines. There are just too many.
- Yandex: originally a Russian search engine, it now has an English version. Some Russian results bleed into its English site. Allows submitting pages and sitemaps for crawling, but requires login. Powers:
  - Epic Search
  - Occasionally powers DuckDuckGo's link results instead of Bing.
- Mojeek: Claims to be privacy-oriented. Quality isn't at Google/Bing/Yandex's level, but it's not bad either. If I had to use Mojeek as my default general search engine, I'd live.
- Petal search: [gopetal.com](https://www.gopetal.com/) and [petalsearch.com](https://petalsearch.com/). A very new engine developed by Huawei. Surprisingly good results; it passed all the listed tests. Requires an account to submit sites. I discovered this via my access logs.

### Smaller indexes, relevant results

These engines pass most of the tests listed in the "methodology" section.

- [Right Dao](https://rightdao.com): very fast, good results. Passes the tests fairly well.
- [Gigablast](https://gigablast.com/): It's been around for a while and also sports a classic web directory. Searches are a bit slow, and it charges to submit sites for crawling. It powers [Private.sh](https://private.sh). Gigablast is tied with Right Dao for quality.
- [Gowiki](https://gowiki.com): Very young, small index, but shows promise. I discovered this in the seirdy.one access logs. Currently only available in the US.

### Smaller indexes, hit-and-miss

These engines fail badly at a few important tests.

- [seekport](http://www.seekport.com/): The interface is in German but it supports searching in English just fine. The default language is selected by your locale. It's really good considering its small index; it hasn't heard of less common terms (e.g. "Seirdy"), but it's able to find relevant results in other tests.
- [Exalead](https://www.exalead.com/search/): slow, quality is hit-and-miss. Its indexer claims to crawl the DMOZ directory, which has since shut down and been replaced by the [Curlie](https://curlie.org) directory. No relevant results for "Oppenheimer" and some other history-related queries. Allows submitting individual URLs for indexing, but requires solving a Google reCAPTCHA and entering an email address.
- [wbsrch](https://wbsrch.com/): In addition to its generalist search, it also has many other utilities related to domain name statistics. Failed multiple tests. Its index is a bit dated; it has an old backlog of sites it hasn't finished indexing. It also has several per-language indexes.
- [ExactSeek](https://www.exactseek.com/): small index, disproportionately dominated by big sites. Failed multiple tests. Allows submitting individual URLs for crawling, but requires entering an email address and receiving a newsletter. Webmaster tools seem to heavily push for paid <abbr title="search-engine optimization">SEO</abbr> options.
- [Meorca](https://meorca.com/): a search engine that claims not to "index pornography or illegal content websites". It also features a public blog with a marketplace and free games. Allows submitting URLs, but requires a full name, email, phone number, and "business name" to do so. Discovered in the seirdy.one access logs.
- [search.tl](http://www.search.tl/): Generalist search for one <abbr title="top-level domain">TLD</abbr> at a time (defaults to .com). I'm not sure why you'd want to always limit your searches to a single TLD, but now you can.[^7] There isn't any visible UI for changing the TLD for available results; you need to add/change the `tld` URL parameter. For example, to search .org sites, append `&tld=org` to the URL. It seems to be connected to [Amidalla](http://www.amidalla.de/), but Amidalla doesn't seem to currently be operational. Amidalla allows users to manually add URLs to its index and directory; I have yet to see if doing so impacts search.tl results.

### Unusable engines, irrelevant results

Results from these search engines don't seem at all useful.

- YaCy: community-made index; slow. Results are awful/irrelevant, but can be useful for intranet or custom search.
- Scopia: only seems to be available via the [MetaGer](https://metager.org) metasearch engine after turning off Bing and news results. Tiny index, very low-quality.
- [Active Search Results](https://www.activesearchresults.com): very poor quality
- Crawlson: young, slow. In this category because its index has a cap of 10 URLs per domain. I initially discovered Crawlson in the seirdy.one access logs. The site seems to be down right now, so I didn't link it.
- [Anoox](https://www.anoox.com/): Results are few and irrelevant; fails to find any results for basic terms. Allows site submission. It's also a lightweight social network and claims to be powered by its users, letting members vote on listings to alter rankings.

Non-generalist search
---------------------

These indexing search engines don't have a Google-like "ask me anything" endgame; they're trying to do something different.

- Wiby: [wiby.me](https://wiby.me) and [wiby.org](https://wiby.org): I love this one. It focuses on smaller independent sites that capture the spirit of the "early" web. It's more focused on "discovering" new interesting pages that match a set of keywords than finding a specific resources. I like to think of Wiby as an engine for surfing, not searching. Runnaroo occasionally features a hit from Wiby. If you have a small site or blog that isn't very "commercial", consider submitting it to the index.
- [Search My Site](https://searchmysite.net): Similar to Wiby, but only indexes user-submitted personal and independent sites. It optionally supports IndieAuth.
- [Quor](https://www.quor.com): seems to mainly index large news sites.

Other languages
---------------

I'm unable to evaluate these engines properly since I don't speak the necessary languages. English searches on these are a hit-or-miss. I might have made a few mistakes in this category.

### Big indexes

- Baidu: Chinese
- Qihoo 360: Chinese. I'm not sure how independent this one is.
- Sogou: Chinese
- Yisou: Chinese
- [Naver](https://search.naver.com): Korean.
- [Seznam](https://www.seznam.cz/): Czech, seems relatively privacy-friendly. Discovered in the seirdy.one access logs.
- [Cốc Cốc](https://coccoc.com/search): Vietnamese

### Smaller indexes

- [Parsijoo](https://www.parsijoo.ir/): Persian
- [search.ch](https://search.ch): Regional search engine for Switzerland; users can restrict searches to their local regions.
- [fastbot](https://www.fastbot.de/): German
- [Moose.at](https://www.moose.at): German (Austria-based)

Misc
----

- Ask.com: the main site shut down, but subdomains like [uk.ask.com](https://uk.ask.com) are still alive. They claim to outsource search results. The results seem similar to Google, Bing, and Yandex; however, I can't pinpoint exactly where their results are coming from.
- Not evaluated: Apple's search. It's only accessible through a search widget in iOS and macOS and shows very few results. This might change; see the next section.
- Partially evaluated: [Infinity Search](https://infinitysearch.co): young, small index. It recently split into a paid offering with the main index and [Infinity Decentralized](https://infinitydecentralized.com/), the latter of which allows users to select from community-hosted crawlers. I managed to try it out before it became a paid offering, and it seemed decent; however, I wasn't able to run the tests listed in the "Methodology" section. Allows submitting URLs and sitemaps into a text box, no other work required.

Upcoming engines
----------------

These engines aren't ready yet; their indexes are either in a proof-of-concept phase with a handful of sites, or aren't available yet.

- Apple: given the activity of the AppleBot crawler lately, their index will almost certainly grow to a size large enough to power a general search engine soon. Check your server's access logs; there's a good chance it's crawled your site if you have a few backlinks.
- Brave [announced](https://brave.com/search/) that it will start its own independent search engine based on the now-discontinued Cliqz. I don't endorse the company, but I hope its results will be available through metasearch engines like Searx.

Acknowledgements
----------------

Some of this content came from the [Search Engine Map](https://www.searchenginemap.com/) and [Search Engine Party](https://searchengine.party/). A few web directories also proved useful.


[^1]: Yes, "indexes" is an acceptable plural form of the word "index". The word "indices" sounds weird to me outside a math class.

[^2]: DuckDuckGo has a crawler called DuckDuckBot. This crawler doesn't impact the linked results displayed; it just grabs favicons and scrapes data for a few instant answers

[^3]: Qwant claims to also use its own crawler for results, but it's still mostly Bing. Try a side-by-side comparison; I found that it doesn't seem to have anything besides Bing results.

[^4]: Disconnect Search allows users to have results proxied from Bing or Yahoo, but Yahoo sources its results from Bing.

[^5]: Yippy claims to be powered by a certain IBM brand (a brand that could correspond to any number of products) and annotates results with the phrase "Yippy Index", but a side-by-side comparison with Bing and other Bing-based engines revealed results to be nearly identical.

[^6]: Ask.moe was working on a [FLOSS indexer](https://git.sr.ht/~danskeren/spider.moe); its search page stated an intention to switch to it from Bing at one point. This statement has since been removed.

[^7]: Google and Bing support the `site:` search operator to limit searches to subpages/subdomains of a single site, but it can also limit searches to a single TLD. `site:.one`, for instance, limits searches to websites with the ".one" TLD.


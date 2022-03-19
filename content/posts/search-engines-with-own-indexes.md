---
date: "2021-03-10T12:51:06-08:00"
description: "A cursory review of all the non-metasearch, indexing search engines I have been able to find."
outputs:
    - html
    - gemtext
tags:
    - web
sitemap:
    ChangeFreq: daily
    Priority: 0.7
footnote_heading: Notes
title: A look at search engines with their own indexes
---
This is a cursory review of all the indexing search engines I have been able to find.

The three dominant English search engines with their own indexes[^1] are Google, Bing, and Yandex (<abbr title="Google, Bing, Yandex">GBY</abbr>). Many alternatives to GBY exist, but almost none of them have their own results; instead, they just source their results from GBY.

With that in mind, I decided to test and catalog all the different indexing search engines I could find. I prioritized breadth over depth, and encourage readers to try the engines out themselves if they'd like more information.

This page is a "living document" that I plan on updating indefinitely. Check for updates once in a while if you find this page interesting. Feel free to send me suggestions, updates, and corrections; I'd especially appreciate help from those who speak languages besides English and can evaluate a non-English indexing search engine. Contact info is in the article footer.

I plan on updating the engines in the top two categories with more info comparing the structured/linked data the engines leverage (RDFa vocabularies, microdata, microformats, JSON-LD, etc.) to help authors determine which formats to use.

About the list
--------------

I discuss my motivation for making this page in the [Rationale section](#rationale).

I primarily evaluated English-speaking search engines because that’s my primary language. With some difficulty, I could probably evaluate a Spanish one; however, I wasn't able to find many Spanish-language engines powered by their own crawlers.

I mention details like "allows site submissions" and structured data support where I can only to inform authors about their options, not as points in engines' favor.

See the [Methodology section](#methodology) at the bottom to learn how I evaluated each one.

General indexing search-engines
-------------------------------

### Large indexes, good results

These are large engines that pass all my standard tests and more.

- Google: the biggest index. Allows submitting pages and sitemaps for crawling, and [even supports WebSub](https://developers.google.com/search/docs/advanced/sitemaps/build-sitemap#addsitemap) to automate the process. Powers a few other engines:
  - [Startpage](https://www.startpage.com/)
  - [GMX Search](https://search.gmx.com/web)
  - (discontinued) Runnaroo
  - [SAPO](https://www.sapo.pt/) (Portuguese interface, can work with English results)
- Bing: the runner-up. Allows submitting pages and sitemaps for crawling, but requires login. Its index powers many other engines:
  - Yahoo (and its sibling engine, [OneSearch](https://www.yahoo.com/now/verizon-launches-search-engine-onesearch-132901132.html))
  - DuckDuckGo[^2]
  - AOL
  - Qwant (partial)[^3]
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
  - Fireball
  - Ask.moe[^6]
  - Partially powers MetaGer by default; this can be turned off
  - At this point, I mostly stopped adding Bing-based search engines. There are just too many.
- Yandex: originally a Russian search engine, it now has an English version. Some Russian results bleed into its English site. Allows submitting pages and sitemaps for crawling, but requires login. Powers:
  - Epic Search (went paid-only as of June 2021)
  - Occasionally powers DuckDuckGo's link results instead of Bing.
- [Mojeek](https://www.mojeek.com/): Seems privacy-oriented with a large index containing billions of pages. Quality isn't at Google/Bing/Yandex's level, but it’s not bad either. If I had to use Mojeek as my default general search engine, I'd live. Partially powers [eTools.ch](https://www.etools.ch/). At this moment, _I think that Mojeek is the best alternative to GBY_ for general search.
- [Petal Search](https://petalsearch.com/). A search engine by Huawei that recently switched from searching for Android apps to general search in order to reduce dependence on Western search providers. Despite its surprisingly good results, I wouldn't recommend it due to privacy concerns. Requires an account to submit sites. I discovered this via my access logs. Be aware that in some jurisdictions, it doesn't use its own index: in Russia and some EU regions it uses Yandex and Qwant, respectively.

Google, Bing, and Yandex support structured data such as microformats1, microdata, RDFa, Open Graph markup, and JSON-LD. Yandex's support for microformats1 is limited; for instance, it can parse `h-card` metadata for organizations but not people. Open Graph and Schema.org are the only supported vocabularies I'm aware of. Mojeek is evaluating structured data; it's interested in Open Graph and Schema.org vocabularies.

### Smaller indexes, relevant results

These engines pass most of the tests listed in the "methodology" section. All of them seem relatively privacy-friendly.

- [Right Dao](https://rightdao.com): very fast, good results. Passes the tests fairly well. It plans on including query-based ads if/when its user base grows.[^7]
- [Gigablast](https://gigablast.com/): It's been around for a while and also sports a classic web directory. Searches are a bit slow, and it charges to submit sites for crawling. It powers [Private.sh](https://private.sh). Gigablast is tied with Right Dao for quality.
- [Alexandria](https://www.alexandria.org/): A pretty new "non-profit, ad free" engine, with [freely-licensed code](https://github.com/alexandria-org/alexandria). Surprisingly good at finding recent pages. Its index is built from the Common Crawl; it isn't as big as Gigablast or Right Dao but its ranking is great.

### Smaller indexes, hit-and-miss

These engines fail badly at a few important tests. Otherwise, they seem to work well enough.

- [seekport](http://www.seekport.com/): The interface is in German but it supports searching in English just fine. The default language is selected by your locale. It's really good considering its small index; it hasn't heard of less common terms (e.g. "Seirdy"), but it's able to find relevant results in other tests.
- [Exalead](https://www.exalead.com/search/): slow, quality is hit-and-miss. Its indexer claims to crawl the DMOZ directory, which has since shut down and been replaced by the [Curlie](https://curlie.org) directory. No relevant results for "Oppenheimer" and some other history-related queries. Allows submitting individual URLs for indexing, but requires solving a Google reCAPTCHA and entering an email address.
- [ExactSeek](https://www.exactseek.com/): small index, disproportionately dominated by big sites. Failed multiple tests. Allows submitting individual URLs for crawling, but requires entering an email address and receiving a newsletter. Webmaster tools seem to heavily push for paid <abbr title="search-engine optimization">SEO</abbr> options. It also powers SitesOnDisplay and [Blog-search.com](https://blog-search.com).
- [Infotiger](https://alpha.infotiger.com/): A small index that seems to find relevant results. It allows site submission for English and German pages. It also features a "similarity" search to query pages similar to a given link, with mixed results.
- [Kozmonavt](https://kozmonavt.ml/): Has a small index of almost 5 million sites. If I want to find the website for a certain project, Kozmonavt works well (provided its index has crawled said website). It works poorly for learning things and finding general information. I cannot recommend it for anything serious since it lacks contact information, a privacy policy, or any other information about the org/people who made it. Discovered in the seirdy.one access logs.
- [Burf.co](https://burf.co/): Very small index, but seems fine at ranking more relevant results higher. Allows site submission without any extra steps.
- [Entfer](https://entfer.com/): a newcomer that lets registered users upvote/downvote search results to customize ranking. Doesn't offer much information about who made it. Its index is small, but it does seem to return results related to the query.
- [Siik](https://siik.co/): Lacks contact info, and the ToS and Privacy Policy links are dead. Seems to have PHP errors in the backend for some of its instant-answer widgets. If you scroll past all that, it does have web results powered by what seems to be its own index. These results do tend to be somewhat relevant, but the index seems too small for more specific queries.
- [ChatNoir](https://www.chatnoir.eu/): An experimental engine by researchers that uses the [Common Crawl](https://commoncrawl.org/) index. The engine is [open source](https://github.com/chatnoir-eu). See the [announcement](https://groups.google.com/g/common-crawl/c/3o2dOHpeRxo/m/H2Osqz9dAAAJ) on the Common Crawl mailing list (Google Groups).
- [Secret Search Engine Labs](http://www.secretsearchenginelabs.com/): Very small index with very little SEO spam; it toes the line between a "search engine" and a "surf engine". It's best for reading about broad topics that would otherwise be dominated by SEO spam, thanks to its [CashRank algorithm](http://www.secretsearchenginelabs.com/tech/cashrank.php). Allows site submission.

### Unusable engines, irrelevant results

Results from these search engines don't seem at all useful.

- [Bloopish](http://aibull.io/): extremely quick to update its index; site submissions show up in seconds. Unfortunately, its index only contains a few thousand documents (under 100 thousand at the time of writing). It's growing fast: if you search for a term, it'll start crawling related pages and grow its index.
- YaCy: community-made index; slow. Results are awful/irrelevant, but can be useful for intranet or custom search.
- Scopia: only seems to be available via the [MetaGer](https://metager.org) metasearch engine after turning off Bing and news results. Tiny index, very low-quality.
- [Artado Search](https://www.artadosearch.com/): Primarily Turkish, but it also seems to support English results. Like Plumb, it uses client-side JS to fetch results from existing engines (Google, Bing, Yahoo, Petal, and others); like MetaGer, it has an option to use its own independent index. Results from its index are almost always empty. Very simple queries ("twitter", "wikipedia", "reddit") give some answers. Supports site submission and crowdsourced instant answers.
- [Active Search Results](https://www.activesearchresults.com): very poor quality
- [Crawlson](https://crawlson.com): young, slow. In this category because its index has a cap of 10 URLs per domain. I initially discovered Crawlson in the seirdy.one access logs.
- [Anoox](https://www.anoox.com/): Results are few and irrelevant; fails to find any results for basic terms. Allows site submission. It's also a lightweight social network and claims to be powered by its users, letting members vote on listings to alter rankings.
- [Yioop!](https://www.yioop.com): A FLOSS search engine that boasts a very impressive [feature-set](https://www.seekquarry.com/): it can parse sitemaps, feeds, and a variety of markup formats; it can import pre-curated data in forms such as access logs, Usenet posts, and WARC archives; it also supports feed-based news search. Despite the impressive feature set, Yioop's results are few and irrelevant due to its small index. It allows submitting sites for crawling. Like Meorca, Yioop has social features such as blogs, wikis, and a chat bot API.

### Semi-independent indexes

Engines in this category fall back to GBY when their own indexes don't have enough results. As their own indexes grow, some claim that this should happen less often.

- [Brave Search](https://search.brave.com/): Many tests (including all the tests I listed in the "Methodology" section) resulted results identical to Google, revealed by a side-by-side comparison with Google, Startpage, and a Searx instance with only Google enabled. Brave claims that this is due to how Cliqz (the discontinued engine acquired by Brave) used query logs to build its page models and was optimized to match Google.[^8] The index is independent, but optimizing against Google resulted in too much similarity for the real benefit of an independent index to show. Furthermore, many queries have Bing results mixed in; users can click an "info" button to see the percentage of results that came from its own index. The independent percentage is typically quite high (often close to 100% independent) but can drop for advanced queries.
- [Plumb](https://plumb.one/): Almost all queries return no results; when this happens, it falls back to Google. It's fairly transparent about the fallback process, but I'm concerned about _how_ it does this: it loads Google's Custom Search scripts from `cse.google.com` onto the page to do a client-side Google search. This can be mitigated by using a browser addon to block `cse.google.com` from loading any scripts. Plumb claims that this is a temporary measure while its index grows, and they're planning on getting rid of this. Allows submitting URLs, but requires solving an hCaptcha. This engine is very new; hopefully as it improves, it could graduate from this section. Its Chief Product Officer [previously founded](https://archive.is/oVAre) the Gibiru search engine which shares the same affiliates and (for now) the same index; the indexes will diverge with time.
- [Neeva](https://neeva.com): Combines Bing results with results from its own index. Bing normally isn't okay with this, but Neeva is one of few exceptions. As of right now, results are mostly identical to Bing but original links not found by Bing frequently pop up. Long and esoteric queries are less likely to feature original results. Requires signing up with an email address or OAuth to use, and offers a paid tier with additional benefits.
- [Qwant](https://www.qwant.com): Qwant claims to use its own index, but it still relies on Bing for most results. It seems to be in a position similar to Neeva. Try a side-by-side comparison to see if or how it compares with Bing.
- [Kagi Search](https://kagi.com/): The most interesting entry in this category, IMO. Like Neeva, it requires an account; it will eventually require payment. It's powered by its own Teclis index (Teclis can be used independently; see the [non-commercial section](#small-or-non-commercial-web) below), and claims to also use results from Google and Bing. The result seems somewhat unique: I'm able to recognize some results from the Teclis index mixed in with the mainstream ones. In addition to Teclis, Kagi's other products include the [Kagi.ai](https://kagi.ai/) intelligent answer service and the [TinyGem](https://tinygem.org/) social bookmarking service, both of which play a role in Kagi.com in the present or future.

Non-generalist search
---------------------

These indexing search engines don’t have a Google-like “ask me anything” endgame; they’re trying to do something different. You aren't supposed to use these engines the same way you use GBY.

### Small or non-commercial Web

- Wiby: [wiby.me](https://wiby.me) and [wiby.org](https://wiby.org): I love this one. It focuses on smaller independent sites that capture the spirit of the "early" web. It's more focused on "discovering" new interesting pages that match a set of keywords than finding a specific resources. I like to think of Wiby as an engine for surfing, not searching. Runnaroo occasionally features a hit from Wiby. If you have a small site or blog that isn't very "commercial", consider submitting it to the index.
- [Marginalia Search](https://search.marginalia.nu/): A recent addition similar to Wiby, and _my favorite entry on this page_. It has its own crawler but is strongly biased towards non-commercial, personal, and/or minimal sites. It's a great response to the increasingly SEO-spam-filled SERPs of GBY. Partially powers Teclis, which in turn partially powers Kagi.
- [Search My Site](https://searchmysite.net): Similar to Wiby, but only indexes user-submitted personal and independent sites. It optionally supports IndieAuth.
- [Teclis](http://teclis.com/): A project by the creator of Kagi search. Uses its own crawler that measures content blocked by uBlock Origin, and extracts content with the open-source article scrapers Trafilatura and Readability.js. This is quite an interesting approach: tracking blocked elements discourages tracking and advertising; using Trafilatura and Readability.js encourages the use of semantic HTML and Semantic Web standards such as [microformats](https://microformats.org/), [microdata](https://html.spec.whatwg.org/multipage/microdata.html), and [RDFa](https://www.w3.org/TR/rdfa-primer/). It claims to also use some results from Marginalia.

### Site finders

These engines try to find a website, typically at the domain-name level. They don't focus on capturing particular pages within websites.

- [search.tl](http://www.search.tl/): Generalist search for one <abbr title="top-level domain">TLD</abbr> at a time (defaults to .com). I'm not sure why you'd want to always limit your searches to a single TLD, but now you can.[^9] There isn't any visible UI for changing the TLD for available results; you need to add/change the `tld` URL parameter. For example, to search .org sites, append `&tld=org` to the URL. It seems to be connected to [Amidalla](http://www.amidalla.de/). Amidalla allows users to manually add URLs to its index and directory; I have yet to see if doing so impacts search.tl results.
- [Thunderstone](https://search.thunderstone.com/texis/websearch21/): A combined website catalog and search engine that focuses on categorization. Its [about page](https://search.thunderstone.com/texis/websearch19/about.html) claims: <q cite="https://search.thunderstone.com/texis/websearch19/about.html">We continuously survey all primary COM, NET, and ORG web-servers and distill their contents to produce this database. This is an index of _sites_ not pages. It is very good at finding companies and organizations by purpose, product, subject matter, or location. If you're trying to finding things like _'BillyBob's personal beer can page on AOL'_, try Yahoo or Dogpile.</q> This seems to be the polar opposite of the engines in the ["small or non-commercial Web" category](#small-or-non-commercial-web).
- [sengine.info](https://www.sengine.info/): only shows domains, not individual pages. Developed by netEstate GmbH, which specializes in content extraction for inprints and job ads. Also has a German-only version available. Discovered in my access logs.
- [Gnomit](https://www.gnomit.com/): Allows single-keyword queries and returns sites that seem to cover a related topic. I actually kind of enjoy using it; results are old (typically from 2009) and a bit random, but make for a nice way to discover something new. For instance, searching for "IRC" helped me discover new IRC networks I'd never heard of.

### Other

- [Keybot](https://www.keybot.com/): A must-have for anyone who does translation work. It crawls the web looking for multilingual websites. Translators who are unsure about how to translate a given word or phrase can see its usage in two given languages, to learn from other human translators. My parents are fluent English speakers but sometimes struggle to express a given Hindi idiom in English; something like this could be useful to them, since machine translation isn't nuanced enough for every situation. Part of the [TTN Translation Network](https://www.ttn.ch/). Discovered in my access logs.
- Quor: Seems to mainly index large news sites. Site is down as of June 2021; originally available at www dot quor dot com.
- [Ninfex](https://ninfex.com/): a "people-powered" search engine that combines aspects of link aggregators and search. It lets users vote on submissions and it also displays links to forums about submissions.
- [Semantic Scholar](https://www.semanticscholar.org/): a search engine by the Allen Institute for AI focused on academic PDFs, with a couple hundred million papers indexed. Discovered in my access logs.

Other languages
---------------

I'm unable to evaluate these engines properly since I don't speak the necessary languages. English searches on these are a hit-or-miss. I might have made a few mistakes in this category.

### Big indexes

- Baidu: Chinese. Very large index; it's a major engine alongside GBY. Offers webmaster tools for site submission.
- Qihoo 360: Chinese. I'm not sure how independent this one is.
- Toutiao: Chinese. Not sure how independent this one is either.
- Sogou: Chinese
- Yisou: Chinese
- [Naver](https://search.naver.com): Korean. Allows submitting sitemaps and feeds. Discovered via some Searx metasearch instances.
- [Seznam](https://www.seznam.cz/): Czech, seems relatively privacy-friendly. Discovered in the seirdy.one access logs. It allows site submission with webmaster tools.
- [Cốc Cốc](https://coccoc.com/search): Vietnamese
- [go.mail.ru](https://go.mail.ru/): Russian

### Smaller indexes

- [Vuhuv](https://www.vuhuv.com.tr/): Turkish. [alt domain](https://tr.vuhuv.com/)
- [Parsijoo](https://www.parsijoo.ir/): Persian
- [search.ch](https://search.ch): Regional search engine for Switzerland; users can restrict searches to their local regions.
- [fastbot](https://www.fastbot.de/): German
- [Moose.at](https://www.moose.at): German (Austria-based)
- [SOLOFIELD](https://solofield.net): Japanese
- [kaz.kz](http://kaz.kz): Kazakh and Russian, with a focus on "Kazakhstan's segment of the Internet"

Misc
----

* Ask.com: The site is back. They claim to outsource search results. The results seem similar to Google, Bing, and Yandex; however, I can’t pinpoint exactly where their results are coming from. Also, several sites from the "ask.com network" such as directhit.com, info.com, and kensaq.com have uniqe-looking results.

- Not evaluated: Apple's search. It's only accessible through a search widget in iOS and macOS and shows very few results. This might change; see the next section.
- Partially evaluated: [Infinity Search](https://infinitysearch.co): young, small index. It recently split into a paid offering with the main index and [Infinity Decentralized](https://infinitydecentralized.com/), the latter of which allows users to select from community-hosted crawlers. I managed to try it out before it became a paid offering, and it seemed decent; however, I wasn't able to run the tests listed in the "Methodology" section. Allows submitting URLs and sitemaps into a text box, no other work required.

Upcoming engines
----------------

These engines aren't ready yet; their indexes are either in a proof-of-concept phase with a handful of sites, or aren't available yet.

- Apple: given the activity of the AppleBot crawler lately, their index will almost certainly grow to a size large enough to power a general search engine soon. Check your server's access logs; there's a good chance it's crawled your site if you have a few backlinks.
- Ahrefs: {{<indieweb-person first-name="Dmitry" last-name="Gerasimenko" url="https://twitter.com/botsbreeder" org="Ahrefs" org-url="https://ahrefs.com/">}} [has announced](https://twitter.com/botsbreeder/status/1110889488706760704) plans for Ahrefs to release a search engine to <q cite="https://twitter.com/botsbreeder/status/1110889488706760704">share ad revenue with content creators 90/10</q>. This isn't surprising: its crawlers are quite active and have probably built quite a large index. He wrote [a blog post](https://medium.com/swlh/investor-money-vs-public-interest-did-google-fail-to-build-a-non-evil-platform-3a054f996ea9) describing the motivation and posted [a status update](https://twitter.com/botsbreeder/status/1405920654877028357) mid-2021.

Graveyard
---------

These engines were originally included in the article, but have since been discontinued.

- [Meorca](https://meorca.com/): A UK-based search engine that claimed not to "index pornography or illegal content websites". It also featured a public blog with a marketplace and free games. Allowed submitting URLs, but required a full name, email, phone number, and "business name" to do so. Discovered in the seirdy.one access logs. It seems to have dropped everything and pivoted to image-search, which is out of scope for this post.
- [wbsrch](https://wbsrch.com/): In addition to its generalist search, it also had many other utilities related to domain name statistics. Failed multiple tests. Its index was a bit dated; it had an old backlog of sites it hadn't finished indexing. It also had several dedicated per-language indexes.
- [Gowiki](https://gowiki.com): Very young, small index, but showed promise. I discovered this in the seirdy.one access logs. It was only available in the US. Seems down as of early 2022.

Exclusions
----------

Two engines were excluded from this list for having a far-right focus.

One engine was excluded because it seems to be built using cryptocurrency in a way I'd rather not support.

Some fascinating little engines seem like hobbyist proofs-of-concept. I decided not to include them in this list, but watch them with interest to see if they can become something viable.

Rationale
---------

Why bother using non-mainstream search engines?

### Conflicts of interest

Google, Microsoft (the company behind Bing), and Yandex aren't just search engine companies; they're content and ad companies as well. For example, Google hosts video content on YouTube and Microsoft hosts social media content on LinkedIn. This gives these companies a powerful incentive to prioritize their own content. They are able to do so even if they claim that they treat their own content the same as any other: since they have complete access to their search engines' inner workings, they can tailor their content pages to better fit their algorithms and tailor their algorithms to work well on their own content. They can also index their own content without limitations but throttle indexing for other crawlers.[^10]

One way to avoid this conflict of interest is to _use search engines that aren't linked to major content providers;_ i.e., use engines with their own independent indexes.

### Information diversity

There's also a practical, less-ideological reason to try other engines: different providers have different results. Websites that are hard to find on one search engine might be easy to find on another, so using more indexes and ranking algorithms results in access to more content.

No search engine is truly unbiased. Most engines' ranking algorithms incorporate a method similar to [PageRank](https://en.wikipedia.org/wiki/PageRank), which biases them towards sites with many backlinks. Search engines have to deal with unwanted results occupying the confusing overlap between SEO spam, shock content, and duplicate content. When this content’s manipulation of ranking algos causes it to rank high, engines have to address it through manual action or algorithm refinement. Choosing to address it through either option, or choosing to leave it there for popular queries after receiving user reports, reflects bias. The best solution is to mix different ranking algorithms and indexes instead of using one engine for everything.

Methodology
-----------

### Discovery

I find new engines by:

- Monitoring certain web directories for changes in their search engine listings.
- Checking other curated lists of "good/bad bots" to spot search engines.
- Using search engines to discover search engines: searching for the names of less-popular engines often pulls up similar lists.
- Receiving suggestions from readers
- Compiling a list of regular expressions for user-agent strings I'm familiar with. Before I delete my server access logs, I extract user-agents that don't match that list along with the pages they request.
- Checking the Searx and Searxng projects for new integrations.

### Evaluation

I focused almost entirely on "organic results" (the classic link results), and didn't focus too much on (often glaring) privacy issues, "enhanced" or "instant" results (e.g. Wikipedia sidebars, related searches, Stack Exchange answers), or other elements.

I compared results for esoteric queries side-by-side; if the first 20 results were (nearly) identical to another engine's results (though perhaps in a slightly different order), they were likely sourced externally and not from an independent index.

I tried to pick queries that should have a good number of results and show variance between search engines. An incomplete selection of queries I tested:

- "vim", "emacs", "neovim", and "nvimrc": Search engines with relevant results for "nvimrc" typically have a big index. Finding relevant results for the text editors "vim" and "emacs" instead of other topics that share the name is a challenging task.
- "vim cleaner": should return results related to a [line of cleaning products](https://en.wikipedia.org/wiki/Vim_%28cleaning_product%29) rather than the Correct Text Editor.
- "Seirdy": My site is relatively low-traffic, but my nickname is pretty unique and visible on several of the highest-traffic sites out there.
- "Project London": a small movie made with volunteers and <abbr title="Free, Libre, Open-Source Software">FLOSS</abbr> without much advertising. If links related to the movie show up, the engine's really good.
- "oppenheimer": a name that could refer to many things. Without context, it should refer to the physicist who worked on the atomic bomb in Los Alamos. Other historical queries: "magna carta" (intermediate), "the prince" (very hard).

Some less-mainstream engines have noticed this article, which is great! I've had excellent discussions with people who work on several of these engines. Unfortunately, this article's visibility also incentivizes some engines to optimize specifically for any methodology I describe. I've addressed this by keeping a long list of test queries to myself. The simple queries above are a decent starting point for simple quick evaluations, but I also test for common search operators, keyword length, and types of domain-specific jargon. I also use queries designed to pull up specific pages with varying levels of popularity and recency to gauge the size, scope, and growth of an index.

Professional critics often work anonymously because personalization can damage the integrity of their reviews. For similar reasons, I attempt to try each engine anonymously at least once by using a VPN and/or my standard anonymous setup: an amnesiac Whonix VM with the Tor Browser. I also often test using a fresh profile when travelling, or via a Searx instance if it supports a given engine. When avoiding personalization, I use "varied" queries that I don't repeat verbatim across search engines; this reduces the likelihood of identifying me. I also attempt to spread these tests out over time so admins won't notice an unusual uptick in unpredictable and esoteric searches. This might seem overkill, but I already regularly employ similar methods for a variety of different scenarios.

### Caveats

I didn't try to avoid personalization when testing engines that require account creation. Entries in the "hit-and-miss" and "unusable" sections got less attention: I didn't spend a lot of effort tracking results over time to see how new entries got added to them.

I avoided "natural language" queries like questions, focusing instead on keyword searches and search operators. I also mostly ignored infoboxes (also known as "instant answers").

Acknowledge&shy;ments
---------------------

Some of this content came from the [Search Engine Map](https://www.searchenginemap.com/) and [Search Engine Party](https://searchengine.party/). A few web directories also proved useful.

{{<indieweb-person first-name="Matt" last-name="Wells" url="https://gigablast.com/bio.html" org="Gigablast" org-url="https://gigablast.com/">}} also gave me some helpful information about GBY which I included in the "Rationale" section. He's written more about big tech in the [Gigablast blog](https://gigablast.com/blog.html).

{{<indieweb-person first-name="Nicholas" last-name="Ferrell" url="https://emucafe.club/channel/naferrell" org="The New Leaf Journal" org-url="https://thenewleafjournal.com/">}} wrote a [great post](https://thenewleafjournal.com/a-2021-list-of-alternative-search-engines-and-search-resources/) on alternative search engines. He also gave me some [useful details](https://lists.sr.ht/~seirdy/seirdy.one-comments/%3C20210618031450.rb2twu4ypek6vvl3%40rkumarlappie.attlocal.net%3E) about Seznam, Naver, Baidu, and Goo.


[^1]: Yes, "indexes" is an acceptable plural form of the word "index". The word "indices" sounds weird to me outside a math class.

[^2]: DuckDuckGo has a crawler called DuckDuckBot. This crawler doesn't impact the linked results displayed; it just grabs favicons and scrapes data for a few instant answers. DuckDuckGo's help pages claim that the engine uses over 400 sources; my interpretation is that at least 398 sources don't impact organic results. I don't think DuckDuckGo is transparent enough about the fact that their organic results are proxied. Compare DuckDuckGo side-by-side with Bing and Yandex and you'll see it's sourcing organic results from one of them (probably Bing). _Update, March 2022:_ DuckDuckGo [has the ability to downrank results on its own](https://web.archive.org/web/20220310222014/https://nitter.pussthecat.org/yegg/status/1501716484761997318); it was previously [working with Bing](https://www.nytimes.com/2022/02/23/technology/duckduckgo-conspiracy-theories.html) to get Bing to remove misinformation and spam.

[^3]: Qwant claims to also use its own crawler for results, but it’s still mostly Bing in my experience. See the "semi-independent" section.

[^4]: Disconnect Search allows users to have results proxied from Bing or Yahoo, but Yahoo sources its results from Bing.

[^5]: Yippy claims to be powered by a certain IBM brand (a brand that could correspond to any number of products) and annotates results with the phrase "Yippy Index", but a side-by-side comparison with Bing and other Bing-based engines revealed results to be nearly identical.

[^6]: Ask.moe was working on a [FLOSS indexer](https://git.sr.ht/~danskeren/spider.moe); its search page stated an intention to switch to it from Bing at one point. This statement has since been removed.

[^7]: This is based on a statement Right Dao made in [on Reddit](https://reddit.com/comments/k4clx1/_/ge9dwmh/?context=1) ([archived](https://web.archive.org/web/20210320042457/https://i.reddit.com/r/degoogle/comments/k4clx1/right_dao_a_new_independent_search_engine_that/ge9dwmh/?context=1)).

[^8]: More information can be found in [this HN subthread](https://news.ycombinator.com/item?id=27593801) and some posts on the Cliqz tech blog ([one](https://0x65.dev/blog/2019-12-06/building-a-search-engine-from-scratch.html), [two](https://0x65.dev/blog/2019-12-10/search-quality-at-cliqz.html)).

[^9]: Some search engines support the `site:` search operator to limit searches to subpages or subdomains of a single site or TLD. `site:.one`, for instance, limits searches to websites with the ".one" TLD.

[^10]: Matt from Gigablast told me that indexing YouTube or LinkedIn will get you blocked if you aren't Google or Microsoft. I imagine that you could do so by getting special permission if you're a megacorporation.



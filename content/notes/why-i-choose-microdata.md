---
title: "Why I choose Microdata"
date: 2024-12-14T00:34:50-05:00
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/objects/996ae2cc-5e4a-451e-b165-b5a85c9432a8'
    - title: 'Bluesky'
      url: 'https://bsky.app/profile/seirdy.one/post/3ldam2tzshc2q'
---

The four most popular ways to use RDF-based metadata on websites are RDFa-Core, RDFa-Lite, Microdata, and inline JSON-LD.

I can't use RDFa-Lite because I need `rel` HTML attributes. [`rel` silently upgrades RDFa-Lite to RDFa-Core](https://www.ctrl.blog/entry/rdfa-link-attributes.html), which parses differently. I doubt all parsers upgrade correctly; some will try to parse RDFa-Core as RDFa-Lite. Conformant RDFa parsers upgrade RDFa-Lite pages to RDFa-Core despite many authors only being familiar with RDFa-Lite. I suppose resources like Schema.org and Google's documentation only documenting RDFa-Lite markup worsens the confusion. <ins itemprop="correction" itemscope="" itemtype="https://schema.org/CorrectionComment" cite="https://w3c.social/@csarven/113658498996285762">Update <time itemprop="datePublished">2024-12-16</time>: <span itemprop="text">{{<indieweb-person first-name="Sarven" last-name="Capadisli" itemprop="mentions" url="https://csarven.ca/#i">}} has [clarified on the Fediverse](https://csarven.ca/#i) that this is the behavior of one faulty parser; `rel` only triggers an upgrade when used with an RDFa namespace. I may re-evaluate RDFa.</span></ins>

With RDFa split between two incompatible alternatives with a confusing upgrade mechanism, the alternatives are Microdata and JSON-LD. I use structured data extensively; JSON-LD would duplicate most of the page. Let's use [this relatively short article]({{<relref "/posts/google-document-warehouse-api-docs-leak/">}}) as an example. [Exruct](https://github.com/scrapinghub/extruct) can convert the embedded Microdata into a massive JSON document featuring JSON-LD. [Take a look at the JSON-LD and HTML side by side](https://paste.sr.ht/~seirdy/7db88ad2405d4ab685130cd513cd9defafd9d2cf). Microdata attributes take a fraction of the footprint, encode the same information, and don't require duplicating nearly the entire page.

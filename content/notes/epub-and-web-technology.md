---
title: "EPUB and Web technology"
date: 2022-12-11T14:29:06-08:00
replyURI: "https://fosstodon.org/@RL_Dane/109497272141002333"
replyTitle: "A full webkit process and actual JS running just to view an epub"
replyType: "SocialMediaPosting"
replyAuthor: "R. L. Dane"
replyAuthorURI: "https://fosstodon.org/@RL_Dane"
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AQVk1LyhgR0eoo4MWe'
---
> The fact that I have to have a full WebKit process and actual JS running just to view an EPUB is really infuriating.
>
> Can't anything just be a ruddy DOCUMENT format anymore‽

To be fair: EPUB is actually a good use-case for semantic XHTML5,  WAI-ARIA, DPUB-ARIA, MathML, and RDF serializations. This does call for some sort of web engine,  but not necessarily a complete browser engine capable of running web apps.

Most of the rest of the Web platform beyond semantic markup and simple stylesheets should probably be stripped away from a typical EPUB reader. Unfortunately, few "slim" engines actually support enough of the features I described. Engines like Ultralight (proprietary) and [litehtml](https://github.com/litehtml/litehtml) come to mind, but I don't know how good the latter's accessibility support is.

I very much agree that JavaScript support in EPUB was a mistake; fortunately, it's seldom necessary. Signed JIT-less JavaScript as part of the e-reader program should be okay, as the user consented to run it.


---
title: "RDF versus semantic HTML"
date: 2022-09-13T21:30:02-07:00
replyURI: "https://cybre.space/@jauntywunderkind420/108993489770129012"
replyTitle: "Microdata and rdfa are excellent and wonderful ways to describe individual html elements"
replyType: "SocialMediaPosting"
replyAuthor: "@jauntywunderkind420@cybre.space"
replyAuthorURI: "https://cybre.space/@jauntywunderkind420/"
---

> microdata and rdfa both directly mark up existing html content.

Only on a syntactical level. Beyond that, it's the other way around: Microdata and <abbr>RDFa</abbr> let you build <abbr>RDF</abbr> triples by taking content *from* HTML elements. They don't exist to add information *to* HTML elements.

HTML and Microdata/<abbr>RDFa</abbr> syntaxes being mixed into the same document doesn't change this. They're only combined so human- and machine-readable data can remain identical without repetition, not to create more linked-data than the sum of its parts. You could re-write the very same <abbr>RDFa</abbr> data in e.g. Turtle syntax, with the HTML discarded. That's why I wasn't particularly fond of the (rejected) Microdata/RDFa approach to WAI-Adapt. (I think this was one of the major criticism raised, but I can't seem to find it)

An `@id` in JSON-LD takes information _from_, rather than adding information _to_, the HTML document; HTML-parsing user-agents should ignore it unless they're extracting <abbr>RDF</abbr> data from Microdata/<abbr>RDFa</abbr>.

> there's also `itemid`...the page can define multiple different resources on it, give a <abbr>uri</abbr> to the different bits of content on it.

`itemid` is just a way to refer to add to another object instead of creating a new one. Again, it's a way to extract information from different parts of an HTML document (or different HTML documents altogether) rather than a way to add to HTML elements.

Microformats sometimes use HTML itself rather than extracting data from it (see the `e-` prefix). This puts microformats in a sort of gray area, extracting data from HTML but also integrating with it.

I make extensive use of Microdata and microformats on seirdy.one. Strictly speaking, both syntaxes are made of HTML; however, I've certainly found the microformats approach to feel more "HTML-native" than Microdata.

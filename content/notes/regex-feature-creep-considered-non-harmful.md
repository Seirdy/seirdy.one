---
title: "Regex feature creep considered non-harmful"
date: 2023-08-26T15:00:22-07:00
replyURI: "https://akko.wtf/objects/14ffd986-060f-4bf9-9339-f26b1a3ecf5c"
replyTitle: "“regular” expressions"
replyType: "SocialMediaPosting"
replyAuthor: "Chjara"
replyAuthorURI: "https://tuxcrafting.online/"
#syndicatedCopies:
#    - title: 'The Fediverse'
#      url: ''
---
De-facto standard extensions for recursion and variable-length look-arounds have existed for ages; the word "regular" in most regular-expression engines is there for historical reasons. I first read about this in {{<mention-work itemtype="TechArticle">}}{{<cited-work name="Apocalypse 5: Pattern Matching" extraName="headline" url="https://raku.org/archive/doc/design/apo/A05.html">}} by {{<indieweb-person itemprop="author" first-name="Larry" last-name="Wall" url="http://www.wall.org/~larry/">}}{{</mention-work>}} (he loves his biblical terminology).

I _would_ like to just use Raku rules for a concise way to describe more advanced grammars; I'd then just keep my regexes to the PCRE subset that's common between Google's RE2 and the Rust regex crate; I doubt they're both "regular" but both guarantee linear time matching. Part of the reason I don't do this is portability. Not everything runs Raku, but almost every platform has [a regex engine with the features I need](https://en.wikipedia.org/wiki/Comparison_of_regular_expression_engines).


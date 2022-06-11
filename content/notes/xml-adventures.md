---
title: "XML adventures"
date: 2022-06-11T14:59:13-07:00
replyURI: "https://mk.nixnet.social/notes/91dz17okx7"
replyTitle: "Take a look at the xml:space attribute if you haven't"
replyType: "SocialMediaPosting"
replyAuthor: "Alexandra"
replyAuthorURI: "https://www.alm.website/me"
---
`xml:space` would make whitespace issues easier to handle and simplify [my current solution](https://git.sr.ht/~seirdy/seirdy.one/tree/master/item/scripts/xhtmlize-single-file.sh), but not everything supports XML namespaces; I want to keep this polygot HTML5 and XHTML5 markup for now.

Eventually I’ll offer certain enhancements to the XHTML version (add `index.xhtml` to the URLs or remove `text/html` form your `Accept` header but include `application/xhtml+xml`) and I’ve already made my Atom feeds a bit simpler, but there’s a lot to do before then.

I’ve added ActivityStreams, OStatus, and friends to my Atom feeds; maybe I could add them to my XHTML pages using namespaces, if RDFa doesn’t work out. First I wanna try my hand at writing an ontology for webrings so people can mark up their webrings with RDFa/microdata. That’ll make it easy to do things like check for broken webrings or build cool visualizations of overlapping rings.

I should also try my hand at XSLT for the Atom feeds to get a baseline browser preview.

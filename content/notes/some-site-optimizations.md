---
title: "Some site optimizations"
date: 2023-11-25T19:18:14-08:00
---
I continue to work on my site over break. Today I got the build time down to 3.5 seconds for the Hugo build and just under 3 seconds for post-processing and syntax-checking (mostly using `xmllint`). I'm not parallelizing the post-processing since my laptop just has two cores (no simultaneous multithreading) and CI has one.

Seven seconds is still too slow for changes to feel instant, though. I can't just rebuild on save. It's especially slow for a site with only <200 pages.

Hugo's profiler tells me that a lot of the time is spent searching for Webmentions that match the current page. Perhaps I should do that server-side ahead of time; right now, I download all my Webmentions as one big fat JSON file and load it into memory once. I should also move some post-processing back into Hugo.

I also re-used `xmllint` to minify my feeds and check their syntax. The minification worked particularly well since my feeds contain raw, un-escaped XHTML. Some clients still fetch my full-text feeds without transparent compression.

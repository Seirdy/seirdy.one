---
title: "Website todo"
date: 2024-05-09T00:49:19-04:00
outputs:
    - html
description: "A catalog of all the website improvements I hope to make on seirdy.one, but haven't gotten to yet (and some that I have)."
---
Here's a catalog of all the website improvements I hope to make on seirdy.one, but haven't gotten to yet (and some that I have).

## Improvements to do

These are roughly in descending order of importance:

- Add a blogroll.

- Create separate pages for bookmarks instead of filling them all on one page, and add Atom/RSS feeds for them.

- Test website in the newest Dillo release now that it's been taken over by a new team.

- Add [alternate optional stylesheet](https://developer.mozilla.org/en-US/docs/Web/CSS/Alternative_style_sheets) with more character.

- Add an HTML sitemap.

- Get CI working again.

- Add an i2p eepsite.

- Add a Yggdrassil node.

- Re-introduce WebSub functionality, with my own WebSub Hub.

- Switch Nginx from BoringSSL to WolfSSL (BoringSSL is a pain to compile).

- Fix and bring back search functionality.

- Switch to short-lived/week-long certificates.

- Enable Encrypted Client Hello, possibly by switching from Nginx to the H2O Web Server.

- Generate JSON payloads of per-section Webmentions server-side ahead of time so that site builds can be faster. Right now, it's one big JSON object of Webmentions across the whole site that each page has to search through, slowing down build times.

- Add support for page numbers in the Table of Contents (<abbr>ToC</abbr>) when on print media, and re-enable the <abbr>ToC</abbr> on print.

## Improvements already made

### September 2024

- Use "an" instead of "a" when necessary in reading time estimates.

### June 2024

- Added my 88x31 badge to the website footer to make it easier for badge-scraping projects to find it.

- Implement [the well-known button standard](https://codeberg.org/LunarEclipse/well-known-button/) (by [Arch](https://arch.dog/), via [this Fediverse post](https://floofy.tech/@arch/112461865365597998)) so people can discover [my button](https://seirdy.one/meta/badges/) more easily.

- Added support for [No-Vary-Search](https://wicg.github.io/nav-speculation/no-vary-search.html)

- Added humans.txt.

- Added my badge to the site footer. This also helps make it easier for projects like [EightyEightThirty.One](https://eightyeightthirty.one/) to scrape.

### May 2024

- Wrapped `details` elements in borders to distinguish them in print media and to emphasize that the contents can be toggled.

- Hid the broken <abbr>ToC</abbr> on my print stylesheet, which is useless in print without page numbers.

### April 2024

- Added a badges page to the meta section.

- Moved all non-idempotent/static parts to separate subdomains so the primary domain can get 0-RTT.


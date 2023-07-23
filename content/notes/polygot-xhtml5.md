---
title: "Polygot XHTML5"
date: 2023-07-22T20:39:24-07:00
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AXyQMNhrMjeGLBrmim'
---

Why is my site's markup polygot XHTML5? I have had to deal with some really awful user-agents:

- Bespoke markup parsers in RSS readers.
- Link previews in obscure messaging apps.
- A reader-mode bookmarklet-turned-browser-extension that hasn't been updated in twelve years.
- Various search engines trying to parse the page without using a compliant parser.

Most of my issues were solved by running my generated markup through both `xmllint` (XML syntax) and the Nu HTML Checker (HTML5). Optional elements tend to cause issues the most.

Overly-aggressive validation tends to spot latent bugs. Even if something is valid without an optional closing tag, I may have meant to include one in my templates. If that becomes an issue when I change something else later, it'll be hard to track down the bug when it passes more lax validation.

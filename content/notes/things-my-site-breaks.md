---
title: "Filing bugs for things my site breaks"
date: 2022-08-10T17:00:00-07:00
---

Web development **fuzzes browsers and developer tools** with the side-effect of occasionally producing decent Web content. My site has broken enough things to give me plenty of bugs to file, or cause others to file on my behalf. Despite all the fuss I make about maintaining compatibility, I do make exceptions for simple fixable bugs and broken developer tools.

My strict Content Security Policy (<abbr title="Content Security Policy">CSP</abbr>) has broken various developer tools (Axe, Lighthouse), Brave's Reader Mode (allowing styles with a CSP hash blocks reader-mode CSS), WebKit media controls (I relax the <abbr>CSP</abbr> on the affected page), Chromium DevTools' console, and various parts of Epiphany. Recent directives like `navigate-to` and `webrtc` were unsupported by Google's CSP evaluator (and by proxy, Lighthouse) until I pushed a trivial fix.

Recent features like CSS containment, `media` attributes in `<meta name="theme-color">` elements, the `@supports selector()` CSS at-rule, and `prefers-contrast: less` expose several false positives in the W3C's CSS and Nu HTML validators; I fixed a couple of the simpler issues.

My use of `<source media=...>` children of `<picture>` elements for alternate images on print/screen media types doesn't get picked up by Chromium's print-preview.

My use of DPUB-ARIA triggers false-positives in accessibility tools such as AInspector and ARC Toolkit.

There are *billions* of websites; some of these issues should have been discovered long ago. If you have a few minutes to spare: please, file detailed bug reports when something breaks! It's better to let developers know sooner than later; most bugs get harder to fix with time.

---
title: "Screen2x and DOM Distiller"
date: 2023-08-08T22:12:56-07:00
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AYXnLTyukHT3XlpTCi'
---
I just tried Chromium's "Screen2x" article distiller (experimental in `chrome://flags`).

Before, the DOM Distiller removed elements far too aggressively. The new Screen2x implementation has gone in the opposite direction: it barely removes any of the page's non-navigation structure. It does, however, remove all the images. `figure` elements that aren't images (e.g. block-quotes with citations in `figcaption` children, or code snippets with descriptions in their captions) lose their captions. Inline `code` and `samp` elements lose their semantics and styling, becoming plain inline text (code blocks in `pre` blocks remain preserved).

In other words, it's replaced one set of false-positives with another, and now removes too _little_ of the page structure. An improvement, but not enough to compete with alternatives.

Reading Mode now opens in a sidebar on desktop, instead of replacing the page. Users are expected to use the Reading Mode and the regular page side-by-side now, so it won't replace ads. I smell infighting between ads and browser teams.


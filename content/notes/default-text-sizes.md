---
title: "Default text sizes"
date: 2023-05-27T14:32:30-07:00
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AW5on8jqNn98LAp48O'
---
I've previously been an advocate of making websites with long-form body text increase the default size just a bit, since their text should be larger than the one-size-fits-all browser default; interfaces and navigation can be smaller. I didn't think we should expect users to change their default zoom levels, as that's a potential JavaScript-free fingerprinting vector.

I'm thinking about revising this stance after using increased display zoom levels on mobile OSes for several months; with those modes, sites with large text are irritating to read: one line of text can barely fit a few words. Browser zoom increments are coarse, possibly forcing readers to choose between "too large" and "too small".

I [removed the base font-size settings from the seirdy.one stylesheet](https://git.sr.ht/~seirdy/seirdy.one/commit/ef10703) ([Codeberg mirror](https://codeberg.org/Seirdy/seirdy.one/commit/ef10703db7607d457997b84c7c1b00ee27518efa)), and I made sure that my stylesheet and `meta` tags don't result in any requests influenced by zoom level. While having to increase the zoom level may inconvenience readers who prefer large text, it should also make the site massively more convenient to readers with increased display zoom levels. I'm open to feedback.

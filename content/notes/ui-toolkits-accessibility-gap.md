---
title: "UI toolkits and the accessibility gap"
date: 2023-02-16T19:01:11-08:00
replyURI: "https://www.warp.dev/blog/why-is-building-a-ui-in-rust-so-hard"
replyTitle: "Why is building a UI in Rust so hard?"
replyType: "BlogPosting"
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/ASl0lOGNcl5GNJL6Jc'
    - title: 'Lobsters'
      url: 'https://lobste.rs/comments/f6rvfi/reply'
---
How does Warp stack against other toolkits when it comes to accessibility and system integration?

In my system settings I set colors, default fonts (with fallback and hinting settings), animation preferences (reduce/eliminate animations), disable overlay scrollbars, set buttons to include text where possible, enable dark mode, configure keyboard shortcuts, and sometimes enable a screen reader. Windows users can enable High Contrast Mode to force their preferred palettes. To what degree will this toolkit respect these settings?

On Linux: the only options I know of with decent system integration, accessibility, and some presence outside the Freedesktop.org ecosystem are are Qt, GTK, and the Web. Flutter falls flat, with outstanding WCAG level A blockers like functional keyboard navigation and basic levels of customization (e.g. disabling animation); relevant issues typically get de-prioritized. This is despite its massive funding and development efforts, so I'm not optimistic about other contenders.

[AccessKit](https://github.com/AccessKit/accesskit) looks like a start for cross-platform interoperability between accessibility APIs. Until it's ready, support for each platform's accessibility APIs and screen readers will need to be implemented and tested. It's a monumental task. I worry that **releasing yet another inaccessible toolkit will merely increase the disability gap.**


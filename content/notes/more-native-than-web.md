---
title: "More native than a Web app"
date: 2023-11-21T22:30:17-08:00
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/Ac3YFDiQUINNybAA4W'
---
Whenever I discover a new GUI toolkit, my first question is always "is it more native than the Web?" For reference, here are some ways Web apps have better system integration than Flutter:

- System fonts, font hinting settings, and font fallback settings.
- System text navigation shortcuts.
- System scrollbar visibility, thickness, and click settings/behavior.
- System highlight menus and controls (on touchscreens).
- System display scaling settings.
- System reduced-motion settings (An API is documented, but I have never used a Flutter app that actually disables animations. I may be wrong).
- System reduced-transparency settings.
- System forced-colors mode (Windows High Contrast Mode).
- System color palettes (some browsers support setting default colors without necessarily forcing the palette).
- System media controls (play/pause/skip, current track, e.g. using MPRIS on freedesktop platforms).

It's an easier question to answer than my second question: "What <abbr title="Web Content Accessibility Guidelines">WCAG</abbr> conformance level can I hope for?

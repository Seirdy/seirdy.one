---
title: "Fingerprinting and customization"
date: 2023-08-28T13:52:11-07:00
replyURI: "https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/40337#note_2936949"
replyTitle: "Wouldn't, say, installing the Dark Reader extension have much less of a privacy impact than disabling RFP altogether?"
replyType: "DiscussionForumPosting"
replyAuthor: "Allium"
replyAuthorURI: "https://gitlab.torproject.org/Allium"
syndicatedCopies:
    - title: 'Tor Project GitLab'
      url: 'https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/40337#note_2937536'
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AZCWxOH1fC9CUnxmoi'
---

These addons work by injecting or altering stylesheets in the page, and are trivially detectable. A good rule of thumb is that if it can trigger a CSP violation in the developer console, it is trivial to detect with JavaScript.

(FWIW: I believe the Tor Browser does disable the Reporting API, so I think some JavaScript will be necessary).

On "safest" mode with remote JavaScript disabled, certain "dark mode" addons *might* be safe. I think a better long-term solution would be the ability to "freeze" a page: a button or something to prevent the current page from initiating further requests (it's already loaded), running scripts, accessing storage, etc. In this state, a user could use any addons or fingerprinting-compromising settings without risk.

A good point of comparison is Reader Mode: a user's preferred Reader Mode fonts, line-width, color scheme, etc. aren't fingerprinting vectors. It should be able to stop a site from phoning home or writing to client-side storage to allow for similar levels of customization outside Reader Mode.

Other sources of inspiration could be the expected behavior for the [`scripting: initial-only` media query](https://drafts.csswg.org/mediaqueries-5/#scripting), and Firefox's built-in "Work Offline" setting.

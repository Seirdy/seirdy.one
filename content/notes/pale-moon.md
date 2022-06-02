---
title: "Pale Moon"
date: 2022-06-01T09:59:32-07:00
---
<aside role="note">
Reply to {{< mention-work itemprop="about" itemtype="SocialMediaPosting" reply=true >}}{{<cited-work name="I've never used Pale Moon but I also don't understand why anyone would use it. If I'm not mistaken, Pale Moon exists because it didn't want to part ways with XUL extensions?" url="https://social.treehouse.systems/@ayushnix/108403066213035358">}} by {{<indieweb-person first-name="Ayush" last-name="Agarwal" url="https://microblog.ayushnix.com/" itemprop="author">}}
{{</mention-work>}}
</aside>

Pale Moon's inception pre-dates Firefox 57 by many years; before its notoriety following the removal of XUL/XPCOM, it was popular among people who didn't like Electrolysis.

I hate that Pale Moon is so behind on security because it also has nice stuff that Mozilla axed. Some things were axed for good reason, like extensions with the ability to alter browser functionality. Others were axed without good reason, like built-in RSS/Atom support.

WebExtensions that fill in missing functionality often require content injection which is problematic for a variety of reasons. To name a few: try visiting a page that has a <samp>sandbox</samp> CSP directive without <samp>allow-same-origin</samp> or <samp>allow-scripts</samp> and see how well it works, saving a page and noticing it has extra scripts or iframes, or seeing addon scripts activate too late when your underpowered machine is under load). It's better than giving them access to browser functionality but nothing beats having features in the actual browser.

I still wouldn't recommend it due to extremely weak sandboxing and a naive approach to security. The devs respond to sandboxing queries by saying it's secure because "it separates the content and application" which tells you how little they care or understand; untrusted content needs isolation not just from the browser but from other untrusted content. Given the scope of a browser, even Firefox isn't where it should be (even given their commendable progress on Fission, RLBox, and their utility process overhaul), let alone caught up to the mitigations in Chromium's Blink or WebKit's JavaScriptCore but I digress.

It'd be totally fine if they described their browser as a complement to a more airtight one or as a dev tool (it's honestly a great dev tool given some addons, I'll happily concede that). But when you describe yourself as a replacement to other browsers but lack the security architecture to back it up, you're being irresponsible.

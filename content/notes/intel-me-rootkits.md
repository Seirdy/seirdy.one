---
title: "Intel ME rootkits"
date: 2022-10-19T13:20:19-07:00
replyURI: "https://mastodon.social/@byterhymer/109181969125151465"
replyTitle: "Don't forget there have already been Intel ME rootkits too"
replyType: "SocialMediaPosting"
replyAuthor: "@byterhymer@mastodon.social"
replyAuthorURI: "https://mastodon.social/@byterhymer"
---
I know of two Intel <abbr title="Management Engine">ME</abbr> rootkits that didn't involve Intel <abbr title="Active Management Technology">AMT</abbr>; the latter can be enabled/disabled on "<span translate="no">vPro</span>" chips. One rootkit was from 2009 and seems less relevant now; the more recent of the two was by <span class="h-cite" itemprop="mentions" itemscope="" itemtype="https://schema.org/PresentationDigitalDocument">{{<indieweb-person itemprop="author" first-name="Mark" last-name="Ermolov" url="https://www.blackhat.com/eu-17/speakers/Mark-Ermolov.html">}} and {{<indieweb-person itemprop="author" first-name="Maxim" last-name="Goryachy" url="https://www.blackhat.com/eu-17/speakers/Maxim-Goryachy.html">}} at Black Hat Europe 2017: {{<cited-work url="https://www.blackhat.com/docs/eu-17/materials/eu-17-Goryachy-How-To-Hack-A-Turned-Off-Computer-Or-Running-Unsigned-Code-In-Intel-Management-Engine-wp.pdf" name="How to Hack a Turned-Off Computer, or Running Unsigned Code in Intel Management Engine" extraName="headline">}} (<span itemprop="encodingFormat">application/pdf</span>)</span>.

Without <abbr>AMT</abbr>, they required physical access. Most PCs are woefully unprepared against the sorts of attacks enabled by physical access, and <abbr>ME</abbr> is only one entry in a long list of issues.


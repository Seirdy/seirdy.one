---
title: "Problems with BIMI"
date: 2023-06-09T22:15:51-07:00
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AWXQqaIGDQl0Jf0JOq'
---
Everything about [Brand Indicators for Message Identification](https://bimigroup.org/) (<abbr>BIMI</abbr>) feels so half-baked.

Lukewarm take: <abbr>BIMI</abbr> should mandate <abbr title="Domain-based Message Authentication, Reporting and Conformance">DMARC</abbr> with <abbr title="DomainKeys Identified Mail">DKIM</abbr> and just ignore <abbr title="Sender Policy Framework">SPF</abbr>. It could also require supporting TLS 1.3+. After all, one of the stated goals of <abbr>BIMI</abbr> was to increase adoption of better email standards like <abbr>DMARC</abbr>. This could have [entirely prevented recent spoofing issues](https://infosec.exchange/@titanous/110481616735600044).

Putting the <abbr>HTTPS</abbr> <abbr>URL</abbr> of an <abbr>SVG</abbr> icon in a new <abbr>DNS</abbr> <abbr>TXT</abbr> record to associate a whole domain with a logo makes no sense. _Several_ better standards exist for associating a `user@domain` with an image, allowing different logos for different emails at the same domain. [Webfinger](https://webfinger.net/) and [Libravatar](https://www.libravatar.org/) come to mind.

Hell, even its special <abbr>SVG</abbr> Tiny Portable/Secure standard could be simplified further. [usvg](https://github.com/RazrFalcon/resvg/tree/6be2f2d396e539ddfcf022dc67f304d307c1211a/crates/usvg) can convert nearly any <abbr>SVG</abbr> to a tiny subset of the <abbr>SVG</abbr> Tiny P/S standard while preserving their appearance.

Of course, none of this is too relevant to the <abbr>BIMI</abbr> group. The real purpose of <abbr>BIMI</abbr> was always to give certificate authorities a new source of income after their losses from Let's Encrypt's (lack of) pricing, the rise of ACME-based automation, and browsers' deprecation of EV features.

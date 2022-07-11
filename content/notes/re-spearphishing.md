---
title: "Re spearphishing"
date: 2022-07-10T17:34:19-07:00
replyURL: "https://xeiaso.net/blog/spearphishing"
replyTitle: "Spearphishing: it can happen to you too"
replyType: "BlogPosting"
replyAuthor: "Xe Iaso"
replyAuthorURI: "https://xeiaso.net/"
---
I think that using a dedicated air-gapped machine just for opening PDFs is a bit much if you don't rely on assistive technologies to read PDFs. A much less nuclear option: Qubes OS has an excellent [PDF converter](https://github.com/QubesOS/qubes-app-linux-pdf-converter) to convert PDFs to safe bitmaps, and back into PDFs. The results are completely inaccessible, so I wouldn't recommend sharing the final artifacts; however, this approach is fine for personal use.

The Qubes blog covers this in more detail: {{<mention-work itemtype="BlogPosting" role="doc-credit" itemprop="citation">}}{{<cited-work name="Converting untrusted PDFs into trusted ones: The Qubes Way" url="https://blog.invisiblethings.org/2013/02/21/converting-untrusted-pdfs-into-trusted.html">}}, by {{<indieweb-person first-name="Joanna" last-name="Rutkowska" url="https://blog.invisiblethings.org/about/">}}{{</mention-work>}}

SaaS can actually be helpful when it comes to processing potentially-malicious files. In high school, we had to make heavy use of Google Drive. One approach that I used to use was to open a PDF with Google Docs and export the resulting Google Doc.


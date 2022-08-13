---
title: "Document policy and image compression"
date: 2022-08-12T17:00:01-07:00
replyURI: "https://github.com/wicg/document-policy/blob/main/document-policy-explainer.md"
replyTitle: "Document Policy Explainer"
replyType: "TechArticle"
---
Interaction between the Document-Policy `image-compression` directive and a user-agent's supported image formats is currently unspecified.

Next-gen image formats of the present and future include WebP, AVIF, JPEG-XL, and WebP2. With every new format, new compression ratios become possible; however, cross-browser support is inconsistent. That means possible compression ratios also vary by browser. Fewer supported image formats should allow a less aggressive compression ratio in the Document Policy. Unfortunately, browsers' `Accept` request headers don't always report supported image formats, so servers can't easily compute the best policy for a given browser.

Specifying a per-mimetype compression ratio isn't ideal. Sometimes a PNG can beat AVIF or come close enough to not justify the extra bytes of a `<picture>` element. On a browser with AVIF and PNG support, loaded PNGs should be held to AVIF-level compression expectations.

I think the most robust solution would be to offer multiple image-compression policies to a browser; the browser can then pick the policy that matches its supported image formats. For instance: a server could offer a `image-compression-supports-webp`, `image-compression-supports-webp-avif`, `image-compression-supports-webp-avif-jxl`, etc. Unfortunately, this is really wordy and will only grow more complex as browsers adopt new image formats.

TLDR: in a web where supported image formats can vary, it's unclear how `image-compression` and a UA's supported image formats should interact. This variance warrants a policy more complex than a single global value.


---
title: "Chromium’s influence on Chromium alternatives"
date: 2024-10-06T11:40:34-04:00
---
I don't think most people realize how Firefox and Safari depend on Google for more than "just" revenue from default search engine deals and prototyping new web platform features.

Off the top of my head, Safari and Firefox use the following Chromium libraries: libwebrtc, libbrotli, libvpx, libwebp, some color management libraries, libjxl ([Chromium may eventually contribute a Rust JPEG-XL implementation to Firefox](https://github.com/mozilla/standards-positions/pull/1064); it's a hard image format to implement!), much of Safari’s cryptography (from BoringSSL), Firefox's 2D renderer (Skia)...the list goes on. Much of Firefox's security overhaul in recent years (process isolation, site isolation, user namespace sandboxes, effort on building with ControlFlowIntegrity) is directly inspired by Chromium's architecture.

Interdependence for independent components can be mutually beneficial. For something to be part of Chromium, it needs to build and test with a battery of sanitizers and receive continuous fuzzing. Mozilla and Safari do something similar. All benefit from libraries getting patched to meet each others' security requirements. Without Google, Mozilla and Apple must assume responsibility to maintain these libraries to a browser-grade standard. 

I see many advocates for Chromium alternatives say the Web would be better without Chromium. That may be true, but Chromium alternatives may also be worse.

For completeness: Firefox and Safari's influence on Chromium in recent years includes the addition of memory-safe languages, partitioned site storage, [declarative content blocking]({{<relref "/posts/layered-content-blocking.md">}}) (from Safari), and a vague multi-year repeatedly-delayed intent to phase out third-party cookies. Chromium would be no better off without other browser projects.


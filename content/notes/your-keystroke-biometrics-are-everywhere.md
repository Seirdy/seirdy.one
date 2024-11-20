---
title: "Your keystroke biometrics are everywhere"
date: 2024-11-20T10:25:39-05:00
---

Real time collaboration software and text boxes that rapidly save drafts to the cloud essentially log your fingerprintable typing behavior. The industry refers to this information as "keystroke dynamics" or "typing biometrics".

Other modern "operator signatures" are easier to minimize. A user can learn to [obfuscate writing style](https://seirdy.one/posts/2022/07/09/stylometric-fingerprinting-redux/), or can use keyboard navigation with different pointing devices to limit [fingerprinting of mouse behavior](http://jcarlosnorte.com/security/2016/03/06/advanced-tor-browser-fingerprinting.html).

Keystroke biometrics are difficult to anonymize without [installing software such as kloak](https://github.com/vmonaco/kloak) or browser extensions (the latter of which may add fingerprintable vectors) designed to cloak some of your typing habits. Signature typos, approximate typing speed, etc. will still leak. Alternatively, we could normalize typing messages out in a simple offline editors that don't store revision history before pasting them into other input fields.

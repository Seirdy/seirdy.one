---
title: "Permissions Policy header bloat"
date: 2023-08-03T21:12:43-07:00
replyURI: "https://github.com/w3c/webappsec-permissions-policy/issues/481#issuecomment-1259139696"
replyTitle: "I think we should be comparing wins relative to HTTP/3 with the latest in header compression"
replyType: "DiscussionForumPosting"
replyAuthor: "Anne van Kesteren"
replyAuthorURI: "https://annevankesteren.nl/"
syndicatedCopies:
    - title: 'GitHub'
      url: 'https://github.com/w3c/webappsec-permissions-policy/issues/481#issuecomment-1259139696'
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AYNLYfnnAejTPh4csa'
---
I'm a browser "with the latest in header compression", fetching a web page. I race a TCP-based ALPN run against an HTTPS record lookup (Chromium's behavior). Either the HTTP/2 ALPN wins the race, or the HTTPS DNS record does not exist. Both are, and will remain, common scenarios. So I fetch the page over HTTP/2. This is the initial request; dynamic HPACK hasn't kicked in. I download a 1.56kb HTTP response header:

```
Permissions-Policy: accelerometer=(),ambient-light-sensor=(),attribution-reporting=(),autoplay=(),battery=(),bluetooth=(),browsing-topics=(),camera=(),ch-device-memory=(),ch-downlink=(),ch-dpr=(),ch-ect=(),ch-lang=(),ch-partitioned-cookies=(),ch-prefers-color-scheme=(),ch-prefers-reduced-motion=(),ch-rtt=(),ch-save-data=(),ch-ua=(),ch-ua-arch=(),ch-ua-bitness=(),ch-ua-full=(),ch-ua-full-version=(),ch-ua-full-version-list=(),ch-ua-mobile=(),ch-ua-model=(),ch-ua-platform=(),ch-ua-platform-version=(),ch-ua-reduced=(),ch-ua-wow64=(),ch-viewport-height=(),ch-viewport-width=(),ch-width=(),clipboard-read=(),clipboard-write=(),compute-pressure=(),conversion-measurement=(),cross-origin-isolated=(),direct-sockets=(),display-capture=(),document-domain=(),encrypted-media=(),execution-while-not-rendered=(),execution-while-out-of-viewport=(),focus-without-user-activation=(),fullscreen=(),gamepad=(),geolocation=(),gyroscope=(),hid=(),identity-credentials-get=(),idle-detection=(),interest-cohort=(),join-ad-interest-group=(),keyboard-map=(),local-fonts=(),magnetometer=(),microphone=(),midi=(),navigation-override=(),otp-credentials=(),payment=(),picture-in-picture=(),private-state-token-issuance=(),private-state-token-redemption=(),publickey-credentials-get=(),run-ad-auction=(),screen-wake-lock=(),serial=(),shared-autofill=(),smart-card=(),speaker-selection=(),storage-access=(),storage-access-api=(),sync-script=(),sync-xhr=(),trust-token-redemption=(),unload=(),usb=(),vertical-scroll=(),wake-lock=(),web-share=(),window-placement=(),xr-spatial-tracking=()
```

Now, through `Alt-Svc` or an HTTPS record lookup, I discover HTTP/3 support. I download a render-blocking asset over an upgraded HTTP/3 connection. This is the first HTTP/3 request; dynamic QPACK compression hasn't kicked in. I download a 1.56kb HTTP response header:

```
Permissions-Policy: accelerometer=(),ambient-light-sensor=(),attribution-reporting=(),autoplay=(),battery=(),bluetooth=(),browsing-topics=(),camera=(),ch-device-memory=(),ch-downlink=(),ch-dpr=(),ch-ect=(),ch-lang=(),ch-partitioned-cookies=(),ch-prefers-color-scheme=(),ch-prefers-reduced-motion=(),ch-rtt=(),ch-save-data=(),ch-ua=(),ch-ua-arch=(),ch-ua-bitness=(),ch-ua-full=(),ch-ua-full-version=(),ch-ua-full-version-list=(),ch-ua-mobile=(),ch-ua-model=(),ch-ua-platform=(),ch-ua-platform-version=(),ch-ua-reduced=(),ch-ua-wow64=(),ch-viewport-height=(),ch-viewport-width=(),ch-width=(),clipboard-read=(),clipboard-write=(),compute-pressure=(),conversion-measurement=(),cross-origin-isolated=(),direct-sockets=(),display-capture=(),document-domain=(),encrypted-media=(),execution-while-not-rendered=(),execution-while-out-of-viewport=(),focus-without-user-activation=(),fullscreen=(),gamepad=(),geolocation=(),gyroscope=(),hid=(),identity-credentials-get=(),idle-detection=(),interest-cohort=(),join-ad-interest-group=(),keyboard-map=(),local-fonts=(),magnetometer=(),microphone=(),midi=(),navigation-override=(),otp-credentials=(),payment=(),picture-in-picture=(),private-state-token-issuance=(),private-state-token-redemption=(),publickey-credentials-get=(),run-ad-auction=(),screen-wake-lock=(),serial=(),shared-autofill=(),smart-card=(),speaker-selection=(),storage-access=(),storage-access-api=(),sync-script=(),sync-xhr=(),trust-token-redemption=(),unload=(),usb=(),vertical-scroll=(),wake-lock=(),web-share=(),window-placement=(),xr-spatial-tracking=()
```

I've burned 3.2kb on what may be a small page, for one header. Rendering hasn't started yet. Add headers this is meant to complement (`Document-Policy`, CSP, etc.), all with an expanding list of directives, and header size becomes a problem. This is before we consider clients that lack HPACK/QPACK support (nearly all HTTP libraries I've used), or resources on other domains.

CSP had a good solution: grouping the fetch directives that existed at the time under `default-src`. Similarly, we can try defining a large set of permissions to group under one directive. Every few years, we could add a new meta-directive to keep forward- and backward-compatibility while also keeping header size from growing out of control.


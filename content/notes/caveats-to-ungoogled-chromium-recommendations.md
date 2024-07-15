---
title: "Caveats to Ungoogled Chromium recommendations"
date: 2024-07-15T00:05:38-04:00
---
In the wake of a certain ad-funded browser company bundling adtech into its browser yet again, some people have been recommending Ungoogled-Chromium (<abbr>UGC</abbr>). I think it's fine to recommend <abbr>UGC</abbr> _with caveats,_ such as the fact that it disables component updates that include:

- Certificate revocation. Chromium uses [downloaded CRLSets](https://www.chromium.org/Home/chromium-security/crlsets/) for revocation; it does not support OCSP.

- Out of band security patches. When browser components have exploits in the wild, they need to be patched ASAP; updating billions of installations within time-frames measured in hours often means restartless out-of-band updates.

- Out of band certificate bundle updates.

If you assume Google uses its component update server logs maliciously, you may wish to consider a fork that still offers component updates provided by a different party's servers.

<abbr title="Ungoogled Chromium">UGC</abbr> disabled mDNS at one point. This exposed local IP addresses over WebRTC for years, but they seem to have shipped a fix in May 2023 to disable non-proxied UDP.

<abbr>UGC</abbr> also disables the Chrome Web Store in favor of installing extensions out of band. Make sure you regularly update your extensions installed out-of-band, since <abbr>UGC</abbr> won't do it on its own. Some scripts and a special extension re-implement some of this functionality.

Overall, <abbr>UGC</abbr> is still safer than QtWebEngine despite making heavy compromises to security for privacy (though I can't see how either benefited from disabling mDNS: I'm not aware of threat models under which revealing a local IP to every application is preferable to revealing it to just Google). Running <abbr>UGC</abbr> is fine if you understand these trade-offs and have accounted for them. I use it in headless mode to run accessibility and performance tests.


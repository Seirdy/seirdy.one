---
title: "State of the Tor Uplift"
date: 2022-09-19T20:15:05-07:00
---
Currently, the Tor Browser is based on Firefox Extended Support Release (<abbr title="Extended Support Release">ESR</abbr>); it lags behind stable releases by up to <time datetime="P390D">13 months</time> and only receives the subset of security backports deemed to be a high-enough priority.

The [Tor Uplift project](https://wiki.mozilla.org/Security/Tor_Uplift) is an initiative to upstream all the Tor Browser's patches into Firefox. Its goal is to make re-basing the Tor browser patches easy enough for the Tor Browser to track Firefox's stable release channel. The Tor Uplift has been in progress for <time datetime="P2357D">seven years</time>, with several of the Tor Browser's biggest modifications successfully upstreamed (first-party isolation, fingerprinting resistance, and more robust proxy support).

On <time datetime="2022-06-28">2022-06-28</time>, Firefox 102 ESR was released. Today, on <time datetime="2022-09-20">2022-09-20</time>, Firefox 91 ESR will lose support. That gave a window of about three months (the duration of three Firefox stable releases) to re-base Tor Browser patches.

The first stable release of the Tor Browser based on ESR 102 hasn't yet shipped (it's close; [an alpha version is available](https://blog.torproject.org/new-alpha-release-tor-browser-120a2/)). Seven years into the Tor uplift, the Tor Project isn't able to keep up with the Firefox ESR release calendar. I don't think the Tor Uplift will succeed at getting the Tor Browser to track Firefox's stable channel; at best, it's keeping the Tor Browser from falling too far behind ESR.

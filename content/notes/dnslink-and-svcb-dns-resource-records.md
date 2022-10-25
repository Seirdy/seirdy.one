---
title: "DNSLink and SVCB DNS resource records"
date: 2022-10-25T14:50:18-07:00
---

[SVCB DNS resource records](https://datatracker.ietf.org/doc/draft-ietf-dnsop-svcb-https/) (<abbr>RRs</abbr>) were introduced somewhat recently. They inform user-agents that a given resource exists at another endpoint, possibly with extra parameters. Functionality closely mirrors the `Alt-Svc` standard. A profile of SVCB exists in HTTPS <abbr>RRs</abbr>; Encrypted Client Hello and HTTP/3 are the main use-cases today.

To give <abbr>IPNS</abbr>-accessible services familiar names, I think SVCB is a better long-term solution than [DNSLink](https://www.dnslink.io/).

A related issue for the InterPlanetary Name System is [Issue 144 for the <abbr>IPFS</abbr> web browsers integration group](https://github.com/ipfs/in-web-browsers/issues/144); it discusses the viability of using `Alt-Svc` for this.

<aside><p>Syndicated to <a href="https://github.com/dnslink-std/community/discussions/2" class="u-syndication" rel="syndication">the DNSLink discussion forum</a> and <a href="https://pleroma.envs.net/notice/AOwGcaXk9ME4tYyUPQ" class="u-syndication" rel="syndication">the Fediverse</a>.</p></aside>

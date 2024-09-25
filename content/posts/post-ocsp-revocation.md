---
title: "Post-OCSP certificate revocation in the Web PKI"
description: "OCSP, including OCSP Stapling, is leaving the Web PKI. Here's a complete look at revocation beyond OCSP: its past, present, and possible futures."
date: "2024-09-25T11:29:38-04:00"
outputs:
    - html
#    - gemtext
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/objects/4371b456-e37f-487f-886d-8b4fd7b705c2'
    - title: 'Bluesky'
      url: 'https://bsky.app/profile/seirdy.one/post/3l4yhmtm7it2a'
---
<section role="doc-introduction" itemprop="backstory">

## Introduction

Today, <abbr title="Transport Layer Security">TLS</abbr> certificates in the Web public key infrastructure (<abbr>PKI</abbr>) have long validity: almost all remain valid for at least _three months!_ An attacker compromising a certificate early enough in its lifetime[^1] keeps it compromised for months. Certificate revocation addresses this problem: a client must know to distrust a certain key for a domain, even if the valid key hasn't expired yet.

The issue? Billions of clients use the Web <abbr>PKI</abbr>: browsers, crawlers, link-preview generators, chatbots, email servers, email clients, etc. The easy part for a <abbr>CA</abbr> is knowing when to revoke a certificate.[^2] The hard part is telling every client to ignore a certain compromised certificate. All approaches to revocation trace their roots to at least one of the following:

- Certificate Revocation Lists (<abbr>CRLs</abbr>)
- Online Certificate Status Protocol (<abbr>OCSP</abbr>)
- Short-lived certificates

Initial approaches to each option showed major shortcomings. All three evolved:

- <abbr>CRLs</abbr> became sharded <abbr>CRLs</abbr> and combined client-side "summarized <abbr>CRLs</abbr>".

- <abbr>OCSP</abbr> became <abbr>OCSP</abbr> stapling and <abbr>OCSP</abbr> Must-Staple. It almost evolved into <abbr>OCSP</abbr> Expect-Staple. The shutdown of <abbr>OCSP</abbr> resolvers impacts all three; we need alternatives.

- Short-lived certificates became <abbr>ACME-STAR</abbr> and delegated credentials.

I'll break down each of these, along with some of my proposals. We should double down on client-side summarized <abbr>CRLs</abbr>[^3] and work towards reducing certificate lifetimes.

Most solutions still have caveats or won't gain mainstream adoption for several years. Until then, I propose offering six-week certificates.

### Motivation

Why discuss revocation now?

In August 2023, the <abbr title="Certificate Authority">CA</abbr>/Browser Forum voted in favor of [Ballot SC-064 v4](https://cabforum.org/2023/07/14/ballot-sc-063-v4-make-ocsp-optional-require-crls-and-incentivize-automation/). This ballot made the Online Certificate Status Protocol (<abbr title="Online Certificate Status Protocol">OCSP</abbr>) optional and outlined where <abbr>CAs</abbr> should focus instead. {{<mention-work itemtype="BlogPosting">}}<span itemscope="" itemtype="https://schema.org/Organization" itemprop="publisher">Let's Encrypt</span> published {{<cited-work url="https://letsencrypt.org/2024/07/23/replacing-ocsp-with-crls.html" rend="true" name="Intent to End <abbr>OCSP</abbr> Service" extraName="headline">}} on <time class="dt-published published" itemprop="datePublished">2024-07-23</time>{{</mention-work>}}, and will likely shut down its <abbr>OCSP</abbr> service sometime in late 2025 or 2026. Let's Encrypt issues <abbr title="Transport Layer Security">TLS</abbr> certificates for almost 60% of websites.[^4] This means most websites will soon have no more <abbr>OCSP</abbr>: while it might live on in other networks, <abbr>OCSP</abbr> will leave the Web <abbr>PKI</abbr>.

The announcement from Let's Encrypt merely declares intent. Some staff members show openness to a migration period for stapling, with at least a year before any changes.[^5] After the migration period, I expect webmasters to lose the option for <abbr>OCSP</abbr> Stapling or working <abbr>OCSP</abbr> Must-Staple. Without <abbr>OCSP</abbr>, most clients either trust all certificates from their issuance until expiry or have to constantly update compressed revocation filters ("summarized <abbr title="Certificate Revocation Lists">CRLs</abbr>") to check the revocation status of a certificate. We can also look to other solutions on the horizon.

Note: I made this article <abbr title="Automatic Certificate Management Environment">ACME</abbr>-centric.[^6] Most websites use <abbr>ACME</abbr> to automate the generation and renewal of certificates validated by a certificate authority (<abbr>CA</abbr>). Where non-<abbr>ACME</abbr> setups are relevant, I disregard them. Use <abbr>ACME</abbr>!

### Target audience

I wrote this for people with some basic familiarity with <abbr>TLS</abbr>, certificate authorities, and maybe <abbr>OCSP</abbr>; this represents what I knew before I started writing this article. I did my best to link other resources and define terms where appropriate.[^7] The [Let's Encrypt glossary](https://letsencrypt.org/docs/glossary/) might assist you.

For readers less familiar, I recommend {{<mention-work itemtype="TechArticle">}}{{<cited-work url="https://carrickbartle.com/certificates.html" rend="true" name="Intro to <abbr>TLS</abbr> certificates" extraName="headline">}} by {{<indieweb-person itemprop="author" first-name="Carrie" last-name="Bartle" url="https://carrickbartle.com/">}}{{</mention-work>}} for a primer on how <abbr>TLS</abbr> certificates and Web <abbr>PKI</abbr> work.

{{< transcribed-image type="comic" itemtype="VisualArtwork" id="xkcd-2501" >}}

#### <span itemprop="name">xkcd comic: Average Familiarity</span> {#average-familiarity}

{{< transcribed-image-figure id="xkcd-2501" has-transcript="true" >}}

{{< picture name="xkcd_2501" alt="Comic: two stick figures talking to each other. Transcript follows." >}}

<figcaption itemprop="caption">

I'm not an "expert" but this comic captures how the first draft of this article read. From <a itemprop="url" href="https://xkcd.com/1309">xkcd</a>

</figcaption>

{{< /transcribed-image-figure >}} {{< transcribed-image-transcript >}}

<p>Ponytail and Cueball are talking. Ponytail has her hand raised, palm up, towards Cueball.</p>


Ponytail
: Silicate chemistry is second nature to us geochemists, so it's easy to forget that the average person only knows the formulas for olivine and one or two feldspars.

Cueball
: And quartz, of course.

Ponytail
: Of course.

A caption below the panel reads, <q>Even when they're trying to compensate for it, experts in anything wildly overestimate the average person's familiarity with their field.</q>

<p role="doc-credit">Transcript from the <a href="https://explainxkcd.com/wiki/index.php/2501:_Average_Familiarity#Transcript">explain xkcd wiki entry for xkcd #2501</a>.</p>

{{< /transcribed-image-transcript >}} {{< /transcribed-image >}}

</section>

{{<toc>}}

## Certificate Revocation Lists

<abbr title="Certificate Authorities">CAs</abbr> regularly publish live lists of revoked certificates called <dfn>Certificate Revocation Lists (<abbr>CRLs</abbr>)</dfn>. When revoking a certificate, <abbr>CAs</abbr> update <abbr>OCSP</abbr> responses and push an entry to a <abbr title="Certificate Revocation List">CRL</abbr>. They have up to a seven-day deadline to do so (less in certain cases[^8]). <abbr>CAs</abbr> annotate entries with one of ten possible reasons for revocation. See {{<mention-work itemtype="TechArticle" itemprop="citation">}}{{<cited-work rend="true" name="<abbr title=\"Request for Comments\">RFC</abbr> 5280: Internet X.509 Public Key Infrastructure Certificate and Certificate Revocation List (<abbr>CRL</abbr>) Profile" extraName="headline" url="https://www.rfc-editor.org/rfc/rfc5280.html">}}{{</mention-work>}} for details on the contents of <abbr>CRLs</abbr>.

<abbr>CRLs'</abbr> large size and short validity make them a poor fit for client-side revocation checking: most clients can't regularly re-download such large lists for revocation lookups. <abbr>CAs</abbr> started offering <abbr>OCSP</abbr> as a lightweight alternative. <abbr>CRLs</abbr> are far from obsolete, though: they support transparency, research, and other revocation technologies.

<abbr>CRLs</abbr>, the oldest revocation method in this article, only recently joined the <abbr>CA</abbr>/Browser Baseline Requirements in Ballot SC-064 (the ballot I mentioned in [the "motivation" section](#motivation)).[^9]

## Online Certificate Status Protocol (<abbr>OCSP</abbr>)

Before trusting a certificate, browsers can ask its issuing <abbr title="Certificate Authority">CA</abbr> if the <abbr>CA</abbr> has revoked the certificate by using the Online Certificate Status Protocol (<abbr>OCSP</abbr>). <abbr>OCSP</abbr> has a host of problems:


Performance
: Asking a <abbr>CA</abbr> about a new certificate before trusting it and loading a page can take hundreds of milliseconds or even seconds. That slows down page loads.

Privacy
: This leaks domain names to the <abbr>CAs</abbr> in question. Users can always switch their DNS providers to options they trust, but they can't select a different place to check for <abbr>OCSP</abbr> status.

<abbr>CA</abbr> reliability
: A <abbr>CA</abbr> needs good uptime and needs to respond to a massive number of requests from HTTPS clients worldwide. <abbr>OCSP</abbr>-supporting clients query every certificate from the <abbr>CA</abbr> they encounter and expect a low-latency response.

Robustness
: A bad firewall or a poor connection could prevent successful and timely connections to the <abbr>CA</abbr> for an <abbr>OCSP</abbr> check. For this reason, **failed live <abbr>OCSP</abbr> checks typically soft-fail.** If the <abbr>OCSP</abbr> check doesn't succeed or takes too long, the client trusts the certificate. An attacker can also block connections to the <abbr>CA</abbr> to get a victim to trust a compromised certificate.

### <abbr>OCSP</abbr> Stapling and Must-Staple

<dfn itemprop="teaches"><abbr>OCSP</abbr> Stapling</dfn> addresses performance, privacy, and <abbr>CA</abbr> reliability with a certificate extension. A web server can run an <abbr>OCSP</abbr> check on its own certificates and attach the successful responses to them, refreshing them periodically. Clients receiving a fresh signed <abbr>OCSP</abbr> response with a certificate need not fetch a copy themselves. It does slightly increase the size of a certificate, but the size increases pale in comparison to the footprint of live <abbr>OCSP</abbr> lookups.[^10]

<dfn itemprop="teaches"><abbr>OCSP</abbr> Must-Staple</dfn> addresses <abbr>OCSP's</abbr> robustness concerns. A certificate can include metadata instructing clients to reject the certificate if it doesn't include a successful stapled <abbr>OCSP</abbr> response. With <abbr>OCSP</abbr> Must-Staple, certificates behave almost as if they have a short one-week lifetime.

Must-Staple has limited adoption: fewer than 1% of all unexpired <abbr title="Transport Layer Security">TLS</abbr> certificates use this feature.[^11] Any failure in the <abbr>OCSP</abbr> pipeline means downtime. This risk prevents most <abbr>ACME</abbr> clients from making it the default setting. Most webmasters won't find the benefits worth the cost of adoption and the risks involved. See {{<mention-work itemtype="BlogPosting">}}{{<cited-work url="https://blog.mozilla.org/security/2015/11/23/improving-revocation-ocsp-must-staple-and-short-lived-certificates/" rend="true" name="Improving Revocation: <abbr>OCSP</abbr> Must-Staple and Short-lived Certificates " extraName="headline">}} by {{<indieweb-person itemprop="author" first-name="Mark" last-name="Goodwin" url="https://mastodon.social/@computerist">}}, published on <time class="dt-published published" itemprop="datePublished">2015-11-23</time>{{</mention-work>}} for Mozilla's rationale.

### <abbr>OCSP</abbr> Expect-Staple

The <abbr>OCSP</abbr> Expect-Staple proposal gained some adoption from a limited number of websites and received some browser-side experimentation but never took off. {{<mention-work itemtype="BlogPosting">}}{{<cited-work url="https://scotthelme.co.uk/ocsp-expect-staple/" rend="true" name="<abbr>OCSP</abbr> Expect-Staple" extraName="headline">}} by {{<indieweb-person itemprop="author" first-name="Scott" last-name="Helme" url="https://scotthelme.co.uk/">}}{{</mention-work>}} introduces the concept.

The design of <abbr>OCSP</abbr> Expect-Staple resembles HTTP Strict Transport Security (<abbr>HSTS</abbr>), so let's examine <abbr>HSTS</abbr> first. HTTPS-only websites almost always keep an HTTP site live on port 80 for redirection to the HTTPS site. An attacker can still intercept unencrypted HTTP traffic on the HTTP request before the HTTPS redirection. <abbr>HSTS</abbr> mitigates this: the website instructs the browser to prefer HTTPS for all future navigation. Websites can opt-in to a client-side list of domains forbidding plaintext HTTP, called the <abbr>HSTS</abbr> Preload list. Membership in the preload list ensures that <abbr>TLS</abbr> protects the initial request to a website, too.[^12]

<dfn itemprop="teaches"><abbr>OCSP</abbr> Expect-Staple</dfn> applies the concepts behind <abbr>HSTS</abbr> to <abbr>OCSP</abbr> Must-Staple instead of HTTPS. In a response header, the website can tell browsers to expect stapling on all future renewals of a given certificate. Browsers will know to reject any certificates without a stapled <abbr>OCSP</abbr> response, should a malicious server send a revoked certificate and omit the staple.

[Chromium experimented with Expect-Staple in 2016](https://docs.google.com/document/d/1aISglJIIwglcOAhqNfK-2vtQl-_dWAapc-VLDh-9-BE/edit) and even had an initial preloaded list, but [Chromium later retired all support](https://issues.chromium.org/issues/41230705). Then, it retired all support for <abbr>OCSP</abbr> (including stapling and Must-Staple).

### Poor implementations

[The most popular Web servers (uncustomized Apache and Nginx) have poor support for stapling](https://blog.hboeck.de/archives/886-The-Problem-with-OCSP-Stapling-and-Must-Staple-and-why-Certificate-Revocation-is-still-broken.html). I'm unfamiliar with Apache, but Nginx will happily serve a stale <abbr>OCSP</abbr> response. [Nginx has a broken DNS resolver that can cache the wrong IP of an <abbr>OCSP</abbr> stapling server](https://github.com/mozilla/server-side-tls/issues/283). I worked around the issue with a custom version of [certbot-ocsp-fetcher](https://github.com/tomwassenberg/certbot-ocsp-fetcher), but I don't expect most system administrators to use a shell script to work around broken servers or to migrate to something that gets it right (such as Caddy). When the most popular web servers ship broken stapling implementations for _years,_ we need to try something else.

## Querying <abbr>CRL</abbr> shards

Recall that most clients can't query and update giant <abbr>CRLs</abbr> directly. This inefficiency motivated the creation of <abbr title="Online Certificate Status Protocol">OCSP</abbr>. Ballot SC-063 also permits <abbr>CAs</abbr> to partition their <abbr>CRLs</abbr> into smaller "shards". Each shard has a publicly available URL.

<abbr>OCSP</abbr>-enabled certificates contain an <abbr>OCSP</abbr> URL in their metadata for clients to submit <abbr>OCSP</abbr> queries. Let's Encrypt plans to replace these <abbr>OCSP</abbr> URLs with the URL to a <abbr>CRL</abbr> shard containing revocation information for that certificate. Instead of querying a <abbr>CA's</abbr> <abbr>OCSP</abbr> endpoint, clients download the relevant <abbr>CRL</abbr> shard containing the revocation status of several certificates at a time.[^13]

Downloading the revocation status for many certificates represents a partial privacy improvement. Querying entire shards instead of individual domains adds entropy: a <abbr>CA</abbr> doesn't know which entry on a <abbr>CRL</abbr> shard a client needs to check.

Clients will also see bigger downloads, as shards have footprints several times the size of single <abbr>OCSP</abbr> lookups. Remember that "modern" websites often contain sub-resources from many domains. As <abbr>CRL</abbr> shard downloads accumulate, the small size savings over summarized <abbr>CRLs</abbr> (see next section) might not justify the privacy risk.

<abbr>CAs</abbr> find this solution easier than <abbr>OCSP</abbr>, but I don't think this resolves most of the <abbr>OCSP</abbr> issues clients experience. Directly querying <abbr>CRL</abbr> shards only partially mitigates each of the four <abbr>OCSP</abbr> issues I enumerated.

## Client-side summarized <abbr>CRLs</abbr>

Browsers subset or compress the giant set of all <abbr title="Certificate Revocation Lists">CRLs</abbr> into compressed client-side lists with frequent push-based updates to keep browsing traffic private. Chromium CRLSets subset the complete set of <abbr>CRLs</abbr> with some inclusion criteria, while Mozilla's CRLite uses Bloom filters to compress a list of all current and revoked certificates. [Let's Encrypt refers to both technologies as <dfn itemprop="teaches">summarized <abbr>CRLs</abbr></dfn>](https://letsencrypt.org/2022/09/07/new-life-for-crls.html).

### Google's approach: CRLSets

Chromium has a data set called "CRLSets". <dfn itemprop="teaches">[CRLSets](https://www.chromium.org/Home/chromium-security/crlsets/)</dfn> initially contained a small fraction of all unexpired and currently-revoked certificates, preferring high-impact and Extended-Validation sites over smaller, unimportant domains such as `seirdy.one`. It later expanded to cover certain reasons for revocation.

My search through scattered documentation ended with three excellent articles:

1. {{<mention-work itemprop="citation" role="doc-credit" itemtype="TechArticle">}}{{<cited-work url="https://www.imperialviolet.org/2012/02/05/crlsets.html" rend="true" name="Revocation checking and Chrome's <abbr>CRL</abbr>" extraName="headline">}} by {{<indieweb-person itemprop="author" first-name="Adam" last-name="Langley" url="https://www.imperialviolet.org/">}}, published on <time class="dt-published published" itemprop="datePublished">2012-02-05</time>{{</mention-work>}}, introduces the concept and motivation behind CRLSets.

2. {{<mention-work itemprop="citation" role="doc-credit" itemtype="TechArticle">}}{{<cited-work url="https://www.imperialviolet.org/2014/04/29/revocationagain.html" rend="true" name="Revocation still doesn't work" extraName="headline">}} by {{<indieweb-person itemprop="author" first-name="Adam" last-name="Langley" url="https://www.imperialviolet.org/">}}, published on <time class="dt-published published" itemprop="datePublished">2014-04-19</time>{{</mention-work>}}, explains why the Chromium team didn't design CRLSets to scale to all revoked certs. He suggests probabilistic data structures but cites their inherent error rate.

3. {{<mention-work itemprop="citation" role="doc-credit" itemtype="ScholarlyArticle">}}{{<cited-work rend="true" name="An End-to-End Measurement of Certificate Revocation in the Web's <abbr title=\"Public Key Infrastructure\">PKI</abbr>" extraName="headline" url="https://doi.org/10.1145/2815675.2815685">}}, published on <time class="dt-published published" itemprop="datePublished">2015-10-28</time>{{</mention-work>}}, evaluates several certificate revocation mechanisms and finds that CRLSets covered 0.35% of all revoked certificates.

In 2024 (this year, at the time of publishing), Chromium expanded CRLSets to cover compromised keys to improve the situation. CRLSets still don't cover mass revocation events due to scalability issues.

{{<quotation>}}

<blockquote itemprop="text">

We've added support for certificate revocations due to key compromise to CRLSet, and enabled enforcement. Any certificate revoked with the key compromise reason code should now be blocked by Chrome clients within 24-48 hours. This approach should work for day-to-day revocation, but will not work for mass revocation events, due to a limit on the max size of a CRLSet.

</blockquote>
{{<quotecaption partOfType="TechArticle">}}
{{<cited-work name="Chrome Security 2024 Q2 Update" extraName="headline" url="https://www.chromium.org/Home/chromium-security/quarterly-updates/#q2-2024">}}
{{</quotecaption>}}
{{</quotation>}}

Given the subset of revoked certificates covered by CRLSets, I don't consider them a robust solution to certificate revocation. This remains Chromium's single current method for certificate revocation. Firefox used a similar mechanism called OneCRL, but it later migrated to a new approach called CRLite with full coverage.

### Mozilla's approach: CRLite

The second article by Adam Langley mentioned compressing certificate revocation lists into probabilistic error-prone data structures for better coverage with a small size. Firefox's <dfn itemprop="teaches">[CRLite](https://blog.mozilla.org/security/2020/01/09/crlite-part-2-end-to-end-design/)</dfn> takes this approach with Bloom filters but without the errors.

Certain browsers (Safari, Chromium/Edge) require <abbr>CAs</abbr> to participate in <dfn itemprop="teaches">Certificate Transparency (<abbr>CT</abbr>)</dfn>. Certificate Transparency logs are append-only distributed ledgers that publicize all <abbr>CA</abbr>-issued certificates for public scrutiny.[^14] All certificates in <abbr>CT</abbr> receive a signed certificate timestamp (<abbr>SCT</abbr>) cryptographically proving their presence in a <abbr>CT</abbr> log, which browsers can check. Safari, Chromium, and derivatives perform these checks; Firefox currently lacks support for <abbr>CT</abbr>.[^15]

The CRLite Bloom filter generation process can compare the filter against actual <abbr>CT</abbr> logs to remove all errors. The result has _complete_ coverage of certificate revocations with a tiny footprint and an error rate of zero!

CRLite has a much smaller storage footprint than the hundreds of megabytes CRLSets would need for complete coverage. I still find this footprint too large for sufficiently constrained clients. When it first rolled out, it weighed 10&nbsp;megabytes with a 580&nbsp;kilobyte daily download for updates. CRLite's footprint has at least doubled since then and continues to grow.[^16]

### Apple's approach: valid.apple.com

Apple adopted an approach similar to CRLite using Bloom filters; it's known as "valid.apple.com", or simply "valid". I found {{<mention-work itemtype="VideoObject">}} a now-unlisted <abbr title="Worldwide Developers Conference">WWDC</abbr> 2017 presentation called {{<cited-work name="Your Apps and Evolving Network Security" url="https://devstreaming-cdn.apple.com/videos/wwdc/2017/701jvytnoey2yc7222/701/701_hd_your_apps_and_evolving_network_security_standards.mp4">}} (<span itemprop="encodingFormat">video/quicktime</span>); the relevant part begins around <time datetime="PT17M45S" itemprop="startTime">00:17:45</time>.{{</mention-work>}} According to the 2017 presentation, when a lookup against Apple's summarized <abbr>CRL</abbr> has a positive signal, clients perform an <abbr>OCSP</abbr> lookup when no stapled response exists.

This approach reduces the number of live <abbr>OCSP</abbr> queries to leak less traffic and slow down fewer connections. At the time of writing, the device I tested still makes regular live <abbr>OCSP</abbr> checks.

I won't discuss valid.apple.com in detail because I'm unfamiliar with Apple's approach, but this article would be incomplete without mentioning it. Braver souls can [browse Apple's maze of public source code](https://opensource.apple.com/source/Security/) or [Apple's API documentation for Web <abbr>PKI</abbr> policies](https://developer.apple.com/documentation/security/policies). valid.apple.com lacks any meaningful documentation.

The documentation I cited comes from seven years ago. I suspect the approach has changed: the devices I tested seemed to make OCSP requests for every domain, and [a thread on Apple Developer Forums](https://forums.developer.apple.com/forums/thread/706629) seems to indicate that Apple stopped using client-side summarized <abbr>CRLs</abbr>. I expect major changes coming soon: Apple voted to make <abbr>OCSP</abbr> optional in SC-064.

### Shortcomings of summarized <abbr>CRLs</abbr>

As shown in the earlier section, revocation data sets such as CRLSets can't scale to cover all revoked certificates. Probabilistic filters can, but both have additional issues.

Summarized <abbr title="Certificate Revocation Lists">CRLs</abbr> make sense for browsers, but not for smaller clients. cURL, small chat apps, mail clients, feed readers, weather notifications, etc. all use HTTPS and all need a summarized <abbr>CRL</abbr> updated every few hours. This creates the need for an operating-system-managed summarized <abbr>CRL</abbr>, which I doubt would work well if OS-managed certificate bundles serve any indication.

Tiny embedded clients, Internet of Things devices, machines running ancient releases of stable-release distros,[^17] retro computers, etc. won't constantly update an evergreen multi-megabyte revocation filter. Getting a live-updating compressed summarized <abbr>CRL</abbr> on short-lived spin-up-spin-down servers might require effort from cloud vendors. Short-lived certificates make for a more realistic option to cater to such clients.

### Let's Revoke

Unlike the other options in this section, [Let's Revoke](https://www.ndss-symposium.org/ndss-paper/lets-revoke-scalable-global-certificate-revocation/) is just a proposal. Like CRLite, Let's Revoke involves pushing all active and revoked certificates to a client in a highly-compressed form. However, it scales far better than existing options.

<dfn itemprop="teaches">Let's Revoke</dfn> requires changes from <abbr title="Certificate Authorities">CAs</abbr>: they need to generate Certificate Revocation Vectors (CRVs), small bit-vectors, and include them in every issued certificate. Under Let's Revoke, a <abbr>CA</abbr> pushes an incrementally-updated, highly-compressed archive of all CRVs for active revoked certificates to clients. Clients then use the archive to look up every certificate from that <abbr>CA</abbr>. Let's Revoke uses a fraction of CRLite's storage footprint.

For extra-constrained clients, the <abbr>CA</abbr> can offer pull-based Let's Revoke checks similar to <abbr>OCSP</abbr> and querying <abbr>CRL</abbr> shards. I'll disregard live Let's Revoke lookups in this article, as <abbr>CAs</abbr> have already settled on using <abbr>CRL</abbr> shards for live lookups as the successor to <abbr>OCSP</abbr>.

Getting all <abbr>CAs</abbr> on board will prove difficult: getting them on board with certificate transparency, signed certificate timestamps, and <abbr>CRLs</abbr> took a long time. Let's Revoke only offers binary information about revocation status (no reasons, no revocation timestamp, etc.), so clients capable of handling CRLite's footprint might find Let's Revoke less useful. However, its ability to scale with a tiny footprint makes it promising for lightweight clients such as Internet of Things devices.

## <abbr>ACME</abbr> Renewal Information (<abbr>ARI</abbr>)

<dfn itemprop="teaches"><abbr>ACME</abbr> Renewal Information (<abbr>ARI</abbr>)</dfn> is a protocol that notifies a server's <abbr>ACME</abbr> client when a certificate needs renewal. It can tell an <abbr>ACME</abbr> client when a certificate grows stale (e.g., after <time datetime="PT1440H">60 days</time> for a <time datetime="PT2160H">90-day</time> certificate) or upon certificate revocation to facilitate quick renewal.

Other revocation checks on this page ensure clients don't trust revoked certificates. <abbr>ARI</abbr> ensures servers don't offer them. Even though <abbr>ARI</abbr> isn't a revocation check, an article describing the complete landscape of revocation checking should at least mention it.

<abbr>ARI</abbr> complements other forms of revocation. Both <abbr>ARI</abbr> and <abbr title="Online Certificate Status Protocol">OCSP</abbr> Stapling get servers with long-lived certificates to check in with <abbr>CAs</abbr> more often to ensure that their certificates remain unrevoked.

The [lego](https://go-acme.github.io/lego/) <abbr>ACME</abbr> client supports <abbr>ARI</abbr> thanks to contributions from Let's Encrypt. See {{<mention-work itemtype="BlogPosting">}}{{<cited-work url="https://letsencrypt.org/2024/04/25/guide-to-integrating-ari-into-existing-acme-clients" rend="true" name="An Engineer’s Guide to Integrating <abbr>ARI</abbr> into Existing <abbr>ACME</abbr> Clients" extraName="headline">}} by {{<indieweb-person itemprop="author" first-name="Samantha" last-name="Frank" url="https://github.com/beautifulentropy">}}{{</mention-work>}} for more on the implementation.

## Short-lived certificates

Recall that <abbr>CAs</abbr> have a deadline to revoke a certificate; seven days represents the longest possible deadline. A certificate with a lifetime shorter than this can abstain from both <abbr>OCSP</abbr> and <abbr>CRLs</abbr>.[^18]

If we reduce a certificate's lifetime to less than one week, revocation becomes much less of a problem. Instead of "revoking" a certificate, a <abbr>CA</abbr> stops re-issuing certificates for a domain and waits for the most recent certificate to expire. The European Telecommunications Standards Institute (<abbr>ETSI</abbr>) calls certificates with a lifetime of no longer than <time datetime="PT168H">seven days</time> <dfn itemprop="teaches">short-lived certificates</dfn>.[^19]

Live <abbr>OCSP</abbr> checks, sharded <abbr>CRL</abbr> lookups, and summarized <abbr>CRLs</abbr> add centralized points of failure for client-side revocation look-ups. Attackers can block component updates, online <abbr>OCSP</abbr> checks, or <abbr>CRL</abbr> shard fetches.[^20] Short-lived certificates add no more points of failure.

Short-lived certificates come with their own set of challenges:

- Webmasters have narrow time windows to fix certificate issues. They'll need to set up monitoring, alerts, and backup <abbr>CAs</abbr> should they not want a <abbr>CA's</abbr> reliability to bottleneck their own.

- <abbr>CAs</abbr> need to issue certificates _far_ more often, increasing their load. Phasing out <abbr>OCSP</abbr> frees up some resources for them to do this, although <abbr>CAs</abbr> need much fewer resources for serving an <abbr>OCSP</abbr> response than for renewing a certificate.

- <abbr>CAs</abbr> need to improve their availability. Large ones can take down millions of services by going offline long enough.

Overcoming these obstacles will take much work. <abbr>ACME-STAR</abbr> and delegated credentials for <abbr title="Transit Layer Security">TLS</abbr> look like promising attempts to shorten the longevity of certificate trust in the Web <abbr title="Public Key Infrastructure">PKI</abbr>.

### <abbr>ACME-STAR</abbr>

{{<mention-work itemtype="TechArticle" itemprop="citation">}}{{<cited-work rend="true" name="<abbr title=\"Request for Comments\">RFC</abbr> 8739: Support for Short-Term, Automatically Renewed (<abbr>STAR</abbr>) Certificates in the Automated Certificate Management Environment (<abbr>ACME</abbr>)" extraName="headline" url="https://www.rfc-editor.org/rfc/rfc8739.html">}}{{</mention-work>}} outlines how <abbr>ACME-STAR</abbr> improves efficiency when issuing short-lived certificates at scale.

Requesting a certificate from a <abbr>CA</abbr> requires the <abbr>CA</abbr> to issue a certificate immediately, even during heavy load. Shrinking the issuance window from two months to mere days would dramatically increase this load. We require an alternative to issuing certificates on-demand. <abbr>CAs</abbr> already generate <abbr title="Online Certificate Status Protocol">OCSP</abbr> responses ahead of time and offer them for <abbr>ACME</abbr> clients to download and staple, so why should they handle short-lived certificates differently?

With <dfn itemprop="teaches"><abbr>ACME-STAR</abbr></dfn>, <abbr>CAs</abbr> can schedule certificate re-issuance, generating them ahead of time for <abbr>ACME</abbr> clients to download later. <abbr>ACME</abbr> clients no longer need to request certificate generation; instead, they regularly re-fetch the most recently generated certificate.

### Delegated credentials

An <dfn>Identifier Owner (<abbr>IdO</abbr>)</dfn> is a party that operates and controls an identifier (usually a domain name[^21]). Traditionally, <abbr>CAs</abbr> issue a <abbr title="Transit Layer Security">TLS</abbr> certificate to an <abbr>ACME</abbr> client operated by the <abbr>IdO</abbr>. Often, the <abbr>IdO</abbr> delegates another party with more infrastructure to serve responses on its behalf. How do we handle certificate issuance when the <abbr>IdO</abbr> delegates a separate <abbr>ACME</abbr> client operator?

Servers fronted by Content Delivery Networks (<abbr>CDNs</abbr>) generally trust the <abbr>CDN</abbr> to handle <abbr>TLS</abbr>. The <abbr>CDN</abbr> has a <abbr>TLS</abbr> certificate that verifies a trusted link between ownership of the certificate and use of the domain name. The <abbr>TLS</abbr> certificate doesn't, however, prove any involvement from the <abbr>IdO</abbr>, the one who holds and controls the domain name. The <abbr>IdO</abbr> ostensibly communicates with the <abbr>CDN</abbr> over one <abbr>TLS</abbr> connection, and the <abbr>CDN</abbr> communicates with clients using a separate <abbr>TLS</abbr> connection. We extend the trusted <abbr>CDN</abbr>-to-domain link to include the <abbr>IdO</abbr>-to-<abbr>CDN</abbr> link with a delegated credential.

A <dfn itemprop="teaches">delegated credential</dfn> is a short-lived certificate that the delegate (such as a <abbr>CDN</abbr>) frequently re-generates on behalf of its <abbr>IdO</abbr>. A <abbr>CA's</abbr> private keys sign a normal <abbr>TLS</abbr> certificate to show approval from the <abbr>CA</abbr>. A delegated credential receives one more signature: the <abbr>IdO's</abbr> longer-lived <abbr>TLS</abbr> key _also_ signs the delegated credential.

Delegated credentials solve three problems:

1. Clients can now verify that the <abbr>TLS</abbr> key sent by a <abbr>CDN</abbr> has approval from both the <abbr>CDN</abbr> and the <abbr>IdO</abbr> behind the <abbr>CDN</abbr>.

2. Clients receive the benefits of short-lived certificates: they don't have to worry about revocation.

3. We have a standard, vendor-neutral way for <abbr>CDNs</abbr> to generate certificates on behalf of an <abbr>IdO</abbr> without access to the <abbr>IdO's</abbr> private keys, in a more efficient manner than current approaches such as [Cloudflare's "Keyless SSL"](https://blog.cloudflare.com/announcing-keyless-ssl-all-the-benefits-of-cloudflare-without-having-to-turn-over-your-private-ssl-keys/).[^22]

Delegated credentials solve revocation of the certificate issued to the <abbr>CDN</abbr>, but not to the <abbr>IdO</abbr>. **Should a <abbr>CA</abbr> revoke an <abbr>IdO's</abbr> long-lived certificate, we need another revocation solution.** Delegated credentials address the need to _distrust_ <abbr>CDNs</abbr>, so we can't rely on <abbr>CDNs</abbr> to respond to the revocation of the <abbr>IdO</abbr> certificate.

I still find delegated credentials worthwhile in the context of revocation. They could lay a foundation for future advancements to enable revocation checking of both certificates: the delegate's and the <abbr>IdO's</abbr>.

{{<mention-work itemtype="TechArticle" itemprop="citation">}}{{<cited-work rend="true" name="<abbr title=\"Request for Comments\">RFC</abbr> 9345: Delegated Credentials for <abbr>TLS</abbr> and <abbr>DTLS</abbr>" extraName="headline" url="https://www.rfc-editor.org/rfc/rfc9345.html">}}{{</mention-work>}} outlines the mechanism that Cloudflare, Facebook, and Firefox use for delegated credentials with other rationales.

### <abbr>ACME-STAR</abbr> Delegation

<abbr title="ACME Short-Term, Automatically Renewed">ACME-STAR</abbr> lays its own foundation for delegated credentials in {{<mention-work itemtype="TechArticle" itemprop="citation">}}{{<cited-work rend="true" name="<abbr>RFC</abbr> 9115: An Automatic Certificate Management Environment (<abbr>ACME</abbr>) Profile for Generating Delegated Certificates" extraName="headline" url="https://www.rfc-editor.org/rfc/rfc9115.html">}}{{</mention-work>}}.

Don't feel too optimistic about this proposal: the version of delegated credentials used by Cloudflare, Facebook, and Firefox doesn't use <abbr>ACME-STAR</abbr>, let alone <abbr>ACME-STAR</abbr> Delegation. Its publication came almost two years after the final revision of <abbr>ACME-STAR</abbr> Delegation, and it doesn't mention <abbr>ACME-STAR</abbr> Delegation anywhere in its "Related Work" section.

For an introduction to the proposal, see {{<mention-work itemtype="BlogPosting">}}{{<cited-work name="Certificate Delegation with ACME and STAR Certificates" extraName="headline" url="https://yaronf.svbtle.com/certificate-delegation-with-acme-and-star-certificates">}} by {{<indieweb-person itemprop="author" first-name="Yaron" last-name="Scheffer" itemprop="author" url="https://yaronf.svbtle.com/">}}{{</mention-work>}}, one of its co-authors.

### My proposals {#own-proposals}

### Eliminating single points of failure {#no-spof}

Browser-summarized CRLs and live checks have a single point of failure: if a malicious party blocks component updates or live checks, they can block revocation information for a compromised certificate. We can mitigate this issue by decentralizing the points of failure. I like the idea of using [Signed HTTP Exchanges (<abbr>SXGs</abbr>)](https://wicg.github.io/webpackage/draft-yasskin-http-origin-signed-responses.html) to enable other parties to serve revocation filters while verifying their authenticity. I recall hearing proposals for serving them over a <abbr title="Web Real Time Communication">WebRTC</abbr> or WebTransport-based peer-to-peer swarm resembling WebTorrent.

We can also use <abbr>SXGs</abbr> to distribute CRLs or CRL shards.

### Enforcing short-term certificates {#enforcing-stc}

I have two proposals that can work alongside existing proposals for short-lived certificates.

Today, Certificate Authority Authorization (<abbr>CAA</abbr>) DNS records restrict the issuance of certificates in several ways:

- Restrict <abbr>CAs</abbr> permitted to issue certificates to a given domain.
- Restrict domain validation methods accepted (<abbr>RFC</abbr> 8657).
- Restrict <abbr>ACME</abbr> account URIs for a given <abbr>CA</abbr> (also <abbr>RFC</abbr> 8657).

<abbr>CAA</abbr> records should receive two more extensions:

- Restrict issuance to short-lived certificates.
- Restrict approved delegates for delegated credentials.

With the first extension, an attacker who triggers a misissuance would compromise it for a few days or hours  months. The second extension limits the potential for rogue delegates to serve traffic on behalf of an <abbr>IdO</abbr>.

I want to see the protections offered by Expect-Staple preloading for short-lived certificates. HTTPS Resource Records (<abbr>RRs</abbr>) or client-side preload lists can proactively tell clients to distrust any long-lived certificate for a domain.[^12]

These two proposals might initially seem identical and redundant, but they serve different purposes. A <abbr>CAA</abbr> extension tells <abbr>CAs</abbr> not to issue long-lived certificates; HTTPS clients ignore these. An HTTPS <abbr>RR</abbr> or client-side preload list tells clients not to trust a long-lived certificate if one already exists. Both proposals work together to protect against long-lived compromises on two fronts.

## Incremental change: shorter long-lived certificates

Every week we shave from the average certificate's lifetime means:

- One less week an attacker has to exfiltrate a key.
- One less week a compromised cert has to stay in a revocation list.

Every reduction we make to certificate lifetimes translates to smaller, more manageable revocation lists. Client-side Bloom filters can shrink, <abbr>CAs</abbr> can more gradually scale up and address difficulties with shorter lifetimes, and everybody has a lower likelihood of trusting a compromised certificate.

We don't have to go down to ten-day lifetimes right away. I propose starting by **shrinking lifetimes from three months to six weeks,** with biweekly renewal. This would encourage webmasters to set up alerting systems for renewal failures, as they'll have just two weeks to notice failures. It'll also potentially reduce the growth rate of revocation filters until we adopt better options.

### Requesting a shorter lifetime

<abbr>ACME</abbr> clients can set a `notBefore` and `notAfter` parameter in their certificate request to customize the exact certificate lifetimes. <abbr title="Certificate Authorities">CAs</abbr> that support this feature include:

- Sectigo (through ZeroSSL)
- Google Trust Services

<abbr>ACME</abbr> clients that support these parameters include:

- lego (recommended)
- acme.sh[^23]

<section role="doc-conclusion">

## Conclusion

With <abbr title="Online Certificate Status Protocol">OCSP</abbr> on its way out, the end draws near even for robust <abbr>OCSP</abbr>-based options such as <abbr>OCSP</abbr> Must-Staple. The future lies in:

1. Live lookups using sharded <abbr title="Certificate Revocation Lists">CRLs</abbr>
2. Summarized <abbr>CRLs</abbr> such as CRLite and Let's Revoke
3. Short-lived certificates using <abbr>ACME-STAR</abbr>. Delegated credentials only partially address revocation.

Live sharded-<abbr>CRL</abbr> lookups resemble live <abbr>OCSP</abbr> lookups. They differ in their lower operational complexity for <abbr>CAs</abbr>, added noise for a slight privacy improvement, and larger downloads. Summarized <abbr>CRLs</abbr> seem like the opposite approach to <abbr>OCSP</abbr>, downloading all current revocations in advance and checking them locally.

I find short-lived certificates a spiritual successor to both by applying <abbr>OCSP's</abbr> approach to certificate issuance. All three options represent improvements, but I find short-lived certificates more robust. Unfortunately, without better tools, short-lived certificates place a greater burden on webmasters. The fact that `seirdy.one` has a three-month certificate at the time of writing (admittedly, with <abbr>OCSP</abbr> Must-Staple) illustrates the height of this barrier as of late 2024.

That said, not all sites need to adopt short-lived certificates. Client-side revocation filters increase in total size and daily download footprint every year, but a large enough share of sites adopting short-lived certificates would mitigate that trend.

We have so much more work to do. Most non-browser clients support _none_ of the revocation solutions outlined on this page. All BoringSSL-based clients, including Chromium, have no support for <abbr>OCSP</abbr> (including <abbr>OCSP</abbr> stapling). This means most Web traffic lacks robust revocation checking. We need libraries that support delegated credentials. We need <abbr>CA</abbr> support and  server tools for <abbr>ACME</abbr> extensions, such as <abbr>ACME-STAR</abbr>.

### Aside: browser wars

[Firefox continues (rapidly) playing catch-up to Chromium on important aspects of browser security](https://seirdy.one/notes/2022/07/12/firefox-hardening-progress/), but its security edges ahead in some areas. It's the best at revocation checking, but the worst at alerting webmasters that they need to revoke.

- Firefox has the best support for <abbr>OCSP</abbr> (including <abbr>OCSP</abbr> Must-Staple and an option to require <abbr>OCSP</abbr> and make it hard-fail), years after Chromium removed all <abbr>OCSP</abbr> support.

- Firefox uses complete and error-free Bloom filters in CRLite. Chromium covers a fraction of all revoked certs in CRLSets. I'm too unfamiliar with Safari's approach to comment.

- At the time of writing, Firefox stands alone as the single browser with support for delegated credentials.

For years, Firefox has also been the only one of the three major browsers to lack any support for Certificate Transparency enforcement. Without enforcing <abbr>CT</abbr>, domain owners won't know when misissued certificates exist. All the revocation _checking_ in the world won't tell a domain owner when they need to revoke.

</section>

<section role="doc-acknowledgments">

## Ack&shy;nowledge&shy;ments {#acknowledgements}

Thanks to {{<indieweb-person itemprop="mentions" first-name="Andrew" last-name="Ayer" url="https://www.agwa.name/">}} for giving me detailed feedback on an early draft. He offered feedback that significantly improved this article by:

- Pointing out several areas needing elaboration.
- Linking me to Chromium's Q2 2024 update to fix my outdated information.
- Highlighting at least six factual errors.
- introducing me to valid.apple.com.
- Telling me about the relevance of Firefox lacking <abbr>CT</abbr> support.

{{<indieweb-person itemprop="mentions" name="Erin Alexis Owen Shepherd" url="https://erincandescent.net/">}} also reviewed a draft. Among other feedback, they encouraged me to mention pre-<abbr>OCSP</abbr> <abbr>CRLs</abbr>; this was the only part of the history of revocation I hadn't covered.

</section>


[^1]: See [the section with my proposals](#enforcing-stc) for an example of how an attacker can compromise certificate issuance for a domain unprotected by <abbr title="Certificate authority Authorization">CAA</abbr> DNS records. An attacker might also steal your private keys, but at that point, you have worse things to worry about.

[^2]: Relatively speaking, this part is _easier_ than revocation but that doesn't make it _easy._ High-volume free <abbr>CAs</abbr> such as Let's Encrypt can't handle individual requests for revocation. They usually revoke certificates in bulk when they experience an issue.

[^3]: I noticed people referring to CRLSets and CRLite as types of <abbr>CRLs</abbr> but I find the term inaccurate. A Certificate Revocation List contains revoked certificates for a given <abbr>CA</abbr> complete with metadata about reasons for revocation; browsers' revocation databases accumulate and subset or compress all <abbr>CRLs</abbr> into a single list or filter with limited metadata.

    I still needed a term that referred to CRLSets, CRLite, and Let's Revoke. Let's Encrypt picked "summarized <abbr>CRLs</abbr>", so I decided to compromise and use their term despite my reservations.

[^4]: Source: [W3Techs](https://w3techs.com/technologies/history_overview/ssl_certificate).

[^5]: For more staff comments, see some forum replies:

    - {{<mention-work itemtype="DiscussionForumPosting">}}{{<cited-work name="A multi-part answer to what will happen to Must-Staple" extraName="headline" url="https://community.letsencrypt.org/t/what-will-happen-to-must-staple/222397/7">}} by {{<indieweb-person itemprop="author" first-name="Aaron" last-name="Gable" itemprop="author" url="https://aarongable.com/">}}{{</mention-work>}}
    - {{<mention-work itemtype="DiscussionForumPosting">}}{{<cited-work rend="true"  name="We will make sure we have a solution for anyone with <abbr>OCSP</abbr> must-staple enabled" extraName="headline" url="https://lobste.rs/s/k4uuth/intent_end_ocsp_service#c_bzhdvt">}} by {{<indieweb-person itemprop="author" first-name="Matthew" last-name="McPherrin" itemprop="author" url="https://mcpherrin.ca/">}}{{</mention-work>}}.
    - {{<mention-work itemtype="DiscussionForumPosting">}}{{<cited-work rend="true"  name="This is probably at least a year, if not more, away" extraName="headline" url="https://news.ycombinator.com/item?id=41048161">}} by {{<indieweb-person itemprop="author" first-name="Matthew" last-name="McPherrin" itemprop="author" url="https://mcpherrin.ca/">}}{{</mention-work>}}.

    Both staff members find <abbr title="Online Certificate Status Protocol">OCSP</abbr>, even with Must-Staple, the wrong long-term solution.

[^6]: <abbr>ACME</abbr> stands for [Automatic Certificate Management Environment](https://en.wikipedia.org/wiki/Automatic_Certificate_Management_Environment), the standard protocol for automating certificate management between certificate authorities and servers.

[^7]: I even used the `dfn` HTML element like a good little HTML author. 🥺

[^8]: See section 4.9.1.1 of the <abbr>CA</abbr>/B Baseline Requirements[^9] for <time datetime="PT24H">24-hour</time> and <time datetime="PT120H">five-day</time> deadlines. The next section (section 4.9.1.2) describes seven-day deadlines. Past compromise of a subscriber key, authorization during certificate requests, or domain validation leaves a <abbr>CA</abbr> with <time datetime="PT24H">24 hours</time> to revoke.

    The Baseline Requirements exempt short-lived certificates from this deadline. I find the tradeoff acceptable, given how many compromised certificates still won't experience revocation in time but will be renewed.

[^9]: For all the requirements <abbr>CAs</abbr> must obey, read [the <abbr>CA</abbr>/Browser Baseline Requirements](https://cabforum.org/working-groups/server/baseline-requirements/documents/). I recommend reading through them for a fascinating overview of what <abbr>CAs</abbr> do.

[^10]: I oversimplified the nuance of the size increase. HTTPS clients that support <abbr>OCSP</abbr> cache live <abbr>OCSP</abbr> responses for a week, so later sessions will have a lower footprint than they would if the certificate had a stapled <abbr>OCSP</abbr> response. The footprint of a webpage might eclipse the footprint of a stapled <abbr>OCSP</abbr> response, but remember that HTTPS responses besides webpages exist. Instant messages, API responses, etc. tend to weigh less and often have significant latency constraints.

[^11]: [Ballot SC-064's Google Doc for background, rationale, and considerations](https://docs.google.com/document/d/180T6cDSWPy54Rb5d6R4zN7MuLEMShaZ4IRLQgdPqE98/mobilebasic) cites [a survey of all unexpired certificates at the time in <abbr title="Certificate Transparency">CT</abbr> logs](https://docs.google.com/document/d/1C0i0pOaI84gNccGzREPOrr5kMfpYkUEr87cBMZ09q_4/mobilebasic), finding that 0.0622% of all certificates used Must-Staple.

[^12]: I always found protecting the initial request with a client-side domain list a horrible, but effective, hack. We should have a way to query available connection methods for a domain using the correct venue for querying domain metadata set by a domain owner: DNS.

    We have a better solution today with HTTPS resource records! These specify how to access an HTTPS service before making an HTTPS connection. They list the availability of HTTP/2 and HTTP/3 (both require <abbr title="Transport Layer Security">TLS</abbr>), an IPv4/IPv6 address, and Encrypted Client Hello keys.

    In an alternate timeline where <abbr>OCSP</abbr> Expect-Staple took off, perhaps HTTPS resource records could include Expect-Staple metadata.

[^13]: If you're too impatient to wait for shard URLs embedded in certificates to roll out, look up the <abbr title="Certificate Revocation List">CRL</abbr> for a given certificate in [the Common <abbr>CA</abbr> Database (<abbr>CCADB</abbr>)](https://www.ccadb.org/resources). All three major browser vendors require <abbr>CA</abbr> participation in the <abbr>CCADB</abbr>; it's _the_ place to look for <abbr>CRLs</abbr> today, and therefore critical to their generation of summarized <abbr>CRLs</abbr>.

[^14]: Note that <abbr title="Certificate Transparency">CT</abbr> logs don't specify revocation status. Revocation happens _after_ certificate issuance; the <abbr>CT</abbr> log already lists the certificate by then.

[^15]: Follow Firefox's progress for implementing <abbr title="Certificate Transparency">CT</abbr> in [Bug 1281469](https://bugzilla.mozilla.org/show_bug.cgi?id=1281469).

[^16]: Updating summarized <abbr>CRLs</abbr> requires browsers to make regular automatic connections by default. [I find browser patchsets to turn off all automated connections misguided](https://seirdy.one/notes/2024/07/19/on-a-more-selective-google/) partly because they break revocation.

[^17]: Here's your regular reminder that [Debian Extended Long-Term Support exists](https://wiki.debian.org/LTS/Extended). Debian 8 "Jessie", released on <time>2015-04-25</time>, will continue to keep security professionals up at night with officially-endorsed third-party limited commercial support from Freexian through <time>2025-06-30</time>. Debian 12 support lasts till 2033.

[^18]: Yes, one week. Firefox skips revocation checking for certificates with a validity period shorter than <time datetime="PT240H">10 days</time>. Until recently, <abbr>CAs</abbr> and browsers agreed that the definition of a short-lived certificate required a validity period shorter than <time datetime="PT240H">10 days</time>. The <abbr>CA</abbr>/Browser Ballot SC-064 v4 specifies adopting the European Telecommunications Standards Institute (<abbr>ETSI</abbr>) specification for short-lived certificates,[^19] constraining their lifetime to the maximum time to process a revocation request. This will shorten the maximum lifetime of a short-lived certificate from 10 to <time datetime="PT168H">7 days</time> by <time>2026-03-15</time>.

[^19]: Fittingly, the canonical location of this <abbr>ETSI</abbr> specification lives on a server experiencing live <abbr>OCSP</abbr> failures. [I saved an archived copy of the <abbr>ETSI</abbr> specification for certificate profiles](https://web.archive.org/web/20240902154502if_/https://www.etsi.org/deliver/etsi_en/319400_319499/31941201/01.04.04_60/en_31941201v010404p.pdf).

[^20]: See [my own proposals](#no-spof) for a mitigation to summarized-CRLs' single point of failure.

[^21]: Valid identifiers in the Web <abbr title="Public Key Infrastructure">PKI</abbr> also include IP addresses and `.onion` addresses, but most <abbr>CAs</abbr> don't offer free certificates for those.

[^22]: {{<mention-work itemtype="BlogPosting">}}{{<cited-work url="https://blog.cloudflare.com/keyless-delegation/" rend="true" name="Delegated Credentials for <abbr>TLS</abbr>" extraName="headline">}} on <span itemscope="" itemtype="https://schema.org/Blog" itemprop="isPartOf">The Cloudflare Blog</span>{{</mention-work>}} describes this motivation in more detail. Essentially, a delegation credential gets rapidly pushed to the edge server. It represents an efficiency improvement over edge servers periodically requesting new certificates.

[^23]: I don't recommend acme.sh. Sandboxing complex shell scripts proves difficult. acme.sh has had severe arbitrary remote-code-execution vulnerabilities exploited by a <abbr>CA</abbr>: see [CVE-2023-38198](https://nvd.nist.gov/vuln/detail/CVE-2023-38198). While acme.sh developers fixed the vulnerabilities, they revealed the difficulty of securing a complex shell script that handles untrusted content.



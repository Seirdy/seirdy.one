---
outputs:
    - html
    - gemtext
title: Privacy policy
description: "Privacy policy for seirdy.one"
date: "2022-04-06T00:00:00+00:00"
---
This privacy policy is effective as of <time datetime="2022-04-06T00:00:00+00:00">2022-04-06</time>. In short: I only collect standard server logs, I purge them regularly, and I only share sanitized excerpts (e.g. when filing bug reports).

Scope
-----

This privacy policy applies to the following services:

1. The Web site <https://seirdy.one>

2. The hidden Web service [http://wgq3\[...\]d<wbr />.onion](http://wgq3bd2kqoybhstp77i3wrzbfnsyd27wt34psaja4grqiezqircorkyd.onion/ "{title='http://wgq3bd2kqoybhstp77i3wrzbfnsyd27wt34psaja4grqiezqircorkyd.onion'}"), accessible over the Tor network

3. The Gemini capsule <gemini://seirdy.one>

This policy only applies if served by one of those three services.

Information I collect
---------------------

My servers temporarily store server logs.

### Web server logs

For each request you make that reaches my Web servers, my server logs:

- Your public IP address
- The contents of your `user-agent` and `referer` (sic) headers
- The page you requested
- The time of the request
- The HTTP response code of the request

This is the information that [Nginx](https://nginx.org/) logs according to the default configurations in many operating systems.

None of the Web content I serve contains cookies or scripts, or collects any information not described by this Privacy Policy.

### Gemini server logs

My Gemini server logs:

- The page you requested
- The time of the request
- The Gemini response code of the request
- The language-code of the request

This is the information [Agate](gemini://qwertqwefsday.eu/agate.gmi) logs according to its default configuration.

### Hosting provider

These services currently run on, but do not necessarily endorse, virtual private servers owned by Digital Ocean. You can read Digital Ocean's [data processing agreement](https://www.digitalocean.com/legal/data-processing-agreement) to learn about how Digital Ocean processes data on these servers.

### Retention

Log entries will persist for between two and three days. Purges of server logs occur every day at <time datetime="03:35:12">00:00 UTC</time>

Before purging, I may preserve the "User-Agent" request headers of agents that clearly identify as bots.

### How I use your information

I use server logs to detect <abbr title="Denial of Service">DoS</abbr> attacks, misbehaving bots, and search engines to add to [my public collection](../posts/2021/03/10/search-engines-with-own-indexes/).

Information I share
-------------------

Searches performed on search boxes in the site footer and on the search page are powered by the [Search My Site](https://searchmysite.net/) API. When you search, your query---and only your query---is sent to Search My Site. No other information (e.g., your IP address or request headers) is sent. Information about how Search My Site may handle these anonymized queries is available in [its privacy policy](https://searchmysite.net/pages/privacy/).

No other information is automatically shared with any third-parties, to my knowledge.

I may share excerpts of of server logs with third parties if I am trying to resolve a technical issue. For example, I may submit an excerpt of an error log when filing a bug report. Any time I have to share such an excerpt, I remove or alter all identifying information. This includes, but is not limited to: IP addresses, timestamps, and any uniquely-identifying user-agent strings.

I do not remove or alter identifying information when sharing excerpts of bot traffic.

Web content and Gemini content may contain hyperlinks to other pages hosted by other parties whose privacy policies I do not govern.

My privacy policy ends here. Any information that follows is not part of a privacy policy.

Information I avoid
-------------------

The following describes information I _avoid receiving_ when serving Web content, as well as information I prevent users from _accidentally transmitting_ to third parties.

No Web content governed by these policies makes any connections to parties that are not governed by this Privacy Policy, when rendered in a standards-compliant browser.

By default, web browsers may share pages a user visits with third parties by loading third-party content (e.g. hotlinked images, third-party frames, etc). I have disabled this behavior with a `Content-Security-Policy` HTTP header that forbids all third-party content.

By default, web browsers may share arbitrary information with a server through HTTP headers; these headers could include fingerprintable information unintentionally (client-hints, do-not-track) or intentionally (Chromium's upcoming advertising identifiers). I do not log any HTTP headers not explicitly mentioned in the "Web server logs" section, but I cannot prevent user agents from sending a header ahead of time.

By default, web browsers can share near-arbitrary identifying data with a server by executing near-arbitrary JavaScript, or store this information for future transmission. I have disabled this behavior with a `Content-Security-Policy` HTTP header that forbids script loading (`script-src: none`), script execution (`sandbox`), and making connections for any purpose other than downloading a page a user navigated to (`connect-src`).

By default, user agents using HTTPS may contact a certificate authority to check the revocation status of an TLS certificate. I have disabled and replaced this behavior by including an "OCSP Must-Staple" directive in the TLS certificates used by my Web servers.

By default, user agents using HTTP or HTTPS may share a "referring" location with the destination website when following a link. I have disabled this by sending a `Referrer-Policy: no-referrer` header.

By default, Web browsers may share characteristics about the user's hardware, connection type, and personalizations using Client Hints and media queries. Browsers may request Web content according conditionally, in response to a `media` attribute in HTML or XHTML documents. Browsers may leverage stylesheets that use media queries to select varying `background-image` files. No Web content on seirdy.one will send network traffic in response to media queries except <code>prefers-color-<wbr />scheme</code>, assuming the use of a standards-compliant browser. Media queries and client hints will have no impact on HTTP responses except for dark image variants. This is a single binary piece of information that isn't enough to let me realistically identify anyone.

By default, many networks and Internet service providers often alter requests by redirecting them or injecting content. I have prevented this behavior by using a secure TLS cipher suite.


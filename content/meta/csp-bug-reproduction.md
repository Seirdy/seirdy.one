---
outputs:
    - html
title: "CSP bug reproduction"
date: "2022-11-10T18:05:00-08:00"
description: "A demonstration page to help diagnose Content-Security-Policy issues in browser software."
---
If you're on this page, chances are you followed a link from a Content-Security-Policy (<abbr>CSP</abbr>)-related bug report. This page should help diagnose the offending part of the <abbr>CSP</abbr>.

I made this page because [I noticed my site breaking browser software]({{<relref "/notes/things-my-site-breaks.md">}}), and wanted to fix said software.

What this page demonstrates
---------------------------

This is a test page that demonstrates the following Content-Security-Policy (<abbr>CSP</abbr>):

```
default-src 'none' 'report-sample';img-src 'self';style-src 'sha256-7cS8Hu9ov7dRhfioeeb9J8mtB9/iLLpVIZsMM+BJUcs=' 'report-sample';frame-ancestors 'none';base-uri 'none';form-action https://seirdy.one/webmentions/receive https://seirdy.one/search/;manifest-src 'self';sandbox allow-same-origin allow-scripts allow-forms;report-uri https://collector.seirdy.one;connect-src https://collector.seirdy.one
```

Here's a multi-line version, to reduce horizontal scrolling:

```
default-src 'none' 'report-sample';
img-src 'self';
style-src 'sha256-HASH' 'report-sample';
frame-ancestors 'none';
base-uri 'none';
form-action https://seirdy.one/webmentions/receive https://seirdy.one/search/;
manifest-src 'self';
sandbox allow-same-origin allow-scripts allow-forms;
report-uri https://collector.seirdy.one;
connect-src https://collector.seirdy.one
```

How to use this page
--------------------

All pages on my site contain a strict <abbr>CSP</abbr>. Most pages on my site have a <abbr>CSP</abbr> containing a `sandbox` directive that does **not** specify the `allow-scripts` parameter. Here's the CSP for most of my other pages, such as my homepage:

```
default-src 'none';
img-src 'self';
style-src 'sha256-HASH';
frame-ancestors 'none';
base-uri 'none';
form-action https://seirdy.one/webmentions/receive https://seirdy.one/search/;
manifest-src 'self';
upgrade-insecure-requests;
sandbox allow-same-origin allow-forms
```

This page has a <abbr>CSP</abbr> that differs in three ways:

- It includes a reporting endpoint
- It specifies an `allow-scripts` parameter on its `sandbox` directive
- It removes `upgrade-insecure-requests`.[^1]

Additionally, I have a 404 page that includes a blank `sandbox` directive (i.e., it has no parameters such as `allow-same-origin`).

Some browser software breaks upon encountering strict <abbr>CSPs</abbr>. It's difficult to pinpoint whether the offending CSP directive is a fetch directive (`default-src`, `script-src`, `style-src`, etc.), or if it's the `sandbox` directive without `allow-scripts`.

Try reproducing the bug on the following pages:

1. [This page's canonical location](https://seirdy.one/meta/csp-bug-reproduction/)
2. [My homepage](https://seirdy.one/)
3. <a href="https://seirdy.one/sample-404/" rel="nofollow">My 404 page</a>

Note the following:

- If you can reproduce the bug on all three pages: the offending directive is probably a fetch directive.

- If you can _not_ reproduce the bug on this page, but _can_ reproduce the bug on my homepage and my 404 page: the offending directive is a `sandbox` directive that blocks scripts (no `allow-scripts` present).

- If you can only reproduce the bug on my 404 page: the offending directive is `sandbox` without `allow-same-origin`.

Other places to test
--------------------

Here are some more sites with very strict <abbr>CSPs</abbr> containing `sandbox` directives:

- [meh.is](https://meh.is/)
- [sysrq.in](https://sysrq.in/en/)
- [artemislena.eu](https://artemislena.eu/)
- [mdleom.com](https://mdleom.com/)

If you feel the need to regularly test a specific CSP, I recommend using netcat. In a <abbr>UNIX</abbr>-like environment, save this to an executable file and run it:

```
#!/bin/sh

set -e -u

while true; do echo "\
HTTP/1.1 200 OK
Content-Type: text/html;charset=UTF-8
Content-Security-Policy: default-src 'none'; frame-ancestors 'none'; base-uri 'none'; form-action 'none'; upgrade-insecure-requests; sandbox

<!DOCTYPE html>
<html><body>poggers</body></html>\
" | nc -l 8000; done
```

You'll get a plain page with the specified CSP on port 8000. Edit as you see fit.


[^1]: I removed `upgrade-insecure-requests` so that my Tor onion service could have the same <abbr>CSP</abbr> as this page. The onion service does not support TLS: TLS on onion services is redundant, and no certificate authority offers free <samp>.onion</samp> certificates.



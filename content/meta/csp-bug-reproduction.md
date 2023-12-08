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
default-src 'none' 'report-sample';img-src 'self';style-src 'sha256-7cS8Hu9ov7dRhfioeeb9J8mtB9/iLLpVIZsMM+BJUcs=' 'report-sample';frame-ancestors 'none';base-uri 'none';form-action https://collector.seirdy.one/webmentions/receive https://seirdy.one/search/;manifest-src 'self';media-src 'self';sandbox allow-same-origin allow-scripts allow-forms;report-uri https://collector.seirdy.one;connect-src https://collector.seirdy.one
```

Here's a multi-line version, to reduce horizontal scrolling:

```
default-src 'none' 'report-sample';
img-src 'self';
style-src 'sha256-HASH' 'report-sample';
frame-ancestors 'none';
base-uri 'none';
form-action https://collector.seirdy.one/webmentions/receive https://seirdy.one/search/;
manifest-src 'self';
media-src 'self';
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
form-action https://collector.seirdy.one/webmentions/receive https://seirdy.one/search/;
manifest-src 'self';
upgrade-insecure-requests;
sandbox allow-same-origin allow-forms
```

This page has a <abbr>CSP</abbr> that differs in four ways:

- It includes a reporting endpoint
- It specifies an `allow-scripts` parameter on its `sandbox` directive
- It allows loading media (necessary for the `<audio>` demonstration near the end)
- It removes `upgrade-insecure-requests`.[^1]

Additionally, I have a 404 page that includes a blank `sandbox` directive (i.e., it has no parameters such as `allow-same-origin`).

Some browser software breaks upon encountering strict <abbr>CSPs</abbr>. It's difficult to pinpoint whether the offending CSP directive is a fetch directive (`default-src`, `script-src`, `style-src`, etc.), or if it's the `sandbox` directive without `allow-scripts`.

Try reproducing the bug on the following pages:

1. [This page, but without a `sandbox` CSP directive](https://seirdy.one/meta/csp-bug-reproduction/?sandbox=off)
2. [This page's canonical location](https://seirdy.one/meta/csp-bug-reproduction/).
3. [My homepage](https://seirdy.one/)
4. [This page, but with an empty `sandbox` directive](https://seirdy.one/meta/csp-bug-reproduction/?sandbox=strict)

Note the following:

- If you can reproduce the bug on all four pages: the offending directives include a fetch directive.

- If you can reproduce the bug on all pages _except_ the third or fourth: the offending directive is probably a `sandbox` directive's `allow-scripts` or `allow-same-origin` parameter, respectively.

- If you can reproduce the bug on the second page but cannot reproduce the bug on the first page, [a different missing `sandbox` parameter](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/sandbox) is probably the culprit.

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

Sample elements
---------------

The following sections contain demos to see what breaks under a restrictive CSP.

### An audio element

I'm adding an `<audio>` element to demonstrate how a `sandbox` directive breaks WebKit's media controls. See [WebKit bug 237281](https://bugs.webkit.org/show_bug.cgi?id=237281) for more information.

{{<transcribed-image id="eloquence" type="audio" itemtype2="AudioObject" itemprop="hasPart">}}

#### <span itemprop="name">Eloquence sample audio</span> {#eloquence-sample}

<figure>
{{<audio name="eloquence">}}
<figcaption itemprop="description">

Just a random audio sample I had lying around. It's a recording of the "Eloquence" speech synthesizer reading text from another page on this site. It has a <span translate="no">Cross-Origin Resource Policy</span> of `same-origin`.

</figcaption>
</figure>

{{<transcribed-image-transcript type="audio">}}

<q>My primary focus is inclusive design. Specifically, I focus on supporting underrepresented ways to read a page. Not all users load a page in a common web-browser and navigate effortlessly with their eyes and hands. Authors often neglect people who read through accessibility tools, tiny viewports, machine translators, “reading mode” implementations, the Tor network, printouts, hostile networks, and uncommon browsers, to name a few. I list more niches in the conclusion. Compatibility with so many niches sounds far more daunting than it really is: if you only selectively override browser defaults and use plain-old, semantic HTML (POSH), you've done half of the work already.</q>

{{</transcribed-image-transcript>}}

{{</transcribed-image>}}

Bugs filed
----------

Let me know if this page helped you discover any new bugs! Here are some bugs that my site has already uncovered:

- [Epiphany: Reader Mode crash](https://gitlab.gnome.org/GNOME/epiphany/-/issues/1698)
- [Various WebKit browser features](https://bugs.webkit.org/show_bug.cgi?id=237281)
- [Brave Speed Reader](https://github.com/brave/brave-browser/issues/24577)
- [Brave element picker](https://github.com/brave/brave-browser/issues/26686)

Bugs I have yet to file:

- Several mobile browsers failing to initialize Reader Mode
- Firefox for iOS failing to perform find-in-page.


[^1]: I removed `upgrade-insecure-requests` so that my Tor onion service could have the same <abbr>CSP</abbr> as this page. The onion service does not support TLS: TLS on onion services is redundant, and no certificate authority offers free <samp>.onion</samp> certificates.



---
title: "Re: debunking myths about HTTPS"
date: 2022-09-19T14:39:08-07:00
replyURI: "https://blog.julien-maury.dev/en/snippets/https-myths/"
replyTitle: "Debunking myths about HTTPS"
replyType: "Article"
replyAuthor: "Julien Maury"
replyAuthorURI: "https://julien-maury.dev/#about"
---
> A "more sophisticated" scenario can consist of manually routing all the victim's traffic to an external server. The attackers can also create fake networks or routers. In other words, it's possible to act as a proxy under certain conditions without any knowledge from the victims who wouldn't change their behavior, as nothing would look wrong.

This attack allows intercepting cleartext communication. However, simply proxying traffic does not allow decryption.

Decryption as you describe requires compromising the host <abbr>OS</abbr>, which would allow an attacker to do anything a user can. A compromised OS has no expectation of security, regardless of which measures you put in place.

A better attack would be to add an additional CA to the OS and browser CA bundles. This would let an attacker add their own TLS certificates to sites without getting rejected by the browser. However, once again, this requires an attacker to compromise the host OS.

The only convincing HTTPS-compromise mentioned is interception of an unencrypted initial connection before it's upgraded to HTTPS; this is a valid concern for sites not on the HSTS-Preload lists or lacking [HTTPS service-binding DNS records](https://datatracker.ietf.org/doc/draft-ietf-dnsop-svcb-https/).

A better argument would be that TLS doesn't normally encrypt Server Name Indication (<abbr>SNI</abbr>) or obfuscate record sizes; <abbr>SNI</abbr>-sniffing or traffic analysis could reveal domain names or pages, respectively.

I'd say that HTTPS combined with random record padding and Encrypted Client Hello (TLS 1.3 extensions) and a form of encrypted DNS (<abbr title="DNS-over-TLS">DoT</abbr>, <abbr title="DNS-over-HTTPS">DoH</abbr>, <abbr title="DNS-over-QUIC">DoQ</abbr>) can offer pretty good privacy protections against a <abbr title="Machine in the Middle">MITM</abbr>: the only reliable information leakage with these measures in place is at the <abbr title="Internet Protocol">IP</abbr> layer. <abbr>IP</abbr> addresses are less specific than hostnames, since one <abbr>IP</abbr> can correspond to multiple hostnames.

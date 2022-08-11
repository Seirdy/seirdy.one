---
title: "Big Tech nameservers"
date: 2022-08-10T21:30:17-07:00
---
Many people are worried about Amazon Web Services and especially Cloudflare centralizing the Web. I generally share their concerns, with one exception.

Hot take: it's fine to use a "Big Tech" provider **as a name server,** provided you can handle the 24-hour delay involved in a migration. Of all things, using a name server doesn't have nearly the same the drawbacks as other types of centralization. It's super easy to migrate, and DNSSEC keep name servers honest. There are more important things to worry about.

I'll switch to Cloudflare *just for DNS,* because it's one of the only providers that supports DNSSEC and the new HTTPS records. The latter will be useful once a web server finally gains Encrypted Client Hello support; I'm watching Nginx, OpenLiteSpeed, H2O, redbean, and Caddy.

---
title: "Unencrypted connections do mean injection"
date: 2024-04-15T10:45:12-04:00
replyURI: "https://lethallava.land/notes/9s4irgazxf"
replyTitle: "wdym [ISPs inject content], any examples?"
replyType: "SocialMediaPosting"
replyAuthor: "dflxh"
replyAuthorURI: "https://lethallava.land/@dflxh"
replyDate: "2024-04-15T08:52:40-04:00"
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AgIhXz3q628odren2G'
    - title: 'IndieNews'
      url: 'https://news.indieweb.org/en'
---
[My previous response to similar concerns]({{<relref "/notes/on-enforcing-https.md">}}) is relevant. To elaborate:

If nothing prevents bad behavior from an ISP, and it has happened before, then you should assume it's happening. This extends to injecting JavaScript apps into insecure connections.

- [Marriott hotels inject scripts via Revenue eXtraction Gateway hardware (2012)](https://justinsomnia.org/2012/04/hotel-wifi-javascript-injection/)
- [Infrastructure likely belonging to the Great Firewall of China tampers with Baidu analytics to DDoS GitHub (2015)](https://www.eff.org/deeplinks/2015/04/china-uses-unencrypted-websites-to-hijack-browsers-in-github-attack)
- [Comcast continues to inject its own code into websites you visit (2017)](https://thenextweb.com/news/comcast-continues-to-inject-its-own-code-into-websites-you-visit)
- [How is my ISP able to inject into this webpage? (2019)](https://security.stackexchange.com/questions/221260/how-is-my-isp-able-to-inject-into-this-webpage)
- [Optimum ISP is MITMing its customers (2023)](https://lukerodgers.ca/2023/12/09/optimum-isp-is-mitming-its-customers/)

Unless you trust every hop from your browser to the destination server (and back), assume anything unencrypted can and will be inspected (and potentially tampered with). Encrypt everything you can.


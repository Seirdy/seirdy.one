---
title: "Choosing an encrypted DNS protocol"
date: 2023-11-18T19:30:46-07:00
---
The three most popular DNS protocols with transit encryption are DNS-over-HTTPS (<abbr>DoH</abbr>), DNS-over-TLS (<abbr>DoT</abbr>), and DNS-over-QUIC (<abbr>DoQ</abbr>). This should help you choose what to use:

1. Do you actually need to override OS DNS support? If not, or if you're unsure, go to 6.
2. Are you ready to implement DNS protocols correctly, or add a dependency that does so? If you're not, go to 5.
3. Does the network filter DNS traffic? If it does, go to 5.
4. Do you already have QUIC support? If not, **use DoT.** If you do, **use DoQ.**
5. Do you have an HTTPS stack? If you do, **use DoH**.
6. Give up and **delegate to the OS**.

Let your HTTPS stack handle HTTP/1.1 vs. HTTP/2 vs. HTTP/3 support; don't treat DNS-over-HTTP/3 as a separate protocol. I don't know enough about DNSCrypt to make an informed recommendation about it, but DoQ and DoH meet my needs well enough.


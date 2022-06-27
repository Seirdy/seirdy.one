---
title: "Mullvad audit"
date: 2022-06-26T22:10:33-07:00
---
[Mullvad's recent audit by Assured AB](https://www.assured.se/publications/Assured_Mullvad_relay_server_audit_report_2022.pdf) was a bit concerning to me. Fail2ban and user-writable scripts running as root is not the sort of thing I'd expect in a service whose *only job* is to provide a secure relay.

Avoiding and guarding root should be Sysadmin 101 material.

I recommend any amateur Linux admins read audit reports like this. While some low-priority recommendations are a but cargo-cultish, most advice is pretty solid. Frankly, much of this is the sort of thing a good admin should catch well *before* a proper audit.

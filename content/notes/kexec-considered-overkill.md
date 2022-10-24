---
title: "Kexec considered overkill"
date: 2022-10-23T22:09:27-07:00
replyURI: "https://community.mojeek.com/t/kexec-boot-a-new-kernel-without-power-cycling/"
replyTitle: "Kexec: Boot a new Kernel without Power Cycling"
replyType: "DiscussionForumPosting"
replyAuthor: "Mike"
replyAuthorURI: "https://community.mojeek.com/u/mike/"
---

Avoid kexec if you don't need it: it opens new vulnerabilities, and is better left disabled for most use-cases. Redundancy and failover should eliminate the need when hosting a typical service. Even without the risks, there are other reasons to reboot: updates to shared libraries, SELinux policies, and init systems often warrant one.

One use-case that benefits from kexec is pubnix systems with many logged-in users. If you need to apply an unscheduled security patch while causing minimal disruption, then live-patching makes sense.

With some boot optimization, I can hit 99.9% uptime even if I reboot 2-3 times per week on Fedora. With failover, these reboots should have negligible impact.

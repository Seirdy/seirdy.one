---
title: "Flatpak and web browsers"
date: 2022-06-12T16:24:49-07:00
replyURI: "https://floss.social/@alcinnz/108466919900074368"
replyTitle: "The outer layer will be via FlatPak"
replyType: "SocialMediaPosting"
replyAuthor: "Adrian Cochrane"
replyAuthorURI: "https://adrian.geek.nz/"
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/objects/9a1fcc96-1fef-4521-83a5-0b267f144c11'
---
You might want to provision namespace-based isolation for your browsers. But that could throw a wrench into Flatpak-based distribution.

When distributing browsers through Flatpak, things get a bit...weird. Nesting sandboxes in Flatpak doesn't really work, since Flatpak forbids access to user namespaces.

For Chromium, they worked around this by patching Chromium zygote process (the process that provisions sandboxes) to call a Flatpak supervisor to create additional sandboxes. This is called the "spawn strategy". Chromium uses a two-layer sandbox: layer-2 is a syscall allow-list and layer-1 is everything else. The only problem is that Flatpak's layer-1 sandboxes are more permissive than Chromium's native layer-1 sandboxes, so the Chromium Flatpak has weaker sandboxing.

Firefox's sandboxing isn't entirely dependent on user namespaces, but it is weakened a bit without them; there's no "spawn strategy" implemented at the moment. More info is [on Bugzilla](https://bugzilla.mozilla.org/show_bug.cgi?id=1756236).

Now, whether this matters is something I can't decide for you. My personal opinion is that Flatpak serves as a tool to package, deliver, and sandbox native applications; Web browsers are tools that deliver and sandbox Web applications. Distributing a browser through Flatpak is like distributing Flatpak itself through Flatpak. Web browsers are an _alternative_ to Flatpak; they have their own sandboxing and updating mechanisms.

<ins datetime="2024-06-18" cite="https://forum.vivaldi.net/topic/33411/flatpak-support/192?lang=en-US">Update <time>2024-06-18</time>: [This is also the reason why the Vivaldi team won't publish a (verified) Flatpak of Vivaldi](https://forum.vivaldi.net/topic/33411/flatpak-support/192?lang=en-US).</ins>

---
title: 'The limited utility of the phrase “GNU/Linux”'
date: 2022-12-09T13:48:49-08:00
description: "“GNU/Linux” distinguishes Linux distributions primarily by the presence of GNU software, which is seldom the most meaningful or practical distinction."
outputs:
    - html
    - gemtext
footnote_heading: Notes
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AQRXP8XlCz5447db4y'
    - title: 'tilde news'
      url: 'https://tilde.news/s/euln3d/limited_utility_phrase_gnu_linux'
    - title: 'jstpst'
      url: 'https://www.jstpst.net/f/articles/7547/the-limited-utility-of-the-phrase-gnu-linux'
    - title: 'Tildes'
      url: 'https://tildes.net/~comp/13nx/the_limited_utility_of_the_phrase_gnu_linux'
---
The standard fossbro interjection goes:

> I'd just like to interject for a moment. What you're referring to as Linux, is in fact, GNU/Linux, or as I've recently taken to calling it, GNU plus Linux. Linux is not an operating system unto itself, but rather another free component of a fully functioning GNU system made useful by the GNU corelibs, shell utilities and vital system components comprising a full OS as defined by POSIX.

Sensible retorts, such as "Nobody asked you", "Please leave us alone", and "Sir, this is a Wendy's" are useless defenses. Nay, the greatest weapon against misguided pedantry is pedantry itself.

Let's talk about why _not_ to use the term "GNU/Linux".

Introduction
------------

"GNU/Linux" is not a useful term to describe a category of operating systems. The phrase distinguishes Linux distributions primarily by the presence of GNU software, which is seldom the most meaningful or practical distinction worth making.

To illustrate the limited utility of "GNU/Linux" we can study seven Linux distributions, some of which are GNU/Linux:


Fedora CoreOS
: A server-oriented distribution intended for containerized workloads. Contains a Linux kernel, GNU libc, GNU coreutils, and the Systemd management suite.

Fedora Workstation
: A distribution of the Linux kernel, GNU libc, GNU coreutils, and the Systemd management suite

Gentoo
: A distribution of the Linux kernel, GNU libc, GNU coreutils, and the OpenRC init system[^1]

Alpine
: A distribution of the Linux kernel, musl libc, Busybox coreutils, and the OpenRC init system

Void Linux, musl edition
: A distribution of the Linux kernel, musl libc, some GNU coreutils, and the Runit init system

ChromeOS
: A distribution of the Linux kernel, GNU libc, and a UNIX-like userland abstracted away by default. This is the most popular desktop GNU/Linux distribution, to my knowledge.

Qubes OS
: A distribution that uses the Linux kernel but is meant to merely host VMs containing their own OSes

The phrase "GNU/Linux" includes all of these distributions except Alpine, and possibly except Void-musl. I argue that drawing this particular line in the sand is hardly ever useful. The right line to draw depends on context.

User experience
---------------

The phrase "GNU/Linux" doesn't meaningfully describe a Linux distribution's user experience.

When someone says they use "Linux on the desktop", I assume they're referring to a category of OSes that includes all the listed Linux distributions except Fedora CoreOS, ChromeOS, and perhaps Qubes OS. One of the included distributions, Alpine, doesn't ship any GNU software by default. Yet it feels closer to Fedora (a GNU/Linux distribution) than ChromeOS or Qubes OS. The latter two aren't used like traditional "\*nix" systems.

"UNIX-Like" or "POSIX" at least convey the UNIX-like experience and ecosystem of an OS. A "Systemd distribution" would also be a useful term to describe the experience of configuring and administrating an OS.

Operating system design
-----------------------

The phrase "GNU/Linux" doesn't meaningfully describe a Linux distribution's high-level design.

GNU coreutils and glibc both have alternatives that should be nearly equivalent. The use of GNU libraries and coreutils typically doesn't change the design an OS nearly as much as the presence of, say, Systemd. In fact, I would categorize software like GNOME or PulseAudio as targeting "Systemd/Linux" rather than GNU/Linux: non-Systemd distributions must patch them to run without Systemd. "Systemd distribution" or "Non-Systemd Linux" are more useful terms.

Distinguishing Fedora and Alpine by the use of Systemd versus OpenRC makes far more sense than distinguishing them by their C libraries.

NixOS and GuixSD feel similar due to their functional package management, not because of their coreutils or C libraries. If NixOS switched to musl and Busybox, I would still feel comfortable putting it in the same category as GuixSD. "Functionally packaged distribution" would be a more useful term to refer to this pair.

Targeting an OS
---------------

The phrase "GNU/Linux" is somewhat meaningful when describing a compilation target; however, "target triplets" are generally more useful.

Ideally, programs should support linking against different libraries conforming to the same standards. A single program should build for either glibc or musl (and either libstdc++ or libc++ when it uses C++). If I make a GTK or Qt program, I can expect it to run on all the listed OSes except ChromeOS. Alpine and Fedora Workstation are part of more-or-less the same ecosystem, and should share a category.

This ideal isn't always our reality. Complex software, such as browsers and Systemd, typically requires significant patching to run with musl. Patching fast-moving and complex software like Firefox or Chromium is difficult; patched versions often lag behind official releases. I find it fair to categorize such software as specifically targeting GNU/Linux.

Categorizing a target as "GNU/Linux" makes sense when running a pre-compiled binary dynamically linked against glibc (and possibly libstdc++). This is especially relevant for proprietary software shipped exclusively in binary form. Proprietary software tends to be above a certain threshold of complexity; otherwise, it'd be trivial to re-implement. Above that complexity threshold, C and C++ libraries probably aren't the only relevant dynamic libraries: the software will likely require system graphics (e.g. libwayland), cryptography (e.g. OpenSSL), and messaging (e.g. libdbus) libraries.

### Target triplets

When specifying a Linux compilation target, we hardly ever see the term "GNU/Linux". Instead, most people use a <dfn>target triplet</dfn> that specifies the target CPU architecture, kernel, and userland. "x86_64-linux-gnu" and "aarch64-linux-musl" are two examples.

Since the Linux kernel has a stable ABI, it's common to ship binaries statically-linked, with no system libc dependencies. In these situations, pre-compiled Linux binaries may simply drop the last part of a target triple; the two examples would become "x86_64-linux" and "aarch64-linux".

Unclear meaning
---------------

The difference between "GNU/Linux" and "Non-GNU/Linux" is unclear; this confusion calls into question the value of the term "GNU/Linux".

GuixSD is an OS developed by the GNU project. It uses the GNU coreutils, GNU libc, GNU Shepherd init system, GNU Guile extension language, and GNU Linux-Libre kernel.[^2] It seems fair to include it in the category of "GNU/Linux" distributions.

In contrast: Void Linux's musl edition uses some GNU coreutils. Its init system (Runit), shell (the Almquist Shell), and libc (musl) are not GNU software. Would it make more sense to refer to this distribution as GNU/Linux or musl/Linux? How useful is the distinction?

"GNU" alone seems to imply both GNU coreutils and glibc; it doesn't seem to account for the presence of GNU coreutils and the absence of glibc, or vice versa.

Conclusion
----------

The phrase "GNU/Linux" includes Fedora Workstation, Fedora CoreOS, Gentoo, ChromeOS, and Qubes OS. It's unclear whether it includes Void's musl edition, and it excludes Alpine Linux.

Running or compiling a dynamically-linked binary is the only situation warranting such a distinction; this is especially important when distributing pre-compiled software. Beyond that scenario, "GNU/Linux" implies little about the desktop user experience, system administration experience, OS design decisions, or even how much GNU software is present on an OS.

I would much rather see adoption of the following phrases:


freedesktop distribution
: Refers to the category of UNIX-like desktop-oriented OSes using the software ecosystem that includes GTK, Qt, the AT-SPI accessibility APIs, and the most important freedesktop.org standards. "freedesktop Linux distribution" could narrow this down to just those with the Linux kernel.

Systemd distribution OR non-Systemd Linux
: Refers to the category of Linux distributions that offer a similar configuration and administration experience

POSIX OR UNIX-like
: Includes most Linux distributions, the BSDs, Solaris, and others to describe common standards between operating systems' low-level design.

I won't insist on this terminology; I have better things to be pedantic about. I merely wrote this article so I could share it whenever [the GNU/Linux naming controversy](https://en.wikipedia.org/wiki/GNU/Linux_naming_controversy) comes up.

If I shared this article with you after you attempted to incorrect someone's terminology, I'd like to leave you with one last copypasta:

{{<quotation id="womansplain">}}

<blockquote itemprop="text">

"I use Linux as my operating system," I state proudly to the unkempt, bearded man. He swivels around in his desk chair with a devilish gleam in his eyes, ready to mansplain with extreme precision. "Actually," he says with a grin, "Linux is just the kernel. You use GNU+Linux." I don't miss a beat and reply with a smirk, "I use Alpine, a distro that doesn't include the GNU coreutils, or any other GNU code. It's Linux, but it's not GNU+Linux."

The smile quickly drops from the man's face. His body begins convulsing and he foams at the mouth as he drop to the floor with a sickly thud. As he writhes around he screams "I-IT WAS COMPILED WITH GCC! THAT MEANS IT'S STILL GNU!" Coolly, I reply: "If Windows was compiled with GCC, would that make it GNU?" I interrupt his response with "And work is being made on the kernel to make it more compiler-agnostic. Even if you were correct, you won't be for long."

With a sickly wheeze, the last of the man's life is ejected from his body. He lies on the floor, cold and limp. I've womansplained him to death.

</blockquote>

{{<quotecaption partOfType="CreativeWork">}}

{{<indieweb-person name="Unknown" itemprop="Author">}}

{{</quotecaption>}}

{{</quotation>}}

If you remain unconvinced: that's okay. In the end, what really matters is that I managed to distract you with an unnecessarily-long article, giving me enough time to wrap up the discussion you interrupted.


[^1]: There exist several overlays and configurations to use Gentoo with musl, Busybox, different init systems, and even Clang. I'm only describing default, mainstream setups.

[^2]: I imagine most deployments of GuixSD swap out the default Linux-libre kernel with a mainline version, but I lack the evidence to back this claim up.



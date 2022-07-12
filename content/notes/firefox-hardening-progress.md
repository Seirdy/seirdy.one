---
title: "Firefox hardening progress"
date: 2022-07-12T09:33:40-07:00
---
In the past couple of years, Firefox made significant security-related progress.

Firefox's multi-process architecture was overhauled, starting with a [utility process overhaul](https://bugzilla.mozilla.org/show_bug.cgi?id=1722051). This has improved privilege separation by moving networking, audio, and other ancillary functions to a separate process. They also enable Arbitrary Code Guard (<abbr title="Arbitrary Code Guard">ACG</abbr>) for the utility process on Windows, and plan to do something similar on macOS. They don't (yet) emulate ACG on Linux.

They've rolled out a separate GPU process on some platforms; the roll-out will likely finish this year.

Regarding toolchain hardening: Chromium official builds use [Clang's CFI sanitizer](https://clang.llvm.org/docs/ControlFlowIntegrity.html); Firefox doesn't. However, a subset of Firefox's libraries support [RLBox sandboxing](https://docs.rlbox.dev/). This isn't a complete solution, but is still a welcome change. [The Tor Browser disables libgraphite on the "safer" security level](https://gitweb.torproject.org/torbutton.git/tree/modules/security-prefs.js?id=c8f7cd3fec5d5845179fcf71ad46888f2d14c8b0) due to security concerns which RLBox may have addressed.

I'm looking forward to seeing [PID namespace isolation](https://bugzilla.mozilla.org/show_bug.cgi?id=1151624) at some point.

Regarding JIT-related exploit mitigations, Firefox is still quite far behind; I recommend Firefox users to disable JIT in `about:config` (see note 25 of <cite>[Best practices for inclusive textual websites]({{<relref "/posts/website-best-practices">}})</cite>). This is partly related to malloc differences: JavaScriptCore has a malloc with a virtual memory cage, and V8 is currently working on one. As long as Firefox users are better served by disabling JIT: I'd like to see ACG enabled in the JIT-less content process (Chromium does this), and emulated on Linux (Edge does this, and [so did Hexavalent](https://github.com/Hexavalent-Browser/Hexavalent-Archive/tree/08d7b2952f87896e0279969041c149c4300a73cf/patches/linux)).


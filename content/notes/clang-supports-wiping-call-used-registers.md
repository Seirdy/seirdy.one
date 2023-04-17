---
title: "Clang supports wiping call-used registers"
date: 2023-04-17T00:01:52-07:00
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AUjf1wCr0xk0yCVpKK'
---
Here's a compiler flag that slipped my notice: [Clear Linux has `-fzero-call-used-regs=used` in its `CFLAGS`](https://github.com/clearlinux/autospec/blob/46c9d3a49c51235efef62280deb9136f2ee9b203/autospec/specfiles.py#L542) for security-sensitive x86_64 packages, wiping call-used registers on return to protect against ROP exploits. In my benchmarks, there was almost no perf difference between `skip`, `used-gpr` and `used` which is surprising; I thought that this would really hurt instruction cache optimization.

Either optimizing compilers have rendered even *more* of my coursework on computer architecture unusable, or there's a reason why this is x86_64-only (I'm only familiar with RISC).

Anyway: Alpine's Clang-16 seems to have finally implemented this GCC-11 feature ([it was supposed to be in Clang-15](https://releases.llvm.org/15.0.0/tools/clang/docs/ReleaseNotes.html#major-new-features)), so I can use it in my build scripts. Now seirdy.one is now served with an Nginx built with `fzero-call-used-regs=used-gpr` (including all linked libraries). Let's see if I notice a difference. If I don't, I'll switch from `used-gpr` to `used` and repeat.

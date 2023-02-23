---
title: "Yuescript first impressions"
date: 2023-02-15T09:35:15-08:00
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/ASi7iC9E0WfUIObg5A'
---
I just discovered [Yuescript](https://yuescript.org/doc/), which is like MoonScript with more features. I have mixed feelings.

I like features like pipelines (much cleaner than repeated assignment or nested parentheses in function calls) and compile-time macros. The sugar for multiple and destructuring assignment is handy.

I find the additional operators unnecessary, and not worth their cognitive overhead. It re-uses some operators for different purposes, creating confusion. The `[]` operator could easily have been a function in a library instead.

One of the trade-offs for this much syntactic sugar is some syntactic ambiguity. An opinionated formatter could resolve some of this.

---
date: "2020-11-17T13:13:03-08:00"
lastmod: "2020-11-19T12:23:18-08:00"
description: A seires on setting up resilient git-based project workflows, free of vendor lock-in.
outputs:
    - html
    - gemtext
tags:
    - git
    - foss
techarticle: true
title: "Resilient Git, Part 0: Introduction"
---

<div itemprop="backstory">

Recently, GitHub re-instated the [youtube-dl git repository](https://github.com/ytdl-org/youtube-dl) after following a takedown request by the RIAA under the DMCA. Shortly after the takedown, many members of the community showed great interest in "decentralizing git" and setting up a more resilient forge. What many of these people fail to understand is that the Git-based project setup is designed to support decentralization by being fully distributed.

Following the drama, I'm putting together a multi-part guide on how to leverage the decentralized, distributed nature of git and its ecosystem. I made every effort to include all parts of a typical project.

</div>

I'll update this post as I add articles to the series. At the moment, I've planned to write the following articles:

1. [Hydra Hosting](/2020/11/18/git-workflow-1.html): repository hosting.

2. Community feedback (issues, support, etc.)

3. Community contributions (patches)

4. CI/CD

5. Distribution

The result of the workflows this series covers will be minimal dependence on outside parties; all members of the community will easily be able to get a copy of the software, its code, development history, issues, and patches offline on their machines with implementation-neutral open standards. Following open standards is the killer feature: nothing in this workflow depends on a specific platform (GitHub, GitLab, Gitea, Bitbucket, Docker, Nix, Jenkins, etc.), almost eliminating your project's "bus factor".

Providing a way to get everything offline, in a format that won't go obsolete if a project dies, is the key to a resilient git workflow.

Before we start: FAQ
--------------------

Q: What level of experience does this series expect?

A: Basic knowledge of git, and a very basic understanding of email. If you have a few repos and can use a third-party email client, you're good.

Q: Do you think you can get hundreds and thousands of people to drop Git{Hub,Lab,tea} and use a different workflow?

A: No, but that would be nice. If only five people who read this series give this workflow a spin and two of them like it and keep using it, I'd be happy.

Q: Is this workflow more difficult than my current one?

A: "Difficult" is subjective. I recommend TRYING this before jumping to conclusions (or worse, sharing those conclusions with others before they have a chance to try it).

Q: I'm not interested in trying anything new, no matter what the benefits are.

A: First of all, that wasn't a question. Second, this series isn't for you. You should not read this. I recommend doing literally anything else.

Next: Resilient Git, Part 1: [Hydra Hosting](/2020/11/18/git-workflow-1.html)


---
title: "Working through forge downtime"
date: 2024-01-13T14:30:07-05:00
---
Sourcehut and Codeberg are experiencing reliability issues due to an ongoing layer-3 DDoS attack.

I managed to continue working on this site uninterrupted:

- I practice [Hydra Hosting]({{<relref "/posts/git-workflow-1">}}) by simultaneously pushing to at least four remotes (`git.sr.ht`, `codeberg.org`, `github.com`, `gitlab.com`, `git.envs.net`, and a private one).

- My CI manifests are thin wrappers around shell scripts, Makefiles, and other portable tooling.

- My CI dependencies are mostly statically-linked binaries in a tarball that I host at multiple locations.

- My CI jobs can all run locally.

- I use email-based contributions: I accept pull-requests on other forges with email notifications, and formatted patches through email.

I don't ever want to be limited by a single provider's uptime if I can help it.


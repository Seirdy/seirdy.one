---
title: "Matrix performance problems"
date: 2022-11-15T12:23:28-08:00
replyURI: "https://fedi.lucdev.net/notice/APdYWfzd59CNH2QCem"
replyTitle: "I cannot seem to join big [Matrix] rooms; it seems the software is not efficient"
replyType: "SocialMediaPosting"
replyAuthor: "Lucie"
replyAuthorURI: "https://lucdev.net"
---
Synapse is incredibly slow, which is why I run the [Conduit matrix server](https://conduit.rs/). Server performance is the main price paid for Matrix' history replication.

This also gives Matrix a spam DDoS problem: sometimes people mass-create accounts on hundreds of servers with open registration, and mass-join rooms. The flood of thousands of join-events will <abbr title="Out Of Memory">OOM</abbr> most connected servers. My Conduit server (RocksDB backend, 1 vCPU, 1GB RAM) is actually fast and light enough to ride some of these out and go back to normal speeds a couple hours after the floods die down.

You generally don't want to join a room like Matrix-HQ unless you have good hardware. A new Postgres backend is coming soon, which should improve the situation.

Once Conduit implements a few missing features (federated backfill, spaces hierarchy and room discovery), and once better spam controls roll out (e.g. automatically restricting joins to under <var>N</var> per second and/or automatically blocking open-registration servers during high join frequencies), I'd say the worst performance problems will be gone.

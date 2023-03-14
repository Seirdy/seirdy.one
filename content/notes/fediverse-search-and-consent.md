---
title: "Fediverse search and consent"
date: 2023-03-14T11:25:34-07:00
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/ATcA5ayAnRUsbCS58y'
---
Indexing Fediverse posts should be "mandatory opt", not opt-in or opt-out. Account creation should offer a few checkboxes: indexing could be done by "your instance", "all federating instances", and "traditional search engine crawlers"; for each of these, users should be able to choose "none", "public posts only", and "all". Alternatively: there should be a "discoverable" post visibility option that opts you into more advanced discovery options like search or appearance in "trending".

An instance indexing its local users is fine if they were told about it before signing up, so they could weigh that into their decision to pick that instance. It still needs to be a user-configurable toggle, since consent should be easily revocable without requiring a full migration.

I think hashtags are intended as a way to opt-into being searched for by specific terms only, so advanced hashtag search (e.g. `hashtag1 AND hashtag2`, `(hashtag1 OR hashtag2) AND NOT hashtag3)` should be fine.

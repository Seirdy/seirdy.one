---
title: "Profile hydration"
date: 2022-10-26T17:31:44-07:00
replyURI: "https://discuss.coding.social/t/idea-fediverse-profile-ui-component-fed-by-keyoxide-back-end-service/144"
replyTitle: "Idea: Fediverse Profile UI component fed by Keyoxide back-end service"
replyType: "DiscussionForumPosting"
replyAuthor: "Arnold Schrijver"
replyAuthorURI: "https://mastodon.social/@humanetech"
---

Many open standards can support profile hydration:

Ariadne
: Map an email identifier to supported verified accounts.

The IndieWeb
: Map a webpage with `h-card` to any account. This can pair with other forms of authentication, such as [RelMeAuth](https://microformats.org/wiki/RelMeAuth).

WebFinger
: Map an email-like identifier (an `acct:` URI) to a list of links.

vCard
: Mpload a vCard containing profile information, possibly with "share contact".

I think `h-card`-based hydration is the best place to start. We can later add support for more options:

- Keyoxide profiles already contain `h-card` microformats, so we get that for free.
- `h-card` microformats can have `u-key` properties, potentially triggering an Ariadne-based verification of accounts enumerated by the `h-card`.
- `h-card` can map to vCard4

Depending on how [keyoxide-web issue 141](https://codeberg.org/keyoxide/keyoxide-web/issues/141) goes, WebFinger could also indirectly give Keyoxide support.

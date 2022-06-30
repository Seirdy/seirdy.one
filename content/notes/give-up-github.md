---
title: "Re: Give up GitHub"
date: 2022-06-30T08:59:50-07:00
replyURI: "https://sfconservancy.org/GiveUpGitHub/"
replyTitle: "Give up GitHub"
replyType: "Article"
replyAuthor: "Software Freedom Conservancy"
replyAuthorURI: "https://sfconservancy.org/"
replyAuthorType: "Organization"
---
I might drop GitHub mirrors for new projects, but I worry that this could disproportionately cause friction among disabled users.

The main reason I currently mirror to GitHub is accessibility. The only other forge I know of that's usable with assistive technologies is Sourcehut, my primary forge. Many feel uncomfortable with Sourcehut's style of contribution and the other FOSS forges are severely lacking, so that leaves GitHub.

GitLab requires JavaScript for basic functionality, which itself is a little problematic from a FOSS perspective and very problematic from a privacy perspective: there's a reason why the Tor Browser disables JavaScript on its "Safest" mode.

> the GitLab Enterprise Edition, which is provided to the public on gitlab.com, is (like GitHub) <mark>trade-secret,</mark> proprietary, vendor-lock-in software

I agree with this statement _except_ for the "trade-secret" choice of words. The "Enterprise Edition" is source-available proprietary software.

Some things I think you should consider adding:

- Notes on CI solutions. While SourceHut and GitLab provide excellent CI, Gitea does not. Codeberg offers CI in the form of Woodpecker CI. I don't know how good Woodpecker is from an accessibility perspective, but Sourcehut's "builds" service is excellent.

- Notes on measures taken by forges to escape vendor lock-in through the network effect (I like to call this ["user domestication"]({{<relref "posts/whatsapp-and-the-domestication-of-users.md">}})). Sourcehut uses mailing lists and does not require making an account.


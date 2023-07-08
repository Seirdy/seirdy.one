---
title: "My Fediverse blocklists"
description: "Documentation on which Fediverse blocklists I offer, how they are made, their differences, their caveats, and their intended use."
date: 2023-05-02T00:00:54-07:00
outputs:
    - html
    - gemtext
syndicatedCopies:
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AVEkLIaUf7JXnJkz2m'
---
I moderate the "pleroma.envs.net" Akkoma instance on the Fediverse, as <a href="https://pleroma.envs.net/users/Seirdy" rel="me">@Seirdy@pleroma.envs.net</a>.

I maintain three blocklists for the Fediverse:


[The `pleroma.envs.net` blocklist](https://seirdy.one/pb/pleroma.envs.net.csv)
: A large list of instances that I find worth suspending. After the first couple hundred entries (imported and then reviewed), I started collecting receipts. Since early 2023, every entry has documented reasons and receipts. I share these with multiple people in a collaborative document, but I don't share it publicly due to risk of harassment. Unlike the other two lists on this page, it wasn't made for general use (though you're welcome to use it as reference).

[`tier0.csv`](https://seirdy.one/pb/tier0.csv)
: A much smaller semi-curated subset of `pleroma.envs.net` suitable for the majority of instances wishing to uphold the Mastodon Covenant's moderation standards. I hope to make it a good starting point for your instance's blocklist, with wiggle room for your own adjustments. Regularly importing `tier0.csv` won't account for retractions; [a sibling blocklist for tier-0 retractions](https://seirdy.one/pb/tier0-retractions.csv) exists for [FediBlockHole](https://github.com/eigenmagic/fediblockhole) users. Note that this list is larger than the bare-minimum I recommend; that'd be FediNuke.

[`FediNuke.txt`](https://seirdy.one/pb/FediNuke.txt)
: A curated subset of `tier0.csv`, containing what I deem the "worse half" of it. This contains instances I really do recommend most people block, or at least avoid. I try to make it a suitable candidate for a "default blocklist", and use it as reference when I evaluate the quality of other blocklists.

  This list is not comprehensive; to keep this list small, I excluded many really bad instances. I take into account not just severity, but also notoriety and liklihood of reaching/harming people on other instances (e.g. spewing toxicity in others' mentions, running blockbots, etc). Bad instances that mostly keep to themselves are less likely to cause problems for a new admin, and therefore less likely to get included in this minimal list.

  Criteria are not set in stone. Instances well-known for causing significant problems for many other instances, particularly for instances run by and for marginalized groups, may be added.

Some of these lists are also sources for the Oliphant blocklists. {{<mention-work itemtype="BlogPosting">}}{{<indieweb-person name="Oliphant" url="https://oliphant.social/@Oliphant" itemprop="author">}} describes them in his article {{<cited-work name="The Blocklist Algorithm" extraName="headline" url="https://writer.oliphant.social/oliphant/the-blocklist-algorithm">}}.{{</mention-work>}}

This post is an attempt to document how they are made, their differences, their intended use, and especially their caveats.

{{<toc>}}

How Tier-0 and FediNuke work
----------------------------

[My tier-0 list](https://seirdy.one/pb/tier0.csv) (mirrored to `tier0.csv` in [the Oliphant repository](https://codeberg.org/oliphant/blocklists)) is a subset of the `pleroma.envs.net` blocklist. It contains entries that appeared on at least **11 out of 20** other hand-picked instance blocklists ("bias sources"), with exceptions detailed below. Not all Tier-0 entries have the same level of severity; a smaller list containing what I personally deem the "worse half" of Tier 0 is [FediNuke.txt](https://seirdy.one/pb/FediNuke.txt). **Consensus** builds Tier-0; **severity** builds FediNuke.

When I add a bias source, I may also increase the minimum number of votes required if I find that its blocklist is too close to (or mainly just imports all of) tier-0 or the blocklist of a bias source's blocklist. That's the reason why the threshold is 11 instead of 10.

### Overrides

There were some block-overrides for instances with fewer than 11 votes. Here's how I went about overriding:

- If an instance has **10 votes,** I may elect to add it after additional review instead of waiting for it to hit 11 votes. It still has 50% consensus at that point.
- If an instance is run by **the same staff as another Tier-0 instance** and has **at least 5 votes,** I may add it after asking other admins about it and getting multiple thumbs-up from admins who import tier-0.
- If an instance contains **blatant/unapologetic bigotry** (something really undeniable, like Nazi imagery or excessive use of slurs in violent/hateful/definitely-not-reclaimed contexts) with staff approval or involvement, I may add it to both tier-0 and `FediNuke.txt` after I get multiple thumbs-up.
- If an instance becomes **risky even to many tier-0 instances** (untagged gore, dox attempts, significant cybersecurity risk, <abbr title="child sexual exploitation material">CSEM</abbr>, etc. with staff approval or involvement): I may add it to both right away, skipping any process.

Under ten controversial entries were excluded despite having more than enough votes. Typically, these were instances that didn't pose a major safety risk, but did fail many admins' "vibe check" or exhibit major governance issues.

### Bias sources

Criteria for a bias source:

1. Has a public blocklist I can easily download.
2. Practices timely and proactive moderation: doesn't just wait for another instance start interacting and cause trouble, and updates more often than once a month. Evaluating this takes time.
3. Blocks at least half of `FediNuke.txt`.

The final `tier0.csv` isn't a pure representation of agreement between instances; it contains overrides and is merely a subset of the `pleroma.envs.net` blocklist. Other lists only serve to determine the bias used for filtering the `pleroma.envs.net` blocklist. The `pleroma.envs.net` blocklist is technically the only "real source". Other bias sources shouldn't be held responsible for the final `tier0.csv` contents. I'll explain my motivation for doing this in the next section.

Since accountability for `tier0.csv` rests on me rather than on other instances, I don't publish the current bias sources. Blame for any problems in `tier0.csv` should rest with me, not them.

### Motivation for including personal bias

If `tier0.csv` were merely an unbiased list of the most widely blocked instances, then being on the list would become a self-fulfilling point of no return. If an instance gets blocked by enough other instances, then it shows up on my lists. If an instance shows up on my lists, it will get blocked by other instances which import my lists. If more instances block it...you get the picture. This leaves little room for retractions and mistakes. By making all my blocklists a subset of the `pleroma.envs.net` blocklist, I ensure only one party needs to be convinced to remove an entry.

Some instances migrate their domains. If the old instance was already deemed worthy of a suspension and the new instance maintains the same staff with no visible attempt to change its reputation, then I deem the new location to be as block-worthy as the old location and make an override. It's the same bad actors under a different banner.

Intended use
------------

The original goal was to make a blocklist appealing to instances with a more laid-back moderation approach, so that they would actually implement a decent blocklist and limit the reach of the worst actors. Unfortunately, the final `tier0.csv` blocklist is 350+ entries; this is still a bit much for the moderate instances.

I pared that down to `FediNuke.txt`, which contains instances that were both really bad _and_ well-known. It's kind of hard to overlook how shitty each instance on the `FediNuke.txt` subset is. Common themes tend to be repeated unwelcome sui-bait from instance staff against individuals, creating or spreading dox materials against other users,[^1] unapologetic bigotry, uncensored shock content, and a complete lack of moderation.

I think if you're starting a well-moderated instance, Tier 0 is a decent place to start (that's why it's in the standard CSV format). You should add and remove entries as you see fit. If you're making a client and want to give it a built-in blocklist, or are looking for a good "default" blocklist: FediNuke is a good option.

### Rationale for creating two subsets

I used to just make a Tier-0 list. Later, I added the FediNuke list. Some people have asked why I don't just use one or the other; if Tier-0 was big enough to warrant FediNuke, why publish Tier-0 at all?

I have two reasons for maintaining two blocklists:

1. I didn't feel comfortable placing some Tier-0 instances right next to, e.g., openly Nazi instances when they weren't at the same level of severity. FediNuke's existence establishes that some instances on the list are much worse than others. Maintaining multiple blocklists makes their subjectivity more obvious.

2. The lists can work together. As I previously mentioned, the division makes it easier for people to feel comfortable importing blocks. Some admins have found that importing FediNuke and gradually combing through the rest of Tier-0 is more approachable than an "all or nothing" approach.

### Use FediBlockHole

The CSV format I use is the format used by [FediBlockHole](https://github.com/eigenmagic/fediblockhole). I do this for two reasons:

1. FediBlockHole supports retractions: admins can configure a merge strategy to support downgrading an entry's severity, with the lowest severity (`noop`) being equivalent to a removal with an optional reason.

2. [Oliphant's blocklists](https://writer.oliphant.social/oliphant/the-blocklist-algorithm) use my blocklists as sources, and are powered by FediBlockHole.

If FediBlockHole supports your Fediverse server (it currently only supports the Mastodon admin APIs), I recommend using that if you want retractions to work.

### Trust, but verify

I totally get resistance to blindly importing blocklists; I don't actually feel comfortable going the "import and forget" route myself! The first couple hundred entries of the `pleroma.envs.net` blocklist started with a few imports, but all domains have since been manually reviewed. For admins who don't feel comfortable "outsourcing" their moderation to blocklist authors: I generally see pre-made blocklists as a _starting point._

Importing `FediNuke.txt` and then individually importing `tier0.csv` entries after manual review is a decent way to balance two conflicting needs:

1. The need to verify suspensions.
2. Not having the time/spoons to verify all the entries.

Another option is to use some text-processing tools to find entries that are common between Tier-0 and another trusted instance's blocklist. You can import the overlap.

Finally, you could just do something else entirely. I never use "your blocklist is different from mine" as a block-reason; even "totally open federation" is never the sole reason for `pleroma.envs.net` suspending an instance. Suspending instances for not using my own blocklist feels wrong.

Before you decide to trust one of my lists, please read the "Mistakes made" section.

Mistakes made
-------------

Here, I publicly document all significant mistakes I've made in the process. I sort entries in descending order by date addressed.

One mistake hasn't yet been listed; I'll wait for approval from one of the people impacted.

### Early April 2023: Oliphant's max list containing bad entries

I made a mistake that didn't have a negative impact on my lists, but did impact someone else's. Even if my own lists came out okay, the fact that I allowed this to happen should be enough reason for you to seriously question my judgement.

I work with {{<indieweb-person name="Oliphant" url="https://oliphant.social/@Oliphant" itemprop="mentions">}} when generating lists; we share ideas regularly. Oliphant offers [his own respository of blocklists](https://codeberg.org/oliphant/blocklists) ([GitHub mirror](https://github.com/sgrigson/oliphant)). Using an approach inspired by my `tier0.csv` generation process, he makes lists generated from consensus across other lists. Unlike `tier0.csv`, the generated lists don't have significant manual curation. Oliphant's tier-1, tier-2, and tier-3 blocklists require decreasing levels of consensus. Until recently, he also offered a "unified max" blocklist containing ~~any entry common across at least two other blocklists~~ <ins datetime="2023-05-02T08:38:00-07:00">every entry from any trusted source</ins>.

One of Oliphant's sources was a single-user instance with many blocks made for personal reasons: the admin was uncomfortable with topics related to sex and romance. Blocking for personal reasons on a personal instance is totally fine, but those blocks shouldn't make their way onto a list intended for others to use. The admin of this instance gave permission to use this blocklist. However, **they did warn us of this fact.** With my own encouragement, **we decided to use their list anyway.**

I had reason to be comfortable with the personal nature of this blocklist. This was was **one out of 20** bias sources used for `tier0.csv` generation, and `tier0.csv` is merely a subset of the `pleroma.envs.net` blocklist. These two facts prevented someone else's one-off "personal" blocks from making its way onto my list. I also found that adding this trusted source only introduced a dozen generally uncontroversial entries to `tier0.csv`.

Unfortunately, the situation was different for Oliphant's unified-max blocklist. Several entries made that list for personal reasons. I focused too much on my `tier0.csv` and failed to notice that anything was off with Oliphant's lists, even though I bore much responsibility for this blunder.

{{<indieweb-person name="Tyr" url="https://pettingzoo.co/@tyr" itemprop="mentions">}} from pettingzoo.co [raised important issues in a thread](https://pettingzoo.co/@tyr/110289010380366104) after noticing his instance's inclusion in the unified-max blocklist. He pointed out that offering a unified-max list containing these blocks is a form of homophobia: it risks hurting sex-positive queer spaces. Simply claiming that the unified-max list isn't intended to be imported isn't enough; there's a real risk that future admins may import it without reading the documentation. I recommend giving the thread a read.

Oliphant has been getting understandable push-back for this issue in his blocklists, but it's not fair for all of the criticism to be directed at him and none at me. Many small mistakes from multiple people, including me, cascaded into one big failure.

Since then, Oliphant has removed that admin's list (and his own) from his blocklists' trusted sources. I removed the same ones. Oliphant also stopped generating the unified-max blocklist, as the potential for misuse was too great.

Future
------

The biggest complaint I've heard is the lack of reasons and receipts. {{<mention-work itemtype="WebSite">}}{{<indieweb-person name="Are0h" url="https://roiskinda.cool/" itemprop="author">}} is working on a separate project called {{<cited-work name="The Bad Space" url="https://thebad.space/">}}{{</mention-work>}} to create an index of instances with receipts. It doesn't have a lot of content yet, but that will change with time. I've shared my receipt archive with him.

I like the idea of a separation between receipt-tracking projects and blocklist-generating projects. Reasons in a blocklist tend to invite retaliatory harassment in an effort to make admins hide their blocklists, often in the form of (very dubious) legal threats (defamation and privacy regulations have come up).

I also hope to see more tier-0 lists crop up. Any instance should be able to make a tier-0 list by sub-setting its own blocklist. When that happens, "Seirdy's Tier-0 list" will hopefully lose whatever authority it has.

My greatest priority right now is improving retractions. Getting off of a list needs to be made much easier.


[^1]: I did not consider dox attempts against certain neo-Nazis a reason to block.



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

I maintain three main blocklists for the Fediverse:


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

## How Tier-0 and FediNuke work

[My tier-0 list](https://seirdy.one/pb/tier0.csv) (mirrored to `tier0.csv` in [the Oliphant repository](https://codeberg.org/oliphant/blocklists)) is a subset of the `pleroma.envs.net` blocklist. It contains entries that appeared on at least **11 out of 20** other hand-picked instance blocklists ("bias sources"), with exceptions detailed below. Not all Tier-0 entries have the same level of severity; a smaller list containing what I personally deem the "worse half" of Tier 0 is [FediNuke.txt](https://seirdy.one/pb/FediNuke.txt). **Consensus** builds Tier-0; **severity** builds FediNuke.

When I add a bias source, I may also increase the minimum number of votes required if I find that its blocklist is too close to (or mainly just imports all of) tier-0 or the blocklist of a bias source's blocklist. That's the reason why the threshold is 11 instead of 10.

### Overrides

There were some block-overrides for instances with fewer than 11 votes. Here's how I went about overriding:

- If an instance has **10 votes,** I may elect to add it after additional review instead of waiting for it to hit 11 votes. It still has 50% consensus at that point.
- If an instance is run by **the same staff as another Tier-0 instance** and has **at least 5 votes,** I may add it after asking other admins about it and getting multiple thumbs-up from admins who import tier-0.
- If an instance contains **blatant/unapologetic bigotry** (something really undeniable, like Nazi imagery or excessive use of slurs in violent/hateful/definitely-not-reclaimed contexts) with staff approval or involvement, I may add it to both tier-0 and `FediNuke.txt` after I get multiple thumbs-up.
- If an instance becomes **risky even to many tier-0 instances** (untagged gore, dox attempts, significant cybersecurity risk, <abbr title="child sexual exploitation material">CSEM</abbr>, etc. with staff approval or involvement): I may add it to both right away, skipping any process.

Under ten controversial entries were excluded despite having more than enough votes, after consulting with other admins. Typically, these were instances that didn't pose a major safety risk, but did fail many admins' "vibe check" or exhibit major governance issues.

I also excluded Twitter mirrors such as BirdSiteLive and bird.makeup; [I maintain a supplementary list for those](#supplementary-blocklists).

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

### Retractions

A separate list exists for retractions from my tier0.csv list. I don't add entries to my retractions list when I remove dead instances, or when an admin on a removed instance prefers not to be included in it (some wish to remain less prominent).

## Intended use

The original goal was to make a blocklist appealing to instances with a more laid-back moderation approach, so that they would actually implement a decent blocklist and limit the reach of the worst actors. Unfortunately, the final `tier0.csv` blocklist is 350+ entries; this is still a bit much for the moderate instances.

I pared that down to `FediNuke.txt`, which contains instances that were both really bad _and_ well-known. It's kind of hard to overlook how shitty each instance on the `FediNuke.txt` subset is. Common themes tend to be repeated unwelcome sui-bait from instance staff against individuals, creating or spreading dox materials against other users,[^1] unapologetic bigotry, uncensored shock content, and a complete lack of moderation.

I think if you're starting a well-moderated instance, Tier 0 is a decent place to start (that's why it's in the standard CSV format). You should add and remove entries as you see fit. If you're making a client and want to give it a built-in blocklist, or are looking for a good "default" blocklist: FediNuke is a good option.

However: if your instance grows larger (or if you intend to grow): you should be intentional about your moderation decisions, present and past. Your members ostensibly trust you, but not me. See [the "trust but verify" section](#trust-but-verify) for for more information.

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

## Mistakes made

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

## Supplementary blocklists

Some supplementary blocklists I maintain with very different criteria:


[BirdSiteLive and bird.makeup](https://seirdy.one/pb/bsl.txt)
: These are services that allow Fediverse users to follow any Twitter user. Now that far-right figures are back on Twitter, these instance pose a problem. Admins wishing to ban a single Twitter user will need to ban that user across over 100 different Twitter mirrors. Moreover, any interactions with bridged accounts are unseen by the account holder on Twitter. Twitter users may not have consented to such mirroring. Admins wishing to simply ban mass-Twitter-mirroring can import this list.

[Corporate social media with user-hostile dark patterns](https://seirdy.one/pb/corpo.txt)
: A short list containing instances run by social media companies that have displayed user-hostile behavior, for anybody who doesn't wish to support such practices. Privacy abuse, growth-mindsets, dark patterns, and a history of vendor lock-in are common (but not all universal) themes.

## Receipts

The following are receipts for instances on my blocklists, in no particular order. Read the text surrounding a link before navigating to it, and let that context serve as a content-warning. No links point directly to the source; all go to a third-party archiving service.

<details><summary>Toggle receipts</summary>

### FediNuke entries

**This section is a work-in-progress,** and it will grow with time. I'll add entries in alphabetical order unless someone requests that I skip ahead to one.

{{< nofollow >}}


13bells.com
: Admin posts [Sandy Hook school shooting conspiracy theories](https://archive.ph/dT9Am), [transphobia](https://archive.ph/Km8Ju).

1611.social
: [antisemitism from admin](https://web.archive.org/web/20230628203218/https://1611.social/@tyler/posts/AX9r68rwjhEQzMKJbU), [anti-vax from admin](https://archive.li/qFhQQ) with other local members, [antisemitic caricature from admin](https://archive.ph/3wIRL).

4aem.com
: Freeze peach PeerTube instance on the "tube" subdomain, hosting blatant antisemitic content. ["Clown World" dogwhistles](https://archive.ph/80Zwu), antisemitic ["Why Kanye West is right"](https://archive.ph/06UiV).

adachi.party
: The instance in question is on the "pleroma" subdomain. Its "about" page has the "Kill, behead, roundhouse kick" copypasta with racial slurs. [Archived "about" page](https://archive.ph/muPe1). Later updated rules to include ["must advocate for racism/fascism/nazism"](https://archive.ph/6Tpq5). [Admin posts racist transphobia](https://web.archive.org/web/20230730175847/https://pleroma.adachi.party/notice/AYAMup3aR6WhWwuHXU).

annihilation.social OR dembased.xyz
: [#FediBlock on 2023-02-24](https://pleroma.envs.net/notice/ASzpsfBstyxOmEtvEG)
: Hosts a blockbot user, [with the handle "blockbot"](https://archive.ph/BAid6), and [a defederation-notification bot](https://archive.ph/VFO2x). [Racism from admin](https://web.archive.org/web/20230729234055/https://annihilation.social/notice/ASwz1H2DlWPaIkUWki). dembased.xyz used to run the predecessor of annihilation.social. A few times since, a small experimental instance has been set up on a subdomain. Both are owned by the same person.

anon-kenkai.net
: [Blatant antisemitic caricature on the landing page](https://web.archive.org/web/20230729235305/https://peertube.anon-kenkai.com/) of its "peertube" subdomain. Admin on the "mitra" subdomain posts [anti-pride messages](https://archive.ph/9p5nw).

asbestos.cafe
: [Racism and ableism from admin](https://archive.ph/d7cfQ). [Admin sharing a dox](https://archive.ph/LUA10), [transmedical gatekeeping from a cis user](https://web.archive.org/web/20230731041522/https://the.asbestos.cafe/notice/AYCymnXAtifMLgNzJg).

bae.st
: [Admin profile page has an "n-word pass"](https://web.archive.org/web/20230730000208/https://bae.st/sjw). Runs a host of bots posting lewd artwork, some of which venture into lolicon and Black-fetishism territory (e.g. "NessaBot"). Runs "glow_in_the_dark_cia_agent", one of the biggest followbots on Fedi. Instance rejects deletes.

banepo.st
: [Runs a blockbot](https://archive.ph/2c9Js). Admin posts [antisemitism, homophobia, and transphobia in one post](https://web.archive.org/web/20230730035807/https://www.banepo.st/notice/AXRzgFfrwY1BRaa9SK), [another with more of the same](https://archive.ph/JxXRv), [all of that with a side of ableism](https://web.archive.org/web/20230730040446/https://www.banepo.st/notice/AXql6rXn1tybo4umiO).

baraag.net
: Very well-known lolicon-friendly instance that does a poor job of moderating grooming and CSAM.

bassam.social
: [The admin equates people being against anti-queer discrimination with "oppression"](https://archive.ph/r1tDT). After a user [made a FediBlock post against bassam.social](https://mstdn.social/users/MagicLike/statuses/110430832688299722), its instance admin [doubled down on permitting bigotry](https://archive.ph/PQ7j0).

beefyboys.win
: [Runs a blockbot](https://web.archive.org/web/20230730042513/https://beefyboys.win/@maldalerts). Staff member "Prude" has a profile with [a racist rant pinned](https://web.archive.org/web/20230730043518/https://beefyboys.win/notice/AJfdGhgoE5K3CUV53A). Staff member "Tyler" posts ["racism is cool and natural"](https://archive.ph/6qDCI) followed immediately by racial slurs, and [other slurs in a non-reclaimed context](https://archive.ph/jGvHn).

boymoder.biz
: Admin accounts post [anti-Indian racism](https://web.archive.org/web/20230730193948/https://boymoder.biz/notice/AWG1sVpdFr5edzwwUq), [racist copypasta](https://web.archive.org/web/20230730194158/https://boymoder.biz/notice/AWEzwl3QDV8xYxBjpQ). Staff includes "meso" from the.asbestos.cafe. [Incompatible moderation standards](https://web.archive.org/web/20230619154748/https://boymoder.biz/notice/AWpLw39olFJZ3Y9kIq).

brainsoap.net
: [dismissive over white supremacy](https://archive.ph/a6bUB), [Nazi humor](https://archive.ph/qDoKt)

breastmilk.club
: Admin "leyonhjelm" posts [transphobic sui-bait](https://web.archive.org/web/20230730195610/https://breastmilk.club/notice/AX6eLMJ8QENou2HhmS), [spamming the "mutualaid" guppe group with blatant queerphobia](https://web.archive.org/web/20230730195759/https://breastmilk.club/notice/AWy4STyPAWSj5e0SYq).

brighteon.social
: [Brighteon's "about" page](https://web.archive.org/web/20230724044425/https://brighteon.social/about/more) marks the instance as a far-right cesspit. Instance is connected to [the Brighteon network](https://web.archive.org/web/20230729030855/https://www.brighteon.com/), a far-right network featuring shows such as "The Reality Camp" with Stacey Campfield.

cawfee.club
: [Racism from multiple users, including admin](https://web.archive.org/web/20230730210913/https://cawfee.club/notice/AY5J5qUA898oge9pa4). [Anti-Romani and racist posts from admin](https://web.archive.org/web/20230730211327/https://cawfee.club/notice/AXjafVFrE4C3c48Mm8). Users [engaging in more racism](https://web.archive.org/web/20230730211531/https://cawfee.club/notice/AY1UovIIgAoO6DfDX6). [Anti-vax from admin](https://web.archive.org/web/20230730211009/https://cawfee.club/notice/AXoyiP9rictCGP2zrs).

clew.lol
: [Racist meme from admin](https://web.archive.org/web/20230730212140/https://clew.lol/@Tony/posts/ATlNGVY9vg0FLp8WlE), [another racist meme](https://web.archive.org/web/20230730212307/https://clew.lol/@Tony/posts/ATlKwuT1NWt0vjGDCq). [Racial slurs in bio of a user with a white-nationalist dog whistle in their handle](https://web.archive.org/web/20230730212536/https://clew.lol/@hh1488) who [posts NJP propaganda](https://web.archive.org/web/20230730212719/https://clew.lol/@hh1488/posts/ATxalxgkzTwstq0QNc).

clubcyberia.co
: Instance [features anti-black emotes](https://web.archive.org/web/20230730220345/https://clubcyberia.co/notice/AY9kBc1YiuBfP9TVgG). Users such as "Inginsub" often [post blatant racism](https://web.archive.org/web/20230730221532/https://clubcyberia.co/notice/AXSJ3fIo5mMORrLYPY). Hosts [a KiwiFarms staff member](https://web.archive.org/web/20230730222042/https://clubcyberia.co/users/crunklord420).

crucible.world
: Admin participating in [extremely transphobic harassment](https://web.archive.org/web/20230730231641/https://ryona.agency/notice/AY8AHumTq4cb2lik76), [more transphobia from admin](https://web.archive.org/web/20230730232208/https://crucible.world/notice/AYES99sUhEtMulC7M0), [even more transphobia](https://archive.ph/WVFrK).

cum.camp OR cum.salon
: Instance has MRF policies to reject deletes and run a blockbot [on cum.camp](https://web.archive.org/web/20230730232539/https://cum.camp/about) and [on cum.salon](https://web.archive.org/web/20221228172530/https://cum.salon/about). Staff members "pernia" and "nimt" are known for [overly-creepy posts related to sexual assault, esp. CSA](https://web.archive.org/web/20230730234254/https://boymoder.biz/notice/AXyuRlHglkmt1AHPn6), [another](https://web.archive.org/web/20230730233035/https://marsey.moe/@pernia@cum.salon/posts/AY8crsXbKZHmCIApgu).

decayable.ink
: Instance is well-known for harassment campaigns. [Targeted transphobic harassment](https://archive.ph/KfDpN). [Racist admin](https://archive.ph/5XvUx). [introductory post](https://decayable.ink/@Decayable/posts/ATYE6r7bOp2bhCRfdY) is chock-full of red flags.

freespeechextremist.com
: [End of this thread](https://web.archive.org/web/20230628203218/https://1611.social/@StarProphet@freespeechextremist.com/posts/AXA3GP4cXfijajukpU) has blatant antisemitism. MRF policies include a [block-notification bot](https://web.archive.org/web/20230731164723/https://freespeechextremist.com/about). The linked page also makes it clear that this is a freeze-peach instance.

glee.li
: [Racist harassment of Mutual Aid posts](https://archive.ph/Vz1Yv). More [blatant racism and transmisia](https://archive.ph/SI0xG). Instance is associated with [the website https://getgle.org](https://web.archive.org/web/20230731045659/https://getgle.org/dark-mode.html). Split off of asbestos.cafe in early 2023, formerly at a subdomain of getgle.org.

h5q.net
: Contains untagged AI-generated photorealistic erotic content that may pose a legal risk in several jurisdictions.

iddqd.social
: Admin posts [anti-Black caricatures](https://archive.ph/1dIUL), supports [organized predatory retaliation against DEI efforts](https://archive.ph/PfHYX). [Instance landing page](https://archive.ph/0JlGl) markets itself as an instance for 4chan users.

kawa-kun.net
: Instance [rejects deletes](https://web.archive.org/web/20230731050219/https://bbs.kawa-kun.com/about). (unfinished entry)

kitsunemimi.club
: [Admin "bronze" participates in racist harassment](https://web.archive.org/web/20230731183425/https://needs.vodka/notice/AYFCFHRqKX6RjsF7Fw), sends users [transphobic shock content](https://web.archive.org/web/20230731184313/https://pl.kitsunemimi.club/notice/AYG5j6YeP0wZI1jaPw). Runs the [HighRoller MRF policy](https://web.archive.org/web/20230731183641/https://pl.kitsunemimi.club/about) for a block-notification bot.

leafposter.club
: [Blatant antisemitism and queerphobia](https://web.archive.org/web/20230731051338/https://cawfee.club/notice/AVS1llk6NOrAVPAB60), [SWERF](https://web.archive.org/web/20230731050932/https://leafposter.club/@Upsman/posts/AVS1ImJqDW5yEPcgwi), [blatant racist use of slurs](https://web.archive.org/web/20230731051017/https://leafposter.club/@Leaflord/posts/AVS04CFlPbegMpCOP2).

marsey.moe
: boks.moe had [the occasional holocaust denial meme](https://archive.ph/ozeh1). one of the main users "Ruusu" set their display name to [a racial slur in a violent context](https://archive.ph/ANM7B). Staff member "MischievousuTomatosu" posts [blatantly racist takes on border control](https://archive.ph/WP9mb). [boks.moe moved to marsey.moe](https://web.archive.org/web/20230730191654/https://shitposter.club/notice/AX3ZOWyu6dX384tV32), which features a [hitler-themed racist "Witster_" account](https://archive.ph/2dTWR), [making fun of mutual aid posts](https://archive.ph/Uri4S)

needs.vodka
: Admin [posts ethno-fascist harassment](https://web.archive.org/web/20230731171924/https://needs.vodka/notice/AYEXL71RuRXt1MYkSG), [antisemitism](https://web.archive.org/web/20230731172003/https://needs.vodka/notice/AYE2Y0GlEONjGKO8dk). Supports [racist, misogynistic, violent grooming](https://web.archive.org/web/20230731172555/https://needs.vodka/notice/AYAgwij0ohSdci6UjI).

nicecrew.digital
: [Blatant anti-Black racism from staff](https://web.archive.org/web/20230731154105/https://nicecrew.digital/notice/AT5UuihBpC4ZI8xIlk), [anti-Black racist caricature from staff](https://web.archive.org/web/20230731153949/https://nicecrew.digital/notice/AYCsMzQsKax7qc0b1E). [Antisemitic COVIDspiracy from staff](https://web.archive.org/web/20230731160204/https://nicecrew.digital/notice/AY4YmRWar1CMk4usOO).

noagendasocial.com
: far-right instance connected to the No Agenda show. [Queerphobia](https://archive.ph/Km8Ju). One of its more popular users is [openly an ethno-nationalist](https://web.archive.org/web/20230731165314/https://noagendasocial.com/@amerika) with [thinly-veiled genocidal views](https://web.archive.org/web/20230731165038/https://noagendasocial.com/@amerika/110652580178110907) and runs the far-right amerika.org blog. An even more popular user [regularly posts far-right content](https://web.archive.org/web/20230731165844/https://noagendasocial.com/@furgar/110558690945902519).

noagendasocial.nl OR noagendatube.com
: Sibling instances of noagendasocial.com, also connected to the No Agenda Show.

poa.st
: Well-known Nazi instance. See receipts for needs.vodka, kitsunemimi.club, and shitpost.cloud for poast users.

poster.place
: Staff member "spitfire" [spams the "mutualaid" guppe group and hashtag with extreme queerphobia](https://web.archive.org/web/20230730195759/https://breastmilk.club/notice/AWy4STyPAWSj5e0SYq).

shitpost.cloud
: Admin "Hoss" [uses racial slurs in an unreclaimed context](https://web.archive.org/web/20230730000845/https://shitpost.cloud/notice/AXuj12Qs30YmatTqbo), and [publicized reports](https://web.archive.org/web/20230731062033/https://shitpost.cloud/notice/AYA2Obde8BUywbo45w) against local users participating in a targeted transphobic harassment campaign. [A user with a violent racist display name](https://archive.ph/5Vb2Q), with staff participating later in the thread.

usualsuspects.lol
: Admin led [targeted transphobic bodyshaming harassment](https://ghostarchive.org/archive/jjfV9) against members of a mainly-trans instance. Originally created to be a [block-bait Soapbox instance](https://web.archive.org/web/20230705053714/https://the.usualsuspects.lol/notice/AXKIqzKiWFFDNryNM0).

varishangout.net
: Instance permits lolicon/shotacon. [sample non-graphic thread containing queerphobia, esp. transphobia, with staff involvement](https://web.archive.org/web/20230729223647/https://varishangout.net/notice/AYBv4A9bwrZXfu0Hho), [another such thread](https://web.archive.org/web/20230729225002/https://varishangout.net/notice/AYBmTghTBGJaGbw9zM). [Staff member being openly transphobic](https://web.archive.org/web/20230729234932/https://varishangout.net/notice/AYAXPrAAe2y35X7JFQ). [Several members participating in transphobic harassment](https://web.archive.org/web/20230730232126/https://varishangout.net/notice/AY7wuahlngicOwhlxo).

wolfgirl.bar
: Admin [participates in racist harassment](https://web.archive.org/web/20230731171233/https://needs.vodka/notice/AYFBR71kngKIwM7Moa), posting [openly Nazi bigoted slur-filled content](https://web.archive.org/web/20230731170555/https://wolfgirl.bar/notice/AUj1Rrjrtm87kjCF9c). [Sends Nazi imagery with racial slurs to Jewish users](https://archive.ph/YaGJ7).

{{</ nofollow >}}

### Tier-0 entries, excluding FediNuke

This section has barely been started.

{{< nofollow >}}


berserker.town
: [Refuses to moderate hate speech](https://web.archive.org/web/20230730180929/https://berserker.town/@mayonesa/107949925239774313) (the post in question has received reports, but [the admin tends to dig his heels in](https://web.archive.org/web/20230730185902/https://berserker.town/@thor/110731212646060568) when it comes to this stuff). [About page](https://web.archive.org/web/20230730181711/https://berserker.town/about) doesn't ban such content.

crlf.ninja
: Instance admin [endorses sending toxic racist slurs and being "horrible"](https://thechimp.zone/notice/AYGJJeBPdUXSuC7Fui) to people for blocking instances. Admin [participated in a transphobic dogpiling campaign](https://web.archive.org/web/20230730231641/https://ryona.agency/notice/AY8AHumTq4cb2lik76). [Admin publicizes blocks](https://archive.ph/hASVN).

federated.fun
: [Blatant transphobia from admin](https://web.archive.org/web/20230731162711/https://federated.fun/notice/AX46KDxhSkSNkxbSvw).

occultist.space OR enjoyer.network
: Run by the same admin as the.usualsuspects.lol. Admin [announced the.usualsuspects.lol from the.occultist.space](https://web.archive.org/web/20230705053714/https://the.usualsuspects.lol/notice/AXKIqzKiWFFDNryNM0). See [confirmation that the enjoyer.network admin is the same](https://pleroma.envs.net/notice/AY6ROdOne8F2oBGjtA).

shitposter.club
: Admin "Moon" [posts racist bait](https://web.archive.org/web/20230730211629/https://shitposter.club/notice/AXsvqZCmdxzMPgQN84). [Blatant transphobia from user "noyoushutthefuckupdad"](https://archive.ph/J8Bhe), who's [gone on multiple transphobic benders](https://web.archive.org/web/20230731043635/https://shitposter.club/notice/AXhKBOWHdKeWMCUSxs), [with admin knowledge](https://ghostarchive.org/archive/qJPUD). [Truscum user "animeirl"](https://web.archive.org/web/20230728221400/https://shitposter.club/notice/AY8QoV7rx1Oj37qKzw), who also [ran an instance of the ap-proxy block-evasion tool](https://puddle.town/@null/109839571095716330). [Some more racism](https://archive.ph/FSjhj). Note that its freeze-peach environment probably won't be changing: [other users, including the admin, seem fond of it in this thread](https://archive.ph/r254T).

{{</ nofollow >}}

</details>

## Future

Once Threads and/or Tumblr start federating, I plan to make a separate blocklist for "mainstream" social media platforms that prioritize profit over safety. I've explained my views on Threads in another post: {{<mention-work itemtype="BlogPosting">}}{{<cited-work name="De-federating P92" url="../../../../2023/06/20/defederating-p92/" extraName="headline">}}{{</mention-work>}}.

The biggest complaint I've heard is the lack of reasons and receipts. I'm working on adding them to this page. {{<mention-work itemtype="WebSite">}}{{<indieweb-person name="Are0h" url="https://roiskinda.cool/" itemprop="author">}} is working on a separate project called {{<cited-work name="The Bad Space" url="https://thebad.space/">}}{{</mention-work>}} to create an index of instances with receipts. It doesn't have a lot of content yet, but that will change with time. I've shared my receipt archive with him.

I like the idea of a separation between receipt-tracking projects and blocklist-generating projects. Reasons in a blocklist tend to invite retaliatory harassment in an effort to make admins hide their blocklists, often in the form of (very dubious) legal threats (defamation and privacy regulations have come up).

I also hope to see more tier-0 lists crop up. Any instance should be able to make a tier-0 list by sub-setting its own blocklist. When that happens, "Seirdy's Tier-0 list" will hopefully lose whatever authority it has.


[^1]: I did not consider dox attempts against certain neo-Nazis a reason to block.



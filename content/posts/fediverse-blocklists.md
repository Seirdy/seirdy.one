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
evergreen: true
sitemap:
    ChangeFreq: daily
    Priority: 0.7
---
I moderate the "pleroma.envs.net" Akkoma instance on the Fediverse, as <a href="https://pleroma.envs.net/users/Seirdy" rel="me">@Seirdy@pleroma.envs.net</a>.

I maintain three main blocklists for the Fediverse:


[The `pleroma.envs.net` blocklist](https://seirdy.one/pb/pleroma.envs.net.csv)
: A large list of instances that I find worth suspending. After the first couple hundred entries (imported and then reviewed), I started collecting receipts. Since early 2023, every entry has documented reasons and receipts. I share these with multiple people in a collaborative document, but I don't share it publicly due to risk of harassment. Unlike the other two lists on this page, it wasn't made for general use (though you're welcome to use it as reference).

[`tier0.csv`](https://seirdy.one/pb/tier0.csv)
: A much smaller semi-curated subset of `pleroma.envs.net` suitable for the majority of instances wishing to uphold the Mastodon Covenant's moderation standards. I hope to make it a good starting point for your instance's blocklist, with wiggle room for your own adjustments. I encourage you to add and remove entries as you see fit. Regularly importing `tier0.csv` won't account for retractions; [a sibling blocklist for tier-0 retractions](https://seirdy.one/pb/tier0-retractions.csv) exists for [FediBlockHole](https://github.com/eigenmagic/fediblockhole) users.

  Note that **this list is larger than the bare-minimum I recommend;** that'd be FediNuke. If you're skeptical of imported blocklists, you should start there.

[`FediNuke.txt`](https://seirdy.one/pb/FediNuke.txt)
: A curated subset of `tier0.csv`, containing what I deem the "worse half" of it. This contains instances I really do recommend most people block, or at least avoid. I try to make it a suitable candidate for a "default blocklist", and use it as reference when I evaluate the quality of other blocklists.

  This list is not comprehensive; to keep this list small, I excluded many really bad instances. I take into account not just severity, but also notoriety and likelihood of reaching/harming people on other instances (e.g. spewing toxicity in others' mentions, running blockbots, etc). Bad instances that mostly keep to themselves are less likely to cause problems for a new admin, and therefore less likely to get included in this minimal list.

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

The following are receipts for instances on my blocklists. Read the text surrounding a link before navigating to it, and let that context serve as a content-warning. No links point directly to the blocked instance; all go to a third-party archiving service.

Receipts are biased towards patterns in staff behavior or pervasive patterns among users with staff approval, as that generally won't be solved with a federated report. A one-off user action taken out of context, without any sign of staff endorsement, isn't enough to end up on one of these lists because it's not indicative of an instance's moderation policies. The one exception is receipts for legally risky media: I don't publish receipts for those, but it should be easy to verify them if you need to.

I use archive links instead of screenshots. Screenshots pose accessibility issues, can be doctored, and are easy to take out of context.

<details open=""><summary>Toggle receipts</summary>

### FediNuke entries

Criteria for a good FediNuke receipt is stricter than the aforementioned criteria:

- Reblogs are only significant if they are from a staff member and are boosting local users. They are mentioned alongside other receipts to indicate that the content in question is permitted by staff.
- Each instance must have multiple receipts.
- For larger instances: receipts must show staff behavior, or show consistent behavior from several users.

**This section is a work-in-progress,** and it will grow with time.

{{< nofollow >}}


13bells.com
: Admin posts [Sandy Hook school shooting conspiracy theories](https://archive.ph/dT9Am), [transphobia](https://archive.ph/Km8Ju).

1611.social
: [antisemitism from admin](https://web.archive.org/web/20230628203218/https://1611.social/@tyler/posts/AX9r68rwjhEQzMKJbU), [anti-vax from admin](https://archive.li/qFhQQ) with other local members, [antisemitic caricature from admin](https://archive.ph/3wIRL).

4aem.com
: Freeze peach PeerTube instance on the "tube" subdomain, hosting blatant antisemitic content. ["Clown World" dogwhistles](https://archive.ph/80Zwu), antisemitic ["Why Kanye West is right"](https://archive.ph/06UiV).

5dollah.click
: [Blatantly racist use of slurs](https://web.archive.org/web/20230803174643/https://5dollah.click/notice/AYFv0JRxfVez3K6ftQ) from staff account, [more racism from same account](https://web.archive.org/web/20230803174620/https://5dollah.click/notice/AYGifHRMwMFURlzgye). The [other staff account is racist too](https://web.archive.org/web/20230804231543/https://5dollah.click/notice/AXpsKVU45gZ5zHyVTk). ["About" page](https://web.archive.org/web/20230804225043/https://5dollah.click/about) lists no rules.

adachi.party
: The instance in question is on the "pleroma" subdomain. Its "about" page has the "Kill, behead, roundhouse kick" copypasta with racial slurs. [Archived "about" page](https://archive.ph/muPe1). Later updated rules to include ["must advocate for racism/fascism/nazism"](https://archive.ph/6Tpq5). [Admin posts racist transphobia](https://web.archive.org/web/20230730175847/https://pleroma.adachi.party/notice/AYAMup3aR6WhWwuHXU).

annihilation.social OR dembased.xyz
: [#FediBlock on 2023-02-24](https://pleroma.envs.net/notice/ASzpsfBstyxOmEtvEG)
: Hosts a blockbot user, [with the handle "blockbot"](https://archive.ph/BAid6), and [a defederation-notification bot](https://archive.ph/VFO2x). [Racism from admin](https://web.archive.org/web/20230729234055/https://annihilation.social/notice/ASwz1H2DlWPaIkUWki). dembased.xyz used to run the predecessor of annihilation.social. A few times since, a small experimental instance has been set up on a subdomain. Both are owned by the same person.

anon-kenkai.net
: [Blatant antisemitic caricature on the landing page](https://web.archive.org/web/20230729235305/https://peertube.anon-kenkai.com/) of its "peertube" subdomain. Admin on the "mitra" subdomain posts [anti-pride messages](https://archive.ph/9p5nw).

asbestos.cafe
: [Racism and ableism from admin](https://archive.ph/d7cfQ). [Admin sharing a dox](https://archive.ph/LUA10), [transmedical gatekeeping from a cis user](https://web.archive.org/web/20230731041522/https://the.asbestos.cafe/notice/AYCymnXAtifMLgNzJg), [antisemitism](https://web.archive.org/web/20230803032450/https://shrine.moe/notice/AYJfESHlqB0IvHPfqS), [queerphobic user](https://web.archive.org/web/20230803032850/https://pl.starnix.network/notice/AY1JMsQpMH4NukiNE0).

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
: [Racist meme from admin](https://web.archive.org/web/20230730212140/https://clew.lol/@Tony/posts/ATlNGVY9vg0FLp8WlE), [another racist meme](https://web.archive.org/web/20230730212307/https://clew.lol/@Tony/posts/ATlKwuT1NWt0vjGDCq). [Racial slurs in bio of a user with a white-nationalist dog whistle in their handle](https://web.archive.org/web/20230730212536/https://clew.lol/@hh1488) who [posts NJP propaganda](https://web.archive.org/web/20230730212719/https://clew.lol/@hh1488/posts/ATxalxgkzTwstq0QNc). [Local users participating in a transmisogynistic harassment campaign](https://web.archive.org/web/20230803154409/https://clew.lol/notice/AYMCIqKmuogqW2zLd2) with sui-bait.

clubcyberia.co
: Instance [features anti-black emotes](https://web.archive.org/web/20230730220345/https://clubcyberia.co/notice/AY9kBc1YiuBfP9TVgG). Users such as "Inginsub" often [post blatant racism](https://web.archive.org/web/20230730221532/https://clubcyberia.co/notice/AXSJ3fIo5mMORrLYPY). Hosts [a KiwiFarms staff member](https://web.archive.org/web/20230730222042/https://clubcyberia.co/users/crunklord420).

crucible.world
: Admin participating in [extremely transphobic harassment](https://web.archive.org/web/20230730231641/https://ryona.agency/notice/AY8AHumTq4cb2lik76), [more transphobia from admin](https://web.archive.org/web/20230730232208/https://crucible.world/notice/AYES99sUhEtMulC7M0), [even more transphobia](https://archive.ph/WVFrK).

cum.camp OR cum.salon
: Instance has MRF policies to reject deletes and run a blockbot [on cum.camp](https://web.archive.org/web/20230730232539/https://cum.camp/about) and [on cum.salon](https://web.archive.org/web/20221228172530/https://cum.salon/about). Staff members "pernia" and "nimt" are known for [overly-creepy posts related to sexual assault, esp. CSA](https://web.archive.org/web/20230730234254/https://boymoder.biz/notice/AXyuRlHglkmt1AHPn6), [another](https://web.archive.org/web/20230730233035/https://marsey.moe/@pernia@cum.salon/posts/AY8crsXbKZHmCIApgu).
: The cum.salon domain name was recently terminated by PorkBun after several people reported it for publishing dox materials. Other instances have locally overridden their DNS to continue federating until its TLS certificate expires.

decayable.ink
: Instance is well-known for harassment campaigns. [Targeted transmisogynistic harassment](https://archive.ph/KfDpN). [Racist admin](https://archive.ph/5XvUx), and [aftermath of said harassment](https://web.archive.org/web/20230802213907/https://decayable.ink/notice/AYEnvhUP1mVan0dnCi). The [instance introductory post](https://decayable.ink/@Decayable/posts/ATYE6r7bOp2bhCRfdY) is chock-full of red flags. [Another instance of haraassment](https://web.archive.org/web/20230803154310/https://decayable.ink/notice/AYMBCCDwBRL5nQUfGi).

detroitriotcity.com
: Well-known Nazi instance. [Instance "about" page](https://web.archive.org/web/20230801230826/https://detroitriotcity.com/about) says: <q>racial pejoratives, NSFW images & videos, insensitivity and contempt toward differences in sexual orientation and gender identification, and so-called “cyberbullying” are all commonplace on this instance</q> and has a staff account display name featuring an iron cross. Policies permitting lolicon may make it a legal risk, depending on your jurisdiction.

eientei.org
: [Instance "about" page](https://web.archive.org/web/20230801231939/https://eientei.org/about) explicitly describes it as a racist instance, anad uses racial slurs. MRF policies on the "about" page feature a blockbot and rejecting deletes. Admin [posts antisemitic caricatures](https://web.archive.org/web/20230801233538/https://eientei.org/notice/AW33QYo0a9vhhJUyC8). User "lina" has [a bio with blatant bigotry](https://web.archive.org/web/20230801232340/https://eientei.org/users/lina).

eveningzoo.club
: [Transphobia from admin](https://archive.ph/TuRrR), [more admin transmisogny](https://web.archive.org/web/20230802000535/https://eveningzoo.club/@Humpleupagus/posts/AYArUMz4q1OeHMwDxI), [racist meme from admin](https://web.archive.org/web/20230802000011/https://eveningzoo.club/@Humpleupagus/posts/AYCEaTUm2CXgJZbViq), [antisemitism from admin](https://web.archive.org/web/20230801235849/https://eveningzoo.club/@Humpleupagus/posts/AYHVUBiXEThuSK3fHM), [more antisemitism from admin](https://web.archive.org/web/20230802000129/https://eveningzoo.club/@Humpleupagus/posts/AYFDemmWklKkoCHOwS), [white nationalism from user](https://web.archive.org/web/20230802000313/https://eveningzoo.club/@WeavingTales/posts/AYBsfFdqlsr3nxioz2).

fluf.club
: [Transphobia from admin](https://archive.ph/24tJ4), [more transphobia](https://web.archive.org/web/20230802003149/https://eientei.org/notice/AYEuW35LVZ48XYOXPk), [transphobic sui-bait](https://web.archive.org/web/20230802003447/https://shitposter.club/notice/AYEKwm6THNpfFCVjm4).

freak.university
: Instance known for permitting paraphilia including pedophilia, and also explicitly allows minors (13+ although [that limit may be lowered](https://archive.today/2023.08.02-041801/https://freak.university/@headmasters/110743455953705070)). Scroll through local users on `/directory` for more receipts.

freeatlantis.com
: Far-right MAGA instance. Admin has reblogged local users posting [extreme transmisogny](https://freeatlantis.com/@TXPatriot2021/110527351920294198), [xenophobia](https://freeatlantis.com/@Luther/110334945481724374), [anti-drag](https://freeatlantis.com/@waronmorons/110288183334646071), [MAGA](https://freeatlantis.com/@watson/110137469656072122), [anti-vax](https://freeatlantis.com/@watson/109743198074918647), [more anti-vax](https://freeatlantis.com/@Phil/109693908947686128). Admin posts [QAnon](https://freeatlantis.com/@surferistic/109733973331065745).

freespeechextremist.com
: [End of this thread](https://web.archive.org/web/20230628203218/https://1611.social/@StarProphet@freespeechextremist.com/posts/AXA3GP4cXfijajukpU) has blatant antisemitism. [multiple other users engaging in transmisogyny](https://web.archive.org/web/20230802003611/https://eientei.org/notice/AYEtXJ1Dea4cIBV488), and [participating in a transmisogynistic harassment campaign](http://archive.today/2023.08.03-154818/https://freespeechextremist.com/notice/AYMCBqcaPUmd6J0ho8). [Transphobic blanket-pedojacketing](https://web.archive.org/web/20230803185746/https://freespeechextremist.com/notice/AYJ1aYy7Uutycamkuu). MRF policies include a [block-notification bot](https://web.archive.org/web/20230731164723/https://freespeechextremist.com/about). The linked page also makes it clear that this is a freeze-peach instance, so reporting won't help.

froth.zone
: [Blatant racism](http://archive.today/2023.08.03-004755/https://froth.zone/notice/AQAJYgb2fjf0bEhbvs), [racist homophobia](http://archive.today/2023.08.03-004725/https://froth.zone/notice/AQA5cC86URWDuOwgYi). Reporting is unlikely to help given the lack of rules against this, [some ableism from the admin](https://web.archive.org/web/20230803161348/https://froth.zone/notice/AVFLzUfMMCZGqnTm8e) and [some racism from the admin](https://web.archive.org/web/20230803161352/https://froth.zone/notice/AVFRa00PoXEWFDYR2u).

gearlandia.haus
: [Transphobic targeted harassment from multiple staff members](https://web.archive.org/web/20230805034502/https://gearlandia.haus/notice/AY8D5ossGoV9B7Eria), including sui-bait. [Racist use of slurs from another staff member](https://web.archive.org/web/20230805035409/https://gearlandia.haus/notice/AVBWXlFGHdqqogRnmK). [Assorted queerphobia from multiple users, including staff](https://web.archive.org/web/20230804224636/https://gearlandia.haus/notice/AV5ogisR5efiIwQzKa). Staff members sometimes post lolisho, which may pose a legal risk in some jurisdictions.

geofront.rocks
: Well-known Nazi instance. [Blatantly racist and transphobic use of slurs](https://web.archive.org/web/20230802234620/https://geofront.rocks/notice/AYKO5jmR77AB8nBtZo), [ethno-nationalism](https://web.archive.org/web/20230802234722/https://geofront.rocks/notice/AYJDETasJd7SUuuS4O). All from what seems to be the primary active user of the instance. Another user has a [blatantly nazi profile](https://web.archive.org/web/20230802235236/https://geofront.rocks/@flux) featuring violent transphobic shock content.

gameliberty.club
: [Freeze-peach rules](https://archive.ph/ir4hc) permit lolisho, which may be a legal risk depending on your jurisdiction. [Admin pinned posts](https://archive.ph/x9xUe) contain slurs in un-reclaimed contexts, and [runs an rsdb bot](https://gameliberty.club/@dailyslurbot) for more. Admin [posts racist memes](https://gameliberty.club/@matrix/110691184671379555), [more racist memes](https://gameliberty.club/@matrix/110691000630024399), [anti-pride](https://gameliberty.club/@matrix/110705822988959149).

genderheretics.xyz
: ["About" page explicitly labels the instance as transphobic](https://web.archive.org/web/20230804235043/https://genderheretics.xyz/about). Admin [posts unmarked NSFL medical gore](https://ghostarchive.org/archive/wlQdv) in a transmisogynistic context. [Anti-drag pedojacketing](https://web.archive.org/web/20230805000311/https://genderheretics.xyz/@william/posts/AYFfRi8X3hx6nJOaXY) from admin.

gleasonator.com
: [Admin is an outspoken TERF](http://archive.today/2022.08.07-110329/https://blog.alexgleason.me/trans/), who [was head of engineering for Truth Social](https://web.archive.org/web/20230803181726/https://soapbox.pub/blog/soapbox-awarded-grant/). User "caekislove" [pedojackets and sui-baits trans users](http://archive.today/2023.08.03-190023/https://gleasonator.com/notice/AYJ72Lm5gRlKpIEUJU), does [homophobic pedojacketing as well](https://web.archive.org/web/20230803185742/https://freespeechextremist.com/notice/AYKvBEbxq0k2psshlY), and [posts extreme classism](http://archive.today/2023.08.03-190720/https://gleasonator.com/notice/AYL1K2K8WseIIv7xtg) (violent imagery). [Admin is aware of the user but will not take action](https://web.archive.org/web/20230803184758/https://annihilation.social/notice/AWfGcY4mrHiPL3mgfQ) (unrelated extreme bigotry and Nazi iconography in thread).

glee.li
: [Racist harassment of Mutual Aid posts](https://archive.ph/Vz1Yv). More [blatant racism and transmisia](https://archive.ph/SI0xG). Admin [posts <q>glad shes gone</q> in response to a gender and sexuality scholar dying](https://web.archive.org/web/20230803031028/https://glee.li/notice/AYG0asC42hyR8rld3I), and [participates in a transmisogynistic harassment campaign](http://archive.today/2023.08.03-154818/https://freespeechextremist.com/notice/AYMCBqcaPUmd6J0ho8). Instance is associated with [the website https://getgle.org](https://web.archive.org/web/20230731045659/https://getgle.org/dark-mode.html). Split off of asbestos.cafe in early 2023, formerly at a subdomain of getgle.org.

h5q.net
: Contains untagged AI-generated photorealistic erotic content that may pose a legal risk in several jurisdictions.

iddqd.social
: Admin posts [anti-Black caricatures](https://archive.ph/1dIUL), supports [organized predatory retaliation against DEI efforts](https://archive.ph/PfHYX). [Instance landing page](https://archive.ph/0JlGl) markets itself as an instance for 4chan users.

kawa-kun.net
: Instance [rejects deletes](https://web.archive.org/web/20230731050219/https://bbs.kawa-kun.com/about). (unfinished entry)

kitsunemimi.club
: [Admin "bronze" participates in racist harassment](https://web.archive.org/web/20230731183425/https://needs.vodka/notice/AYFCFHRqKX6RjsF7Fw), sends users [transphobic shock content](https://web.archive.org/web/20230731184313/https://pl.kitsunemimi.club/notice/AYG5j6YeP0wZI1jaPw). Runs the [HighRoller MRF policy](https://web.archive.org/web/20230731183641/https://pl.kitsunemimi.club/about) for a block-notification bot.

kiwifarms.cc
: The official occasionally-online [KiwiFarms](https://www.cnet.com/culture/internet/kiwi-farms-what-to-know-about-the-hate-filled-message-forum-dropped-by-cloudflare/) Fediverse instance. Look up "KiwiFarms" online if you want receipts. It briefly came back once after a long period of downtime, so I'm not removing it during the current downtime.

kyaruc.moe
: Admin [sui-baiting to get on this list](https://web.archive.org/web/20230802182509/https://ak.kyaruc.moe/notice/AYHzrqQ7hXqfemWlfM), [racist use of slurs](https://ghostarchive.org/archive/mWst4), [targeted ableist harassment](https://web.archive.org/web/20230802222537/https://clubcyberia.co/notice/AXtFrDv5xhLpVMHzqy).

leafposter.club
: [Blatant antisemitism and queerphobia](https://web.archive.org/web/20230731051338/https://cawfee.club/notice/AVS1llk6NOrAVPAB60), [SWERF](https://web.archive.org/web/20230731050932/https://leafposter.club/@Upsman/posts/AVS1ImJqDW5yEPcgwi), [blatant racist use of slurs](https://web.archive.org/web/20230731051017/https://leafposter.club/@Leaflord/posts/AVS04CFlPbegMpCOP2).

ligma.pro
: The admin [threatened mass violence](https://archive.ph/1CWNR), [threatened animal cruelty](https://archive.ph/lDbc0), [posted unmarked gore (CW: NSFL gore)](https://archive.ph/BJ4Iu), [bragged about making death threats](https://archive.ph/fHnSg). After his infosec.exchange alt got banned he set up shop on fosstodon.org.

marsey.moe
: boks.moe had [the occasional holocaust denial meme](https://archive.ph/ozeh1). one of the main users "Ruusu" set their display name to [a racial slur in a violent context](https://archive.ph/ANM7B). Staff member "MischievousuTomatosu" posts [blatantly racist takes on border control](https://archive.ph/WP9mb). [boks.moe moved to marsey.moe](https://web.archive.org/web/20230730191654/https://shitposter.club/notice/AX3ZOWyu6dX384tV32), which features a [hitler-themed racist "Witster_" account](https://archive.ph/2dTWR), [making fun of mutual aid posts](https://archive.ph/Uri4S), [racist misogyny](https://web.archive.org/web/20230804231317/https://marsey.moe/notice/AXyBmu2bgZCX3hTp2G)

midwaytrades.com
: Runs [a Libs of TikTok bot](https://web.archive.org/web/20230802162551/https://freesoftwareextremist.com/notice/AYBwS5rDjFaDyIqKtU). [Transphobic and misogynist admin](https://ghostarchive.org/archive/9qO8r).

morale.ch
: [Transphobia](http://archive.today/2023.08.03-163829/https://morale.ch/notes/9gq5de3opm), [blatant antisemitism](http://archive.today/2023.08.03-163438/https://morale.ch/notes/99afbs2fi7), and [both at once](http://archive.today/2023.08.03-163416/https://morale.ch/notes/99afgfh0il). [Ableist holocaust denial](http://archive.today/2023.08.03-165106/https://morale.ch/notes/9fhmfgittd). All from the admin account.

mugicha.club
: Admin [participated in a transphobic targeted harassment campaign](https://web.archive.org/web/20230803192951/https://strelizia.net/notice/AY89eVVq0KBnBANq3k) with local users. [Anti-asian racist slurs from admin](https://web.archive.org/web/20230803192115/https://strelizia.net/notice/AYMZTqabCh9ZBRZFU8), [misogynistic racism from admin](https://web.archive.org/web/20230803192548/https://strelizia.net/notice/AYIxpdSJqqonI55f0q) with several local users with Confederate battle-flags in their display names. More [blatantly racist use of slurs from admin](https://web.archive.org/web/20230803192732/https://strelizia.net/notice/AYCAY6fkm4FiXMrv8K).

needs.vodka
: Admin [posts ethno-fascist harassment](https://web.archive.org/web/20230731171924/https://needs.vodka/notice/AYEXL71RuRXt1MYkSG), [antisemitism](https://web.archive.org/web/20230731172003/https://needs.vodka/notice/AYE2Y0GlEONjGKO8dk). Supports [racist, misogynistic, violent grooming](https://web.archive.org/web/20230731172555/https://needs.vodka/notice/AYAgwij0ohSdci6UjI).

nicecrew.digital
: [Blatant anti-Black racism from staff](https://web.archive.org/web/20230731154105/https://nicecrew.digital/notice/AT5UuihBpC4ZI8xIlk), [anti-Black racist caricature from staff](https://web.archive.org/web/20230731153949/https://nicecrew.digital/notice/AYCsMzQsKax7qc0b1E). [Antisemitic COVIDspiracy from staff](https://web.archive.org/web/20230731160204/https://nicecrew.digital/notice/AY4YmRWar1CMk4usOO). Has [a bot to spam threads with racist slurs](http://archive.today/2023.08.03-153949/https://nicecrew.digital/@nice-nigger).

noagendasocial.com
: far-right instance connected to the No Agenda show. [Queerphobia](https://archive.ph/Km8Ju). One of its more popular users is [openly an ethno-nationalist](https://web.archive.org/web/20230731165314/https://noagendasocial.com/@amerika) with [thinly-veiled genocidal views](https://web.archive.org/web/20230731165038/https://noagendasocial.com/@amerika/110652580178110907) and runs the far-right amerika.org blog. An even more popular user [regularly posts far-right content](https://web.archive.org/web/20230731165844/https://noagendasocial.com/@furgar/110558690945902519).

noagendasocial.nl OR noagendatube.com
: Sibling instances of noagendasocial.com, also connected to the No Agenda Show.

norwoodzero.net
: Admin [pedojackets in a transphobic harassment campaign](https://web.archive.org/web/20230803155542/https://norwoodzero.net/notice/AYME53gDdYuiYrDxtQ). [Instance "about" page](https://web.archive.org/web/20230803160235/https://norwoodzero.net/about) contains racial slurs and an animated banner that says "whites only".

poa.st
: Well-known Nazi instance. See receipts for needs.vodka, kitsunemimi.club, and shitpost.cloud for poast users.

poster.place
: Staff member "spitfire" [spams the "mutualaid" guppe group and hashtag with extreme queerphobia](https://web.archive.org/web/20230730195759/https://breastmilk.club/notice/AWy4STyPAWSj5e0SYq), and [makes racist homophobic slur-filled anti-antifa posts](https://web.archive.org/web/20230803191342/https://poster.place/notice/AYKzM8YDhgDVhxcsaG). Instance header contains an animated GIF full of slurs.

ryona.agency OR plagu.ee
: Admin bio features [blatant racism, antisemitism, misogyny, and other bigotry](https://web.archive.org/web/20230802203632/https://ryona.agency/mint). [Admin participates in transmisogynistic harassment](http://archive.today/2023.08.03-154852/https://ryona.agency/notice/AYMBAB2LPVkH8l7vk0). [Blatant racism from a local user](https://archive.ph/KoMXa). The [instance "about page" features MRF policies](https://web.archive.org/web/20230802204037/https://ryona.agency/about) to power a block-notification bot, to convert all posts (including DMs) to public visibility, and to reject deletes. Also runs a version of Pleroma [patched to allow bypassing authorized-fetch](https://web.archive.org/web/20230802204840/https://gitgud.io/ryonagency/pleroma/-/commit/d7fca9df32f4f083779371a3f843285188372ba6).
: [plagu.ee is run by the same admin as ryona.agency](https://pleroma.envs.net/notice/ATvo35BQNlDY9DQQue), with similar patches and MRF policies applied as per [the plagu.ee "about" page](https://web.archive.org/web/20230410181459/https://plagu.ee/about).

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

bungle.online
: [Racial slurs from admin](https://web.archive.org/web/20230731203927/https://pleroma.mercurial.blog/notice/AYEijPLGfx2ZMOHK76), [repeatedly uses ableist slurs](https://archive.ph/l9cUm). [Another example](https://archive.ph/i1dSh).

crlf.ninja
: Instance admin [endorses sending toxic racist slurs and being "horrible"](https://thechimp.zone/notice/AYGJJeBPdUXSuC7Fui) to people for blocking instances. Admin [participated in a transphobic dogpiling campaign](https://web.archive.org/web/20230730231641/https://ryona.agency/notice/AY8AHumTq4cb2lik76). [Admin publicizes blocks](https://archive.ph/hASVN).

federated.fun
: [Blatant transphobia from admin](https://web.archive.org/web/20230731162711/https://federated.fun/notice/AX46KDxhSkSNkxbSvw).

firedragonstudios.com
: Currently runs an instance on the "pleroma" subdomain. Used to run [a freeze-peach instance under the "freespeech" subdomain](https://web.archive.org/web/20221001084127/https://freespeech.firedragonstudios.com/@Siedge/with_replies), allowing [far-right linkspam](https://web.archive.org/web/20221126183927/https://freespeech.firedragonstudios.com/@patriotpast?max_id=105583438413728295), [anti-vax](https://web.archive.org/web/20220118052456/https://freespeech.firedragonstudios.com/@PhoenixRising/107370066152809226), and [anti-woke users](https://web.archive.org/web/20220621231710/https://freespeech.firedragonstudios.com/users/orangesec_0/statuses/102136233427211000). Got widely blocked as a result before switching domains. Current "pleroma" subdomain seems inactive but still allows registration.

freesoftwareextremist.com
: [ableism and antisemitism from local user "dookie"](https://web.archive.org/web/20230802162551/https://freesoftwareextremist.com/notice/AYBwS5rDjFaDyIqKtU), [ableist sui-bait](https://web.archive.org/web/20230802164139/https://freesoftwareextremist.com/notice/AYItcRuj1hvuTKLhmy), [ableism and queerphobia](https://web.archive.org/web/20230802233803/https://freesoftwareextremist.com/notice/AY7nGBF4CsuYydOyxM). Admin [often uses anti-Chinese racial slurs](https://web.archive.org/web/20230802231531/https://freesoftwareextremist.com/notice/ATzjhzI7r5Y8Cv1DW4), [more usage](https://web.archive.org/web/20230802231652/https://freesoftwareextremist.com/notice/AY1b8vq2iKh4mIiNcm), [other anti-asian slurs](http://archive.today/2023.08.02-232207/https://freesoftwareextremist.com/notice/ARbAeXyGwquJKoxFPk). Instance has fully open registration.

freetalklive.com
: [Instance "about" page](https://web.archive.org/web/20230802051117/https://social.freetalklive.com/about) self-identifies as unmoderated, except for spam. Connected to the libertarian Free Talk Live show.

kompost.cz
: [Racism](https://ghostarchive.org/archive/cWEbG), [more racism](https://web.archive.org/web/20230804231946/https://kompost.cz/@fuxoft/110656548914018074), [transphobia](https://web.archive.org/web/20230804232125/https://kompost.cz/@fuxoft/110321506728744090), [queerphobia](https://ghostarchive.org/archive/Nmop2). All from admin.

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



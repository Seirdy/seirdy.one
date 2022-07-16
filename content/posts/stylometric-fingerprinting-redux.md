---
title: "Stylometric fingerprinting redux"
date: 2022-07-09T21:49:06-07:00
articleType: "TechArticle"
description: "Avoid de-anonymization through analysis of your writing style. Defend against machine- and human-driven stylometric identification."
outputs:
    - html
    - gemtext
---
<p role="note">
This is an expanded version of a microblog entry: {{<mention-work itemtype="SocialMediaPosting">}}{{<cited-work name="Stylometric fingerprinting resistance" url="../../../../../notes/2022/06/24/stylometric-fingerprinting-resistance/">}}{{</mention-work>}}. It contains everything in that entry and more.
I am open to feedback, especially from anybody with a more thorough background in the subject; <a href="{{<relref "about" >}}">here’s my contact information</a>.
</p>

<section role="doc-introduction">

Intro&shy;duction {#introduction}
-----------------

Following a recent landmark <abbr title="Supreme Court of the United States">SCOTUS</abbr> ruling, many have been trying to publish resources to help people find reproductive healthcare. They often wish to publish anonymously, to avoid being harassed or doxxed by overzealous religious fundamentalists. Some people asked me for help.

There's no shortage of guides on how to stay anonymous online. I recommend using the Tor Browser in a disposable Whonix VM. [The Whonix Wiki has a good guide to anonymous publishing](https://www.whonix.org/wiki/Surfing_Posting_Blogging). Few guides cover [stylometric fingerprinting](https://en.wikipedia.org/wiki/Stylometry).

<dfn>Stylometric fingerprinting</dfn> analyzes unique writing style (i.e., it uses <em>stylometry</em>) to identify the author of a work. It's one of the most common techniques for de-anonymization, used by adversaries ranging from trolls to law enforcement.

For a <abbr title="Too Long; Didn't Read">TL;DR</abbr>, skip to [the "Conclusion" section](#conclusion).

</section>

How stylometric fingerprinting works
------------------------------------

To paint with a broad brush, we can divide most stylometric fingerprinting into machine- and human-driven techniques.


Machine-driven techniques
: These techniques involve analysis of reading level metrics, unusual words, machine-identifiable grammatical and spelling errors, and statistical analysis of writing style. A great amount of recent research studies statistical analysis of writing style; it's a rapidly-evolving field.

Human-driven techniques
: There are some areas in which manual analysis still beats computers. Someone you know may recognize your writing style.

Defense against machine-driven techniques
-----------------------------------------

Common advice is to use offline machine translation to translate works to and from another language. [Argos Translate](https://www.argosopentech.com/) and [Marian](https://marian-nmt.github.io/) are two options that come to mind.

### Obfuscation and imitation

{{<mention-work itemprop="citation" role="doc-credit" itemtype="ScholarlyArticle">}}{{<cited-work name="Adversarial stylometry: Circumventing authorship recognition to preserve privacy and anonymity" extraName="headline" url="https://doi.org/10.1145/2382448.2382450">}}{{</mention-work>}} shows that machine translation alone isn't nearly as strong a method as manual approaches: obfuscation (hiding your writing style) or imitation (mimicking another author). These approaches have excellent success rates, even among amateur writers. The aforementioned Whonix wiki page lists common stylometric fingerprinting vectors for manual approaches to address.

Limiting unusual vocabulary and sentence structure make for a good start. Using a comprehensive and highly-opinionated style-guide should also help. <cite>The Economist</cite> has a good one that was specifically written to make all authors sound the same: {{<mention-work itemtype="Book">}}{{<cited-work name="The Economist Style Guide" url="https://cdn.static-economist.com/sites/default/files/pdfs/style_guide_12.pdf">}}, <span itemprop="bookEdition">12th edition</span> (<span itemprop="encodingFormat">application/<wbr />pdf</span>){{</mention-work>}}.

Nearly every respected newspaper has a style guide. Tech companies typically publish or use a style guide for technical writing. I'm a fan of Red Hat's style guide: {{<mention-work itemtype="Book">}}{{<cited-work name="Red Hat Technical Writing Style Guide" url="https://stylepedia.net/style/5.1/">}}, <span itemprop="bookEdition">Edition 5.1</span>{{</mention-work>}}.

Good style guides are long, and learning one is tough. Read a large amount of conforming content to help yourself internalize a guide's rules.

### Reading levels

The reading difficulty of a piece is a coarse but extremely simple measure. If the anonymous author of a piece writes at a tenth-grade level, their other writings are likely near a tenth-grade level too.

Check your content's reading level using common readability metrics. The [Flesch-Kincaid Grade Level](https://en.wikipedia.org/wiki/Flesch%E2%80%93Kincaid_readability_tests) is one of the most popular. If you write at a given grade level, publish anonymously at a lower grade level. I recommend using a lower grade level rather than a higher one for two reasons:

1. Artificially inflating the reading level generally produces cringeworthy writing.
2. Writing at a lower level carries less risk of introducing uncommon fingerprintable words.

### Other tips

For any inexperienced writers: opinionated offline grammar checkers such as [LanguageTool](https://github.com/languagetool-org/languagetool) and [RedPen](https://github.com/redpen-cc/redpen) may supplement a manual approach by normalizing any distinguishing "errors" in your language. That being said, nothing beats a human editor. Find someone you trust to review your work.

Here are some resources for further reading:

- {{<mention-work itemtype="Article">}}{{<cited-work name="How we authenticate a document" url="https://www.orphanalytics.com/en/method" extraName="headline">}} by <span itemscope="" itemprop="publisher" itemtype="https://schema.org/Organization">OrphAnalytics SA</span>{{</mention-work>}}.

- {{<mention-work itemtype="Article">}}{{<cited-work name="Unveiling the Anonymous Author: Stylometry Techniques" url="https://serhack.me/articles/unveiling-anonymous-author-stylometry-techniques/" extraName="headline">}} by {{<indieweb-person itemprop="author" name="SerHack" url="https://serhack.me/">}}{{</mention-work>}}.

Defense against human-driven techniques
---------------------------------------

Human-driven techniques were behind the most high-profile successful cases of stylometric fingerprinting by law enforcement. When the Unabomber published his manifesto, his brother recognized some signature phrases in his manifesto and went to the FBI. One of the largest Australian CSA cases involved [recognizing someone's distinctive greeting of "Hiya"](https://www.nowtolove.com.au/news/real-life/the-online-child-sex-abuse-epidemic-9139).

While the research I cited seems to indicate that machine translation is a poor way to thwart machine-driven techniques, I'm not convinced that it's useless. Machine translation may be ineffective at thwarting machine-driven stylometric fingerprinting, but it should be able to highlight or remove uniqueness a human could notice. Let's look at some examples.

### Example: Unabomber manifesto

Here's a sentence from the Unabomber manifesto:

> But it is obvious that modern leftist philosophers are not simply <mark>cool-headed logicians</mark> systematically analyzing the foundations of knowledge.

David Kaczynski noticed the phrase "cool-headed logicians" as a potential signature identifying his brother. After further analysis, the author was clear.

{{<quotation>}}

<blockquote itemprop="text">

After I read the first few pages, my jaw literally dropped. One particular phrase disturbed me. It said modern philosophers were not “cool-headed logicians.” Ted had once said I was not a “cool-headed logician,” and I had never heard anyone else use that phrase…We had Linda’s childhood friend Susan Swanson, a private investigator, take two of Ted’s letters to a linguistics expert, who analyzed them and found there was an 80 percent chance the same person had written the letters and the manifesto.

</blockquote>
{{<quotecaption partOfType="NewsArticle">}}
{{<indieweb-person first-name="David" last-name="Kaczynski" url="https://web.archive.org/web/20100316051613/http://blog.timesunion.com/kaczynski/" itemprop="author">}},
{{<cited-work name="Blood Bond" extraName="headline" url="https://people.com/archive/blood-bond-vol-50-no-4/">}}
{{</quotecaption>}}
{{</quotation>}}

Let's run it through Argos Open Translate's English-Esperanto filter,[^1] and then translate it back to English:

> But it is evident that modern left-wing philosophers are not simply <mark>dehydrated logicians</mark> systematically analyzing the foundations of knowledge.

"Dehydrated logicians" obviously isn't the right term to use here. The fact that the translation algorithm mistook "cool-headed" for "dehydrated" indicates that "cool-headed" was an unusual choice of words to use in this context, and therefore a fingerprinting vector. A more common phrase like "detached" would be safer.

### Extreme example: Mario

Let's look at another phrase:

> Whoohoo! It's a-me, Mario!

"Mario" is a common name, but I have a feeling you know that [this "Mario" is the Nintendo character](https://en.wikipedia.org/wiki/Mario). Running this line through an English-Esperanto and Esperanto-English filter gives us:

> Who! It's me, Mary!

Our findings:

- "Whoohoo" is uncommon enough to be unrecognized by the translation algorithm. Replace or remove it.
- Saying "a-me" is less common than saying "me".
- "Mario" is less common than "Mary" in an English-speaking context.

Additionally, inflection (e.g., using an exclamation point) can make your writing voice recognizable. Use it with care.

Let's re-phrase Mario's line to be less identifiable:

> Hey, it's me. Mario.

That's a little better.

Example: my fingerprint
-----------------------

I have my share of fingerprintable stylistic and formatting quirks. A non-exhaustive list:

- Qualifying lists with words like "non-exhaustive" or "incomplete".

- Putting punctuation outside quotations or hyperlinks whenever acceptable.

- Using many colons, semicolons and conjunctive adverbs; for example, this sentence uses the latter two.

- Obsessively distinguishing between concepts and implementations of those concepts, resulting in a statistically high use of the word "implementation".

- Introducing some articles with HTML description lists before elaborating on each entry in that list.

- Using soft-hyphens so text can wrap to narrow widths.

Writing is a skill
------------------

Developing a high-quality writing style is hard. Developing and switching between multiple different styles is even harder. It takes time to master multiple style guides, cultivate a different "voice" free of your usual idiosyncrasies, and keep your different voices from influencing one another. "Getting into character" won't happen overnight if you don't have experience.

Translation tools are <span data-literal="temporary learning aids">training-wheels</span> to help you learn to identify idiosyncrasies. As you get better, you might be able to filter out problematic language without their help.

Don't feel pressured to start soon! If you want to publish under a truly anonymous pseudonym, you should first hone your craft. Alternatively, find a good editor.[^2]

<section role="doc-conclusion">

Conclusion
----------

If you wish to write anonymously, I recommend the following:

1. Analyze your non-anonymous writing, looking for patterns. Write these patterns down. When you review your anonymous publications, refer to your list of identifiable patterns and remove them. Consider asking someone else for help, since your own bias might cause you to overlook some patterns.

2. Translate your work to and from another language with an offline machine translator. Don't actually publish the translator's output; instead, read the output to identify potentially-fingerprintable language you missed in the previous step.

3. Correct any grammatical or spelling errors; mistakes you make might be unique.

4. Conform to an opinionated style-guide that you don't normally use in your other writing.

5. If, after doing the above, your anonymous work still has a reading level too similar to your non-anonymous writing: reduce the reading level by choosing simpler words.

Stay safe, everyone.

</section>


[^1]: I didn't pick Esperanto for any particular reason.

[^2]: I am not the best person for this job, sorry.



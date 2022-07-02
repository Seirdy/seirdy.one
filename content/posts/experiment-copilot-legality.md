---
title: "An experiment to test GitHub Copilot's legality"
date: 2022-07-01T17:30:45-07:00
description: "A horrible idea to determine the legality of GitHub Copilot, or of re-creating proprietary speech synthesizers: create legal precedent that doesn't exist yet!"
outputs:
    - html
    - gemtext
---
<section role="doc-preface">

<h2>Preface</h2>

I am not a lawyer. This post is satirical commentary on:

- The absurdity of Microsoft and OpenAI's legal justification for GitHub Copilot.
- The oversimplifications people use to argue against GitHub Copilot (I don't like it when people agree with me for the wrong reasons).
- The relationship between capital and legal outcomes.
- How civil cases seem like sporting events where people "win" or "lose", rather than opportunities to improve our understanding of law.

In the process, I intentionally misrepresent how the judicial system works: I portray the system the way people like to imagine it works. Please don't make any important legal decisions based on anything I say.

The only section you should take seriously is ["Context: the relevant technologies"](#context).

</section>

<section role="doc-introduction">

Introduction
------------

GitHub is enabling copyleft violation <span aria-hidden="true">✨</span>at scale<span aria-hidden="true">✨</span> with Copilot. GitHub Copilot encourages people to make derivative works of source code without complying with the original code's license. This facilitates the creation of permissively-licensed or proprietary derivatives of copyleft code.

Unfortunately, challenging Microsoft (GitHub's parent company) in court is a bad idea: their legal budget probably ensures their victory, and they likely already have a comprehensive defense planned. How can we determine Copilot's legality on a level playing field? We can create legal precedent that they haven't had a chance to study yet!

A chat with {{<indieweb-person itemprop="mentions" first-name="Matt" last-name="Campbell" url="https://mwcampbell.us/blog/">}} about a speech synthesizer gave me a horrible idea. I think I know a way to find out if GitHub Copilot is legal: we could use its legal justification against another software project with a smaller legal budget. Specifically, against a speech synthesizer. The outcome of our actions could set a legal precedent to determine the legality of Copilot.

</section>

Context: the relevant technologies {#context}
----------------------------------

Let's cover the technologies and actors at play _before_ I start my evil monologue.

### Exhibit A: GitHub Copilot

<dfn>GitHub Copilot</dfn> is a predictive autocompletion service for writing software. It's powered by [OpenAI Codex](https://openai.com/blog/openai-codex/), a language model based on [GPT-3](https://en.wikipedia.org/wiki/GPT-3). It was trained using the source code of public repositories hosted on GitHub, regardless of their licensing. In response to a Request for Comments from the US Patent and Trademark Office, OpenAI claimed that "Artificial Intelligence Innovation", such as code written by GitHub Copilot, should be considered "fair use".[^1]

Many of the code snippets it suggests are exact copies of source code from various GitHub repositories. For an example, see this tweet: {{<mention-work itemtype="SocialMediaPosting">}}{{<cited-work name="I don't want to say anything but that's not the right license Mr Copilot." url="https://twitter.com/mitsuhiko/status/1410886329924194309">}} by {{<indieweb-person url="https://lucumr.pocoo.org/about/" first-name="Armin" last-name="Ronacher" itemprop="author">}} (here's an <a itemprop="archivedAt" href="https://web.archive.org/web/20220701010012/https://nitter.pussthecat.org/mitsuhiko/status/1410886329924194309">archive link that doesn't require JavaScript</a>, captured on <time datetime="2022-07-01T01:00:12+00:00">2022-07-01</time>) <span itemprop="description">It contains a screen recording of Copilot suggesting [this Quake code](https://github.com/id-Software/Quake-III-Arena/blob/dbe4ddb10315479fc00086f08e25d968b4b43c49/code/game/q_math.c#L552). When prompted to do so, it obediently fills in a permissive license.</span>{{</mention-work>}} That permissive license violates [the Quake code's GPL-2.0 license](https://github.com/id-Software/Quake-III-Arena/blob/dbe4ddb10315479fc00086f08e25d968b4b43c49/COPYING.txt). Copilot provides no indication that a license violation is taking place.

GitHub performed its own research into the matter.[^2] You can read about it on their blog: {{<mention-work itemtype="BlogPosting">}}{{<cited-work url="https://github.blog/2021-06-30-github-copilot-research-recitation/" name="GitHub Copilot research recitation" extraName="headline">}}, by {{<indieweb-person url="https://github.com/wunderalbert" first-name="Albert" last-name="Ziegler" itemprop="author">}}{{</mention-work>}}. I'm not convinced that it accounts for the fact that suggested code might have mechanical alterations to match surrounding text, while still remaining close enough to trained data to be a license violation.

### Exhibit B: The Eloquence speech synthesizer

I recently had a chat with Matt on IRC about screen readers and different types of speech synthesizers. I mentioned that while I do like some variety, I always find myself returning to the underrated robotic voice of [eSpeak NG](https://github.com/espeak-ng/espeak-ng/). He shared some of my fondness, and also shared his preference for a similar speech synthesizer called Eloquence.

Downloads of Eloquence are easy to find (it's even included with the JAWS screen reader), but I struggle to find any "official" pages about the original Eloquence. Nuance acquired Eloquent Technology, the developer of Eloquence. Microsoft later acquired Nuance.

{{<transcribed-image id="eloquence" type="audio" itemtype2="AudioObject" itemprop="hasPart">}}

#### <span itemprop="name">Eloquence sample audio</span> {#eloquence-sample}

<figure>
{{<audio name="eloquence">}}
<figcaption itemprop="description">

Matt recorded this sample audio clip of Eloquence reading some text. The text is from the introduction of {{<mention-work itemprop="encodesCreativeWork" itemtype="TechArticle">}}{{<cited-work name="Best practices for inclusive textual websites" url="../../../../2020/11/23/website-best-practices/" extraName="headline">}}{{</mention-work>}}

</figcaption>
</figure>

{{<transcribed-image-transcript type="audio">}}

My primary focus is inclusive design. Specifically, I focus on supporting underrepresented ways to read a page. Not all users load a page in a common web-browser and navigate effortlessly with their eyes and hands. Authors often neglect people who read through accessibility tools, tiny viewports, machine translators, “reading mode” implementations, the Tor network, printouts, hostile networks, and uncommon browsers, to name a few. I list more niches in the conclusion. Compatibility with so many niches sounds far more daunting than it really is: if you only selectively override browser defaults and use plain-old, semantic HTML (POSH), you've done half of the work already.

{{</transcribed-image-transcript>}}

{{</transcribed-image>}}

I like the Eloquence speech synthesizer. It sounds similar to the robotic yet predictable voice of my beloved eSpeak NG, but with improved overall quality. Unfortunately, Eloquence is proprietary.

### Exhibit C: Deep learning speech synthesis

<dfn>[Deep learning speech synthesis](https://en.wikipedia.org/wiki/Deep_learning_speech_synthesis)</dfn> is a recent approach to speech synthesizer creation. It involves training a deep neural network on voice samples, and using the trained model to generate speech similar to a real human voice. One synthesizer using deep learning speech synthesis is [Mozilla's TTS](https://github.com/mozilla/TTS).

Zero-shot approaches could allow a pre-trained model to generate multiple different voices. [YourTTS](https://doi.org/10.48550/arXiv.2112.02418) is one such example. This could allow us to synthetically re-create a person's voice more easily.

My horrible plan
----------------

My horrible plan revolves around going through two different lawsuits to set some judicial precedents; these precedents could improve the odds of succeeding in a lawsuit against Microsoft for Copilot's licensing violations.

If this succeeds, we have new legal justification that GitHub Copilot is illegal; if it fails, we have still gained a means to legally re-create proprietary software. It's a win-win situation.

### Part One: set a precedent

1. Train a modern text-to-speech (TTS) engine using the voice a proprietary one made by a company with a small legal budget. Keep the model's internals hidden.
2. Then release the final TTS under a permissive license. Remember, we're still keeping the machine-learning model hidden!
3. Wait for that company to file suit.[^3]
4. Win or lose the case.

### Part Two: use that precedent against Microsoft's Nuance

Our goal here is to get the same legal outcome as the low-stakes "trial run" of Part One.

Microsoft owns Nuance. Nuance previously bought Eloquent Technology, the developers of the Eloquence speech synthesizer.

1. Repeat Part One against Nuance speech synthesizers, including Eloquence. Go to court.
2. Have the ruling from Part One cited as legal precedent.
3. Achieve the same outcome as Part One, demonstrating that we have indeed set precedent that works against Microsoft's legal department.

### Implications of the outcomes

If we _win_ both cases: Microsoft has the legal high ground. Making a derivative of a copyrighted work using a machine-learning algorithm allows us to bypass copyright licenses.

If we _lose_ both cases: Microsoft does not have the legal high ground. We have good judicial precedent against Microsoft to use when filing suit for Copilot's behavior.

Either way, it's an absolute win for free software. Taking down Copilot protects copyleft from enabling proprietary derivatives (and by extension, protects software freedom). But if we accidentally win these two low-stakes "test" cases, we still gain something else: we can liberate huge swaths of proprietary software, starting with speech synthesizers.

<section role="doc-errata">

Corrections
-----------

It's come to my attention that Eloquence may or may not still belong to Nuance. Further research is needed.
Eloquent Technology was acquired by SpeechWorks in 2000.

</section>


[^1]: See {{<mention-work role="doc-credit" itemtype="DigitalDocument" itemprop="citation">}}{{<cited-work name="Comment Regarding Request for Comments on Intellectual Property Protection for Artificial Intelligence Innovation" url="https://www.uspto.gov/sites/default/files/documents/OpenAI_RFC-84-FR-58141.pdf">}} (<span itemprop="encodingFormat">application/pdf</span>) submitted by <span itemscope="" itemprop="publisher" itemtype="https://schema.org/Organization"><span itemprop="name">OpenAI</span></span> to the <abbr title="United States Patent and Trademark Office">USPTO</abbr>{{</mention-work>}}

[^2]: I doubt anybody worth their salt would count on a company to hold itself accountable, but at least they tried.

[^3]: If the stars align, you could file an anticipatory suit against the company. It's common for [declaratory judgement](https://en.wikipedia.org/wiki/Declaratory_judgement) regarding intellectual property rights.



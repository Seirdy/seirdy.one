---
title: "Stylometric fingerprinting resistance"
date: 2022-06-24T16:16:46-07:00
---
Following the recent SCOTUS ruling, many have been trying to publish resources to help people find reproductive healthcare. They often wish to do this anonymously, to avoid doxxing.

There's no shortage of guides on how to stay anonymous online. I recommend using the Tor Browser in a disposable Whonix VM. [The Whonix Wiki has a good guide to anonymous publishing.](https://www.whonix.org/wiki/Surfing_Posting_Blogging)

Few guides cover [stylometric fingerprinting.](https://en.wikipedia.org/wiki/Stylometry) Stylometric fingerprinting is one of the most common techniques for de-anonymization, used by adversaries ranging from trolls to law enforcement.

Common advice is to use offline machine translation to translate works to and from another language. [Argos Translate](https://www.argosopentech.com/) and [Marian](https://marian-nmt.github.io/) are two options that come to mind.

{{<mention-work itemprop="citation" role="doc-crdit" itemtype="ScholarlyArticle">}}{{<cited-work name="Adversarial stylometry: Circumventing authorship recognition to preserve privacy and anonymity" extraName="headline" url="https://doi.org/10.1145/2382448.2382450">}}{{</mention-work>}} shows that machine translation alone isn't nearly as strong a method as manual approaches: obfuscation (hiding your writing style) or imitation (mimicking another author). These approaches have excellent success rates, even among amateur writers. The aforementioned Whonix wiki page lists common stylometric fingerprinting vectors for manual approaches to address.

Limiting unusual vocabulary and sentence structure make for a good start. Using a comprehensive and highly-opinionated style-guide should also help. <cite>The Economist</cite> has a good one that was specifically written to make all authors sound the same: {{<mention-work itemtype="Book">}}{{<cited-work name="The Economist Style Guide" url="http://cdn.static-economist.com/sites/default/files/pdfs/style_guide_12.pdf">}}, <span itemprop="bookEdition">12th edition</span> (<span itemprop="encodingFormat">application/<wbr />pdf</span>){{</mention-work>}}.

For any inexperienced writers: opinionated offline grammar checkers such as [LanguageTool](https://github.com/languagetool-org/languagetool) and [RedPen](https://github.com/redpen-cc/redpen) may supplement a manual approach by normalizing any distinguishing "errors" in your language, but nothing beats a human editor.

Further reading: {{<mention-work itemtype="Article">}}{{<cited-work name="How we authenticate a document" url="https://www.orphanalytics.com/en/method" extraName="headline">}}, by <span itemscope="" itemprop="publisher" itemtype="https://schema.org/Organization">OrphAnalytics SA</span>.{{</mention-work>}}

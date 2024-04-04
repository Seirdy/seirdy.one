---
title: "MDN’s AI Help and lucid lies"
description: "MDN’s AI Help can’t critically examine training data’s gaps, biases, and unrelated topics. It’s a useful demonstration of LLMs’ uncorrectable lucid lies."
date: 2024-04-04T19:15:54-04:00
replyURI: "https://blog.mozilla.org/en/products/mdn/responsibly-empowering-developers-with-ai-on-mdn/"
replyTitle: "Responsibly empowering developers with AI on MDN"
replyType: "BlogPosting"
replyAuthor: "Steve Teixeira"
replyAuthorURI: "https://mozilla.social/@stevetex"
tags:
    - accessibility
    - AI
outputs:
    - html
    - gemtext
---
<section role="doc-introduction" itemprop="backstory">

## Introduction

Following the release of MDN's AI chatbot "feature", many developers [turned to GitHub Issues to voice concerns](https://github.com/mdn/yari/issues/9230). Most concerns revolved around the chatbot spouting misinformation on a technical reference expected to contain accurate information, and ethical concerns related to OpenAI and the use of a large language model (<abbr>LLM</abbr>).

I don't find the mere existence of LLM dishonesty to be worth blogging about; it's already well-established. Let's instead explore one of the inescapable roots of this dishonesty: LLMs exacerbate biases already present in their training data and fail to distinguish between unrelated concepts, creating lucid lies.[^1]

A <dfn>lucid lie</dfn> is a lie that, unlike a hallucination, can be traced directly to content in training data uncritically absorbed by a large language model. MDN's AI Help is the perfect example.

</section>

## Conflating common and uncommon angles

"AI Help" answers usually apply to the common case at the expense of a less-common case, even when asked about the less-common case. One of many examples is horrible accessibility advice.

### Example: assistive technology performance tips

Ask the chatbot about a performance technique's applicability to assistive technology (<abbr>AT</abbr>), and it'll give you advice on performance related to graphical rendering while passing it off as improving <abbr>AT</abbr> performance. For example: I often work with large <abbr title="Document Object Model">DOM</abbr> sizes, which can be a performance challenge for <abbr>AT</abbr> such as screen- and braille-readers which struggle to handle large accessibility trees.

At one point, I wanted to use `content-visibility` to improve large-<abbr>DOM</abbr> performance. Until later, I didn't realize that its relevance to the accessibility tree was so different from its relevance to rendering performance. Here is one answer to the question <q>I have many <abbr>DOM</abbr> nodes. How can I improve <abbr>AT</abbr> performance using content-visibility?</q>

> To improve accessibility tree (AT) performance using content-visibility, you can utilize the `content-visibility: auto` property. This property allows you to improve page performance without negatively impacting accessibility.
>
> When you apply `content-visibility: auto` to off-screen content, it remains in the document object model (<abbr>DOM</abbr>) and the accessibility tree. This means that the content is still accessible to assistive technologies, but the styles for off-screen content are not rendered. However, it’s important to note that elements intentionally hidden with `display: none` or `visibility: hidden` will still appear in the accessibility tree.
>
> If you want to prevent an element from appearing in the accessibility tree, you can use the `aria-hidden="true"` attribute.
>
> Here’s an example of using `content-visibility: auto` to improve rendering cost for long pages:
>
> ```
> section {
>   content-visibility: auto;
>   contain-intrinsic-size: auto 500px;
> }
> ```
>
> In this example, the section elements have `content-visibility: auto` applied to them. This allows the user agent to skip rendering work (including layout and painting) for off-screen sections until they come close to the viewport. By skipping the rendering work, the initial page load becomes faster, improving performance.<!--`-->
>
> Remember, `content-visibility: auto` helps optimize rendering and layout, but it’s important to ensure that your content remains accessible to all users.

There are multiple inaccuracies present,[^2] but I'll focus on a glaring one:

This response [cites an MDN page that contradicts the given advice](https://developer.mozilla.org/en-US/docs/Web/CSS/content-visibility). While `content-visibility: auto` _does_ improve graphical rendering by deferring off-screen rendering, this has no impact on the accessibility tree: off-screen content is still accessible to <abbr>AT</abbr> (assistive technology, not accessibility tree), find-in-page, etc. Only rendering is deferred.

The assistive technology implications are an afterthought that don't get equal treatment alongside graphical rendering concerns. Regardless of your thoughts on said treatment: here we see that bias amplified, resulting in misinformation and disability erasure.

## Conflating broad and specific questions

Broad questions already tend to have more documentation than specific questions. Trained on this understandably-biased documentation, AI Help tends to fall flat when asked for any overly specific advice.

### Example: asking about specific page speed metrics

It's easier to find generic advice on improving load times than it is to find advice on improving specific _aspects_ of load times. AI Help conflates the two, offering incorrect advice for improving a given metric.

Say you run a page speed benchmark using your favorite website speed test,[^3] and find out that your performance is excellent across the board _except_ for the Time to First Byte (<abbr>TTFB</abbr>). A natural follow-up question would be: <q>How do I reduce my <abbr>TTFB</abbr>?</q>

Let's see how AI Help answers:

> To reduce your page's Time to First Byte (TTFB), which is the time between the browser requesting a page and receiving the first byte of information from the server, you can implement several optimizations. Here are some strategies to improve TTFB:
>
> 1. **Optimize Server Response Time**: Ensure your server responds quickly to requests. This can be achieved by optimizing server-side code, database queries, and server configurations.
>
> 2. **Use a Content Delivery Network (CDN)**: Utilize a CDN to cache and deliver content from servers closer to the user, reducing the physical distance and network latency.
>
> 3. **Enable Compression**: Compress resources like HTML, CSS, and JavaScript using techniques like GZIP or Brotli compression to reduce file sizes and improve transfer speeds.
>
> 4. **Minimize HTTP Requests**: Reduce the number of resources loaded on your page by combining files, using image sprites, and minimizing unnecessary requests.
>
> 5. **Browser Caching**: Implement proper caching headers to allow browsers to store resources locally, reducing the need to fetch them again on subsequent visits.
>
> 6. **Optimize Images**: Compress and optimize images to reduce their file sizes without compromising quality. Consider lazy loading images to defer loading offscreen images.
>
> 7. **Reduce Server-Side Processing**: Minimize server-side processing by caching dynamic content, optimizing database queries, and using efficient algorithms.
>
> By implementing these strategies, you can help reduce your page's TTFB and improve overall performance. For more detailed information and best practices, you can refer to the [Performance best practices](https://developer.mozilla.org/en-US/docs/Web/Performance) documentation on MDN.

In this situation, <abbr title="Time to First Byte">TTFB</abbr> is the bottleneck. Any advice concerning different aspect of page speed optimization would encourage premature optimization. Despite the question specifically asking about <abbr>TTFB</abbr>, we've received plenty of performance advice that has nothing to do with it: A page's <abbr>TTFB</abbr> only describes the time spent waiting for the initial byte of a response. The number of subsequent requests and the size of the requests have no impact on it. Points 3 and 6 are premature optimizations; point 5 is a partial workaround but not really an answer.

## Blurring the lines classifying LLM lies

Sometimes the boundary between specific/general mislabeling, conflation of overlapping topics, and hallucination isn't so clear. Let's look at an example of an LLM blurring the lines between all three.

### Combined example: specific information, conflation, and hallucination.

I did some research before enabling a TLS feature called Zero Round Trip Time (<abbr>0-RTT</abbr>) on my `seirdy.one` domain, to make sure it was safe to do so given [0-RTT's susceptibility to replay attacks](https://www.rfc-editor.org/rfc/rfc8446#appendix-E.5). I moved anything vulnerable to replay attacks to alternate domains.[^4] I wanted to know the answer to the question: <q>What are the security implications of 0-RTT on a static site?</q>

Here's what AI Help had to say:

> 0-RTT (Zero Round Trip Time) is a feature of the Transport Layer Security (TLS) protocol that allows a client to send data to the server in the first message of the TLS handshake, reducing latency. However, there are security implications to consider when using 0-RTT, especially on a static site. When it comes to a static site, where content does not change frequently and interactions are limited, using 0-RTT can introduce potential security risks. Since 0-RTT data is sent before the server's response, it can be replayed by an attacker. This means that if sensitive data is transmitted in the 0-RTT data, it could be intercepted and replayed by an attacker to impersonate the client. To mitigate these security risks on a static site using 0-RTT, it's important to:
>
> 1. Avoid sending sensitive data in 0-RTT messages: Ensure that any data sent in the 0-RTT phase is non-sensitive and does not pose a security risk if intercepted and replayed.
>
> 2. Implement additional security measures: Consider implementing additional security measures such as encryption, authentication mechanisms, and data validation to protect against replay attacks and unauthorized access.
>
> 3. Regularly review and update security practices: Stay informed about the latest security best practices and updates related to 0-RTT and TLS to ensure that your static site remains secure. For more detailed information on 0-RTT and its security implications, you can refer to the [TLS 1.3 specification](https://developer.mozilla.org/en-US/docs/Web/Security/Transport_Layer_Security) on MDN.

This is the most clear-cut lie that MDN's AI Help has told me so far. Simple static sites represent some of the safest uses of 0-RTT, without any extra backend protections: replaying a simple request for a static asset doesn't help an attacker until we introduce other complexities to our backend.

On MDN and the Web in general, advice on 0-RTT tends to be general to all sites, or apply to common CMS platforms; little applies specifically to static sites. MDN gave us generic advice that only applies to a complex CMS when asked specifically about static sites.

This is also partly a hallucination: MDN has no documentation on what a replay attack _is,_ or how to defend against it. AI Help made up vague defenses such as "encryption" and "authentication", even though this is a weakness _in_ authenticated encryption protocols. These are valid defenses on their own, but have nothing to do with the question asked.

An LLM may be able to answer simpler questions, such as:

- <q>What is a static site?</q>
- <q>Are static sites vulnerable to reply attacks?</q>

The ability to answer such questions isn't unique. Asking a chatroom, a forum, or even a simple link-and-summary search engine should pull up useful information.

An LLM cannot be trusted to synthesize different concepts without conflating them, or to switch from broad to specific concepts. Pseudo-hallucinations fill the gap.

<section role="doc-conclusion">

## Conclusion

### Conclusions about MDN's AI Help

I've provided examples of uncommon angles and specific topics that cause MDN's AI Help to lie.

The Mozilla Blog post {{<mention-work itemtype="BlogPosting">}}{{<cited-work name="Responsibly empowering developers with AI on MDN" extraName="headline" url="https://blog.mozilla.org/en/products/mdn/responsibly-empowering-developers-with-ai-on-mdn/">}}{{</mention-work>}} highlighted positive quantitative feedback for AI Help. **Positive perceived helpfulness needs to be multiplied by actual helpfulness** before it's taken into account; in this case, I argue that **actual helpfulness is negative.** A user unfamiliar with `content-visibility` (such as a past version of myself) or <abbr>TTFB</abbr> only reinforces the harmfulness of such a tool by marking these answers as "helpful". The high perceived helpfulness counts against this feature's merit.

Not everything should optimize for engagement. Engagement multiplies harms.

{{<quotation>}}

<blockquote itemprop="text">

A recurring complaint we heard from our readers was that MDN is excellent when you know what to look for. If you don't, it's not easy to discover the information you need...Developers with less experience find it harder to navigate through MDN

</blockquote>
{{< quotecaption partOfType="BlogPosting">}}
{{<cited-work name="Reflections on AI Explain: A postmortem" url="https://developer.mozilla.org/en-US/blog/ai-explain-postmortem/" extraName="headline">}}, by <span itemscope="" itemprop="publisher" itemtype="https://schema.org/Organization"><span itemprop="name">the MDN Team</span></span>
{{< /quotecaption >}}
{{</quotation>}}

If all web development questions were easy to answer by browsing MDN, this tool wouldn't be necessary. Uncommon and specific questions are **the hardest questions to answer without expert assistance.** A tool designed to answer hard questions that is _so likely to fail under these conditions_ is worse than no tool all.

I do like the tool's ability to suggest links to relevant MDN pages. Perhaps it could power improvements to MDN search's result ranking, or suggest keywords for future searches.

### Implications for LLMs as a whole

Some topics get written about more than others. Our society disproportionately incentivizes generic, far-reaching, easy-to-create, and profitable content. I don't think it's currently possible to source nontrivial training data without biases. More importantly: I'm skeptical that such an impossibly comprehensive data set would entirely eliminate the conflations I described in this article. Tripping over bias to fall into a lucid lie is one of a range of symptoms of an inability to actually think.

{{<quotation>}}

<blockquote itemprop="text">

The model, _per se,_ doesn't exist until after the training process is completed, and has no ability to make such decisions at all. It bases its statistical model of language on the entirety of the training data with no discrimination, except maybe a little outlier exclusion.

</blockquote>
{{< quotecaption partOfType="SocialMediaPosting">}}
{{<indieweb-person itemprop="mentions" name="Athena Martin" url="https://alm.website/me">}} in a {{<cited-work name="Fediverse DM">}}
{{< /quotecaption >}}
{{</quotation>}}

Current LLMs can't critically examine training data and its biases. For humans, such critical analysis is often difficult; for machines, it's **currently impossible.** Until we make such a breakthrough, LLMs can never be remotely honest. Nobody should consider deploying an LLM to perform a role that demands significant accountability. Answering questions honestly and accurately demands accountability for dishonest and inaccurate answers, so this responsibility shouldn't be delegated to an LLM. To market an LLM as capable of answering questions reflects dishonesty or ignorance; neither inspires trust. Hallucinations are one thing, but miscategorizing facts due to an inability to critically analyze biases and topic relations in training data is something that no amount of reinforcement learning will fix. These are lucid lies.

This article on AI focused on the inherent untrustworthiness of LLMs. Stay tuned for a follow-up article about AI that focuses on data-scraping and the theory of labor. It'll examine what makes many forms of generative AI ethically problematic, and the constraints employed by more ethical forms. I'll edit this paragraph with a link to the follow-up post when it's ready.

</section>

<section role="doc-acknowledgments">

## Ack&shy;nowledge&shy;ments {#acknowledgements}

Thanks to {{<indieweb-person itemprop="mentions" name="Athena Martin" url="https://alm.website/me">}} for providing feedback on an initial draft. She helped me better communicate the idea that LLMs are statistical models, not thinking machines. With her permission, I borrowed a quote from her feedback to use in my conclusion.

Thanks to {{<indieweb-person itemprop="mentions" name="Emily" url="https://uni.horse/">}} for highlighting that biased data shouldn't be depicted as the root of the issue; the issue is an LLM's inability to think. I agreed, and reworded (and re-titled) much of this article in response.

</section>


[^1]: I use the term "lie" instead of hallucination because it's broad. A hallucination is merely one type of lie. LLMs may lie in any way a human can. Lies by omission are the first non-hallucinatory lie that comes to mind. I exhausted other terms: calling them "misunderstandings" implies that LLMs have the capacity to understand things; calling them "bugs" implies that this is due to a programming error; calling them "accidents" implies that this isn't expected behavior (this article shows why it should be). Telling a lie does not require understanding; repeating one does not require intent.

[^2]: Another inaccuracy: while it's not standard behavior, many browsers do exclude content from the accessibility tree in response to certain `display` properties, including `display: none`. {{<mention-work itemtype="BlogPosting" itemprop="citation">}}{{<cited-work url="https://adrianroselli.com/2022/07/its-mid-2022-and-browsers-mostly-safari-still-break-accessibility-via-display-properties.html" name="It’s Mid-2022 and Browsers (Mostly Safari) Still Break Accessibility via Display Properties" extraName="headline">}} by {{<indieweb-person first-name="Adrian" last-name="Roselli" url="https://adrianroselli.com/" itemprop="author">}}{{</mention-work>}} covers this in more detail.

[^3]: I recommend Chromium's Lighthouse for simple measurements, and the Firefox Performance Monitor for detailed analysis. Plenty of tools exist between those extremes.

[^4]: This included my Webmention collector and my CSP-report collector (only used on my staging site and a dedicated CSP debugging page), which I moved to `collector.seirdy.one`. All that's left here is a static site, Libravatar endpoint (implemented in Nginx configs), single-user WebFinger endpoint (implemented with Nginx configs), Webmention endpoint, and a not-so-secret DNS resolver)



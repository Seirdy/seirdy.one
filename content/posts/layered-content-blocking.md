---
date: 2022-06-04T22:47:00-07:00
title: "A layered approach to content blocking"
description: "My take on where Manifest V3 fits into the current ad-blocking landscape: it has some benefits which should complement but not replace existing approaches"
outputs:
    - html
    - gemtext
footnote_heading: Notes
---
The Chromium team is planning on phasing out Manifest V2, its current set of extension APIs, in favor of Manifest V3. [Manifest V3](https://developer.chrome.com/docs/extensions/mv3/intro/) involves giving extensions less access to page contents. Instead, extensions use new APIs that involve giving the browser simple instructions for page modification. The browser performs those instructions using its own logic; extensions themselves can't access page contents.

This represents a tremendous trade-off: extensions need to be trusted less, but are also less capable. The implications for content blockers (ad-blockers) caused significant backlash.[^1] Mozilla plans on adopting Manifest V3 in Firefox with additional APIs to re-introduce the lost functionality. Discourse on the topic has been polarized, full of oversimplification, and devoid of nuance.

My views on the situation are a bit complicated.

The existing content filtering landscape
----------------------------------------

[uBlock Origin](https://github.com/gorhill/uBlock)[^2] has advanced content filters, with the ability to inject near-arbitrary stylesheets and a number of scripts into pages. Injecting scripts and stylesheets is often necessary to bypass malicious "anti-adblock" scripts or to skip certain types of video ads on streaming platforms. Unfortunately, this presents a security risk: users must trust every filter to not inject malicious stylesheets. Furthermore, sometimes these extensions don't run their filters "in time"; a delay in running a filter could allow unwanted content to sneak through. This is especially common during browser launch. Nonetheless, its functionality makes the user-hostile Web considerably less frustrating, and I rely on it every day.

Chromium's Manifest v3 includes the `declarativeNetRequest` API, which delegates these functions to the browser rather than the extension. Doing so avoids the timing issues visible in privileged extensions and does not require giving the extension access to the page. While these filters are more reliable and improve privilege separation, they are also substantially weaker. You can say goodbye to more advanced "anti-adblock" circumvention techniques.

Hostname or IP-based based network filtering is the least capable but most reliable approach. Filters are limited to domain names (i.e. you can't block individual paths from a domain or make cosmetic filters), and they run unconditionally and globally. However, they don't introduce nearly the same attack surface as other methods. When combined with CNAME-uncloaking, they're quite effective at what (little) they do. The best part is that they carry little to no overhead; these lists can scale to millions of domains if applied on the DNS level.

Context: extension permissions systems
--------------------------------------

Firefox allows extensions to declare their own permissions. Extensions decide which sites they can run on and when, with required and optional permissions.

Chromium has a similar system with additional functionality: users can choose to enable an extension only when clicked, only for a certain site, or for all sites globally. Safari takes this a step further and also offers the choice to enable an extension for a limited time period (one day).

On Firefox, users of an extension like Stylus[^3] would need to grant the extension access to every page. On Chromium, users only need to grant it access to the subset of pages they need to theme.

A layered approach to content filtering
---------------------------------------

I think content filtering should follow a layered approach. It can have three layers:


<dfn>Coarse network filters</dfn>
: These can be DNS- or IP-based filters that run globally. They can be applied to an entire network, a device, and/or a given network namespace.

<dfn>Declarative filters</dfn>
: Simple content-blocking rules that are parsed and enforced by the user-agent. These filters can be restricted to safe blocking rules that don't inject content into pages.

<dfn>Privileged extensions</dfn>
: The most powerful and most risky types of page alteration, containing Turing-complete logic. These can make arbitrary page alterations, edit cookie contents, inject scripts and stylesheets, and re-write request URLs. These extensions can alter a page's Content Security Policy to allow running injected scripts.

DNS- or IP-based filters can run system-wide, and be limited to safe filters that are unlikely to trigger site breakages. Atop these filters, browsers can globally enable extensions that use declarative filters. A browser could be configured to ignore global hostname or IP filters that are already covered by the aforementioned system-wide filters; doing so could improve performance when users enable a high number of filters.

Users can then choose to selectively enable a privileged extension (such as uBlock Origin) only on sites that continue to misbehave, using something resembling Chromium's extension permission system. Privileged extensions can perform any functionality not covered by the previous two layers. Selectively enabling them significantly reduces attack surface without crippling the ability to modify content.

### The safe layers: network and declarative filters

Say a user visits a typical site containing JavaScript and/or WebAssembly, some of which is malicious.[^4] System-wide network filters can block domains serving third-party malware, such as Google Ads or Google Analytics. Overly security conscious users can use built-in browser functionality to block cookies and scripts by default, and enable them on a site-by-site basis.[^5]

A user might need to enable these scripts, or some malware might sneak through coarse network filters as first-party content. The site may contain other pure HTML- and CSS-based annoyances like "sign up" modals, cookie notices, sticky headers, [dickbars](https://daringfireball.net/linked/2011/03/06/dickbar), etc. Declarative filters serve as a second layer of defense to handle these.

### The advanced layer: privileged extensions

The final layer is advanced page alteration. Anti-adblock software is the most common offender, but other examples exist.

A page may use a single blob of JavaScript that contains both malware and essential functionality. Simply blocking the script will break the page, but allowing it would cause a user's device to perform an unwanted action. It's unreasonable to expect users to reverse-engineer every obfuscated script they come across; plenty would appreciate some sort of automatic filtering.

Maybe the page contains a JavaScript video player with auto-playing media, and the user wants to block auto-playing videos conditionally. The user might have enabled auto-playing videos for the site's "videos" section but wish to disable auto-playing for its "articles" section.

An extension that can access the page, inject its content, and use complex logic to alter the page can fix these problems. It could replace a malicious script with an alternative that provides the necessary functionality while stubbing off malicious functionality, alter cookies that power paywalls triggered after a given number of "articles read", or change video player states based on the video's metadata.

One example I find particularly interesting: a friend of mine has been working on an extension to only load animated GIFs conditionally. Some animated GIFs are fine, but others contain flashing colors that we consider to be overstimulating.[^6] The extension would disable auto-playing GIFs and inspect each one. After inspecting a GIF, it would animate it if consecutive frames fall below a given contrast ratio.

Several more examples are available in [uBlock Origin's resource library](https://github.com/gorhill/uBlock/wiki/Resources-Library). Much of this functionality would be unavailable to Manifest V3 extensions in Chromium.

Frequently-asked questions {#frequently-asked-questions}
--------------------------

I'll update this section as I collect feedback. Watch this space.


<q>Malicious extensions can still request permission to read the contents of the page. What have you done differently besides adding new APIs?</q>
: The difference is that these malicious extensions will require the extra permission to access your data for all websites, while extensions using declarative APIs will not. Security-conscious users can keep that fact in mind. However, we shouldn't speak for other users with different priorities.

	I imagine that [an opinionated security-focused browser](https://web.archive.org/web/20220607001654/https://hexavalent.org/) could make it possible for users to enable privileged extensions only on a site-by-site basis, for those interested <ins>(Update: Hexavalent has been discontinued)</ins>. Personally, I think that it's probably best to limit scriptlet injection to signed scripts.[^7]

  Another difference is that while declarative filtering does have reduced functionality, it's also more effective in some ways. Declarative filters generally have a lower footprint and are less likely to experience the delayed execution that lets some unwanted content slip through.

<q>If we trust our extension developers, is any of this really necessary?</q>
: With adblockers, you don't just trust extension developers; you also trust filter-list contributors. Many filter lists have thousands of entries aggregated from other filter lists, so trust-by-proxy ends up covering a lot of ground. This also applies to userstyle extensions: you have to trust the authors of each theme.

  CSS injection is a powerful tool that can be used well or maliciously. Remember that its contributors and extension developers could be well-meaning but still allow a vulnerability to slip through, especially when you account for extensions that alter a site's CSP.

  I still use these privileged extensions, but I try to limit their scope to sites where they're necessary.

Conclusion
----------

**I don't think Manifest V3 can replace Manifest V2's privileged extensions,** and **I don't think existing APIs should be removed without replacement.** However, that doesn't mean V3's APIs can't be useful. While its scope is smaller, its blocking is safer and more reliable. Declarative approaches work well as a complement to other content-blocking techniques in a layered approach to content blocking. I felt the need to write up my thoughts because they didn't fit in with the current polarized discourse around content blocking.

Rather than using a single tool to perform all content filtering, we should try moving towards a layered approach. Each type of filter should be delegated to the tool best suited for the task. Users should have control over the scope of each layer.

<!--
	Topics I should probably mention for completeness:
	- TLS terminating proxies that alter content
	- corporate firewalls that block domains
	- Maaaaybe make analogy that compares "dark mode" extensions with forced-colors (Firefox browser feature, Windows system-wide feature inc. browsers (High Contrast Mode). forced colors is like the declarative approach and much more "effective" and doesn't require granting extra access but also more coarse/less advanced. I'm worried I'll get sidetracked tho :|
-->


[^1]: I can already hear adtech-defenders typing a response that explains why choosing how to render downloaded content is problematic or unethical.

    Users don't know the contents of a resource before fetching it, so they can't provide meaningful consent to any malicious behavior in said contents (e.g. tracking). Content providers must therefore respect user control over downloaded content if such networks are to function.

    I start from the notion that when a user downloads a document, they are entitled to do what they wish with it. If it's broken or malicious, they should be able to fix it. When it comes to accessibility---especially regarding cognitive accessibility for ADHD and anxiety disorders---content blocking isn't always optional.

    Browsers don't download a rendered page; they download source code. It's up to the user agent to choose if or how that code renders. As long as users can control their means to browse the web, content "alteration" is a part of the package.

[^2]: Not to be confused with the [unrelated extension called "uBlock"](https://github.com/gorhill/uBlock/wiki/uBlock-Origin-is-completely-unrelated-to-the-web-site-ublock.org).

[^3]: Stylus is an extension that allows injecting special stylesheets (called "userstyles") into pages to change their appearance. Stylesheets can be applied to specific pages, pages matching a pattern, or globally.

[^4]: I use the term "malicious" loosely here. These scripts could perform tracking without prior informed consent or attempt to distract the user with ads, both of which are malicious.

[^5]: Chromium offers this functionality. If users choose to block all cookies, it exposes controls to allow cookies for the current site that last for the current session or persist until they expire. It offers a similar site-specific toggle for JavaScript. As far as I am aware, Firefox does not expose controls for managing these permissions on the current page: users need to open the preferences page every time they wish to add such a rule, or use a privileged extension.

[^6]: Animated custom emotes are a common offender, especially when a post contains several consecutive ones.

[^7]: One point of controversy is that major browsers only allow extensions signed by the browser vendor's key. I think this is a legitimate concern, best solved by allowing users to easily specify an alternative signing key and sign extensions themselves.



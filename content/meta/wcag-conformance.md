---
outputs:
    - html
title: "Details on WCAG 2.2 conformance"
description: "Every WCAG 2.2 success criterion, and how seirdy.one achieves it. I list techniques I used and areas for improvement. This page is a work in progress."
date: "2022-07-11T16:13:00-07:00"
evergreen: true
---
I made full conformance with the AA level and partial conformance with AAA a goal in my site's accessibility statement.

I use the following abbreviations:


SC
: Success criterion. A requirement listed in the WCAG.

ST
: Sufficient technique; a technique that meets a given success criterion.

{{<toc>}}

Principle 1: Perceivable
------------------------

### Guideline 1.1: Text Alternatives


[SC 1.1.1: Non-Text Content](https://w3c.github.io/wcag/understanding/non-text-content.html)
: All non-text content on my site has a text alternative. Images have alt-text ([ST H37](https://w3c.github.io/wcag/techniques/html/H37)). I provide image and audio transcripts using `aria-describedby` when relevant ([ST ARIA15](https://w3c.github.io/wcag/techniques/aria/ARIA15) and [ST G74](https://w3c.github.io/wcag/techniques/general/G74)). Form controls have `<label>` elements ([ST H44](https://w3c.github.io/wcag/techniques/html/H44)). This covers SC 1.1.1's situations A, B, C, and D. Situation E is irrelevant, as my site has no CAPTCHAs. For situation F: I hide my avatar using null alt-text ([ST H67](https://w3c.github.io/wcag/techniques/html/H67)) and use `aria-hidden` on one instance of decorative emoji.

### Guideline 1.2: Time-based Media


[SC 1.2.1: Audio-only and Video-only (Prerecorded)](https://w3c.github.io/wcag/understanding/audio-only-and-video-only-prerecorded.html)
: My site doesn't have any video, but does feature one `<audio>` element. The `<audio>` element has a full transcript and information on how it was created ([ST G158](https://w3c.github.io/wcag/techniques/general/G158)).

[SC 1.2.2: Captions (Prerecorded)](https://w3c.github.io/wcag/understanding/captions-prerecorded.html)
: This SC is only applicable to synchronized media, which is not present on this site.

[SC 1.2.3: Audio Description or Media Alternative (Prerecorded)](https://w3c.github.io/wcag/understanding/audio-description-or-media-alternative-prerecorded.html)
: I provide an alternative for time-based media in the form of a full audio transcript. There is no video content on this site.

[SC 1.2.4: Captions (Live)](https://w3c.github.io/wcag/understanding/captions-live.html) OR [SC 1.2.9: Audio-only (Live)](https://w3c.github.io/wcag/understanding/audio-only-live.html)
: These criteria are only applicable to live media. There is no live media on this site.

[SC 1.2.5: Audio Description (Prerecorded)](https://w3c.github.io/wcag/understanding/audio-description-prerecorded.html) OR [SC 1.2.7 Extended Audio Description (Prerecorded)](https://w3c.github.io/wcag/understanding/extended-audio-description-prerecorded.html)
: These criteria are only applicable to prerecorded video in synchronized media, which is not present on this site.

[SC 1.2.6: Sign Language (Prerecorded)](https://w3c.github.io/wcag/understanding/sign-language-prerecorded.html)
: This SC is only applicable to synchronized media, which is not present on this site. However, I think it should apply to audio-only tracks too. The only `<audio>` element on this site is a text-to-speech recording intended to demonstrate what a certain speech synthesizer sounds like, rendering the WCAG's stated benefits of sign language interpretation moot (<q cite="https://w3c.github.io/wcag/understanding/sign-language-prerecorded.html#intent">the ability to provide intonation, emotion and other audio information that is reflected in sign language interpretation, but not in captions</q>).

[SC 1.2.8: Media Alternative (Prerecorded)](https://w3c.github.io/wcag/understanding/media-alternative-prerecorded.html)
: As mentioned for SC 1.2.1, I provide both a full transcript and short description for an `<audio>` element. I also link a page containing the text of the audio. There is no video on this site.

### Guideline 1.3: Adaptable


[SC 1.3.1: Info and Relationships](https://w3c.github.io/wcag/understanding/info-and-relationships.html)
: I've made extensive efforts to meet this SC. I use `aria-labelledby` and/or headings to label sections ([ST ARIA11](https://w3c.github.io/wcag/techniques/aria/ARIA11), [ST H42](https://w3c.github.io/wcag/techniques/html/H42)), and always use semantic elements where appropriate:
  - [ST G115: Using semantic elements to mark up structure](https://w3c.github.io/wcag/techniques/general/G115)
  - [ST H49: Using semantic markup to mark emphasized or special text](https://w3c.github.io/wcag/techniques/html/H49)
  - [ST H44: Using label elements to associate text labels with form controls](https://w3c.github.io/wcag/techniques/html/H44)
  - [ST H71: Providing a description for groups of form controls using fieldset and legend elements](https://w3c.github.io/wcag/techniques/html/H71)
  - [ST H48: Using `ol`, `ul` and `dl` for lists or groups of links](https://w3c.github.io/wcag/techniques/html/H48)
  - [ST H97: Grouping related links using the `nav` element](https://w3c.github.io/wcag/techniques/html/H97)

[SC 1.3.2: Meaningful Sequence](https://w3c.github.io/wcag/understanding/meaningful-sequence.html)
: Every page on this site follows a single-column layout that flows top-to-bottom, left-to-right. The source, DOM, and visual orders are all identical ([ST C27](https://w3c.github.io/wcag/techniques/css/C27)). I regularly test my pages without CSS to ensure that the order of the content remains logical (this passes [ST G57's testing procedure](https://w3c.github.io/wcag/techniques/general/G57#tests)).

[SC 1.3.3: Sensory Characteristics](https://w3c.github.io/wcag/understanding/sensory-characteristics.html)
: When possible, I convey information semantically. If that's ever impossible, I use text. I never refer to parts of a page spatially (e.g. "the section above") when I can instead refer to the parts sequentially ("the previous section"). The testing procedure used to comply with SC 1.3.2 applies here as well. Any items requiring sensory information (audio, images, etc.) also have textual alternatives ([ST G96](https://w3c.github.io/wcag/techniques/general/G96)).

[SC 1.3.4: Orientation](https://w3c.github.io/wcag/understanding/orientation.html)
: No content on this site restricts orientation.

[SC 1.3.5: Identify Input Purpose](https://w3c.github.io/wcag/understanding/identify-input-purpose.html)
: I use `autocomplete` attributes wherever appropriate ([ST H98](https://w3c.github.io/wcag/techniques/html/H98)), and use `type` attributes to specify acceptable values.

[SC 1.3.6: Identify Purpose](https://w3c.github.io/wcag/understanding/identify-purpose.html)
: This site uses no icons; all interactive elements are represented textually. I use WAI-ARIA ([ST ARIA11](https://w3c.github.io/wcag/techniques/aria/ARIA11)) and DPUB-ARIA to identify sections of a page, and I use microdata with schema.org vocabulary (I'm not sure if any assistive technologies actually use microdata, but it's a part of WCAG for some reason). Required inputs receive a `required` attribute; SC 1.3.6 describes use of the older `aria-required` attribute as an advisory technique.

### Guideline 1.4: Distinguishable


[SC 1.4.1: Use of Color](https://w3c.github.io/wcag/understanding/use-of-color.html)
: I do not set any custom colors for the default stylesheet. Users who opt into a dark palette by broadcasting a `dark` preference to the `prefers-color-scheme` media query will get custom colors which map directly onto an element's semantics.

[SC 1.4.2: Audio control](https://w3c.github.io/wcag/understanding/audio-control.html)
: Absolutely no auto-playing media of any kind is present on this site.

[SC 1.4.3: Contrast (minimum)](https://w3c.github.io/wcag/understanding/contrast-minimum.html) OR [SC 1.4.6: Contrast (enhanced)](https://w3c.github.io/wcag/understanding/contrast-enhanced.html)
: I use the Accessible Perceptual Contrast Algorithm (APCA) to measure contrast, and I ensure that all elements meet or gently surpass acceptable contrast ratios for their size at AAA-equivalent levels. I also pass these criteria using the legacy WCAG contrast algorithm.

[SC 1.4.4: Resize Text](https://w3c.github.io/wcag/understanding/resize-text.html)
: With the exception of borders and certain margins, I only use relative units in my stylesheets by using `em` units ([ST C28](https://w3c.github.io/wcag/techniques/css/C28)) or percent ([ST C12](https://w3c.github.io/wcag/techniques/css/C12)). Zoom works well up to 200% at well below this SC's minimum page width, for both standard zoom and zooming text only ([ST G179](https://w3c.github.io/wcag/techniques/general/G179)). When setting the content widths of article bodies with `em`, I still ensure that the average line length is 80 characters or shorter ([Advisory technique C20](https://w3c.github.io/wcag/techniques/css/C20)).

[SC 1.4.5: Images of Text](https://w3c.github.io/wcag/understanding/images-of-text.html) OR [SC 1.4.9: Images of Text (no exception)](https://w3c.github.io/wcag/understanding/images-of-text-no-exception.html)
: I only include images of text when the visual presentation of the text is what I wish to convey (i.e., it meets the requirements for being "essential"). If the text content in the image is at all significant, I include a full transcript that's semantically linked to the image using `aria-describedby` ([ST G140](https://w3c.github.io/wcag/techniques/general/G140)).

[SC 1.4.7: Low or No Background Audio](https://w3c.github.io/wcag/understanding/low-or-no-background-audio.html)
: The only audio present on this site contains no background audio.

[SC 1.4.8: Visual Presentation](https://w3c.github.io/wcag/understanding/visual-presentation.html)
: Users can opt into a dark color palette using the `prefers-color-scheme` media feature; otherwise, all colors are specified by the user-agent's default stylesheets ([ST G148](https://w3c.github.io/wcag/techniques/general/G148)). The dark color palette only specifies a single background color for the entire document, and may eventually specify higher-contrast background colors for elements with small text (e.g. superscripts). Rather than use background colors to delineate regions, I use borders and white space ([ST C25](https://w3c.github.io/wcag/techniques/css/C25)).
: I use relative measurements to ensure that the average line-length is 80 characters or less for long body text ([ST C20](https://w3c.github.io/wcag/techniques/css/C20))
: I do not use justified text anywhere on this site; all text alignment is done according to the user-agent's default stylesheet.
: I specify a line-spacing of 1.5 in CSS ([ST C21](https://w3c.github.io/wcag/techniques/css/C21))
: I use liquid layout ([ST G146](https://w3c.github.io/wcag/techniques/general/G146)) with percent font sizes ([ST C12](https://w3c.github.io/wcag/techniques/css/C12)). I only specify one base font size for the page; all elements obey that scale-factor according to the user-agent's stylesheet.

[SC 1.4.10: Reflow](https://w3c.github.io/wcag/understanding/reflow.html)
: I surpass this requirement by a wide margin (pun intended). A viewport width of under 240&nbsp;px (typically much less) should not trigger horizontal scrolling. 240&nbsp;px is the typical width of a smart feature phone running KaiOS. Any content that must be wider is confined to a single horizontally-scrollable block (e.g. `<pre>` elements), so that users can switch between horizontal and vertical scrolling without having to resort to two-dimensional scrolling for the entire document. All content is single-column on any viewport.

[SC 1.4.11: Non-text Contrast](https://w3c.github.io/wcag/understanding/non-text-contrast.html)
: I supply a focus indicator with excellent contrast ([ST G195](https://w3c.github.io/wcag/techniques/general/G195)) and give all graphics a border, should their background colors blend into the page background. Borders follow guidelines for non-text contrast. Any graphic containing text that must be read also has a transcript available.

[SC 1.4.12: Text Spacing](https://w3c.github.io/wcag/understanding/text-spacing.html)
: My entire stylesheet is optional, and overrides of anything related to the forms of spacing or sizing covered by the SC should not cause any issues. Furthermore, I set line spacing to 1.5 using CSS ([ST C21](https://w3c.github.io/wcag/techniques/css/C21)). I do not set word, letter, and paragraph spacing; these are all set by the user-agent.

[SC 1.4.13: Content on Hover or Focus](https://w3c.github.io/wcag/understanding/content-on-hover-or-focus.html)
: The only content available on hover is content exposed by a `title` attribute. I ensure that this content is not made exclusively available through the `title` attribute; it must also be visible in the surrounding text, or previously in the document. Moreover: content exposed by the `title` attribute is actually an exception listed by this SC, so I pass.

Principle 2: Operable
---------------------

I fully pass all guidelines under Principle 2 at the A and AA levels. SC 2.4.9 Link Purpose (link only) (AAA) is an ongoing work-in-progress, but should be mostly met. I pass all other AAA-level criteria.

### Guideline 2.1: Keyboard Accessible


[SC 2.1.1: Keyboard](https://w3c.github.io/wcag/understanding/keyboard.html) OR [SC 2.1.3: Keyboard (No exception)](https://w3c.github.io/wcag/understanding/keyboard-no-exception.html)
: I don't use any scripts, only vanilla HTML elements and their built-in functionality ([ST H91](https://w3c.github.io/wcag/techniques/html/H91)). Additionally, I ensure that non-interactive but horizontally-scrollable elements are focusable, such as `<pre>` elements.

[SC 2.1.2: No Keyboard Trap](https://w3c.github.io/wcag/understanding/no-keyboard-trap.html)
: Nothing on this site can trigger a keyboard trap in a compliant browser, as I only use vanilla (X)HTML elements.

[SC 2.1.4: Character Key Shortcuts](https://w3c.github.io/wcag/understanding/character-key-shortcuts.html)
: I do not implement any custom keyboard shortcuts for this site (I don't use scripts or access keys), so I pass this SC.

### Guideline 2.2: Enough Time


[SC 2.2.1: Timing Adjustable](https://w3c.github.io/wcag/understanding/timing-adjustable.html) OR [SC 2.2.3: No Timing](https://w3c.github.io/wcag/understanding/no-timing.html)
: No elements except an `<audio>` element have timing. The `<audio>` element uses browser-native controls; these should include speed adjustments and a mechanism to play, pause, and re-wind.

[SC 2.2.2: Pause, Stop, Hide](https://w3c.github.io/wcag/understanding/pause-stop-hide.html) OR [SC 2.2.4: Interruptions](https://w3c.github.io/wcag/understanding/interruptions.html)
: My site has no elements that automatically move, blink, scroll, auto-update, or interrupt the user.

[SC 2.2.5: Re-authenticating](https://w3c.github.io/wcag/understanding/re-authenticating.html) OR [SC 2.2.6: Timeouts](https://w3c.github.io/wcag/understanding/timeouts.html)
: No authentication is required to use public-facing portions of this site. All requests are idempotent, deterministic, and require no client authorization; there's naturally no reason for timeouts.

### Guideline 2.3 Seizures and Physical Reactions

There is absolutely no animation or flashing content on any of my pages, save for browser-native progress-bars in `<audio>` elements or scrolling. Both of these follow user defaults. I pass all three SC for this guideline.

### Guideline 2.4: Navigable


[SC 2.4.1: Bypass Blocks](https://w3c.github.io/wcag/understanding/bypass-blocks.html)
: I use navigation landmarks and headings to bypass blocks. This includes [ST ARIA11](https://w3c.github.io/wcag/techniques/aria/ARIA11) and [ST H69](https://w3c.github.io/wcag/techniques/html/H69). I also follow advisory techniques [C6: Positioning content based on structural markup](https://w3c.github.io/wcag/techniques/css/C6) and [H97: Grouping related links using the nav element](https://w3c.github.io/wcag/techniques/html/H97). Later, I also adopted [ST G1](https://w3c.github.io/wcag/techniques/general/G1) by adding a skip-link to jump to the main content

[SC 2.4.2: Page Titled](https://w3c.github.io/wcag/understanding/page-titled.html)
: All pages use the `title` element ([ST H25](https://w3c.github.io/wcag/techniques/html/H25)). I regularly crawl my entire site with HTML-Proofer, which should automatically flag any exceptions.

[SC 2.4.3: Focus Order](https://w3c.github.io/wcag/understanding/focus-order.html)
: I adopt [ST C27](https://w3c.github.io/wcag/techniques/css/C27): my source, visual, and DOM order are identical (assuming you read top-to-bottom, left-to-right)

[SC 2.4.4: Link Purpose (in context)](https://w3c.github.io/wcag/understanding/link-purpose-in-context.html) OR [SC 2.4.9: Link Purpose (link only)](https://w3c.github.io/wcag/understanding/link-purpose-link-only.html)
: I'm not aware of any ambiguous link names in context; I'm open to hearing about exceptions. I try to make links comprehensible without context; this is a work-in-progress. SC 2.4.4 is met, though.

[SC 2.4.5: Multiple Ways](https://w3c.github.io/wcag/understanding/multiple-ways.html)
: Pages can be reached through the search bar in the footer of every page ([ST G161](https://w3c.github.io/wcag/techniques/general/G161)), and either my archive pages (navbar links: "articles", "notes", "about", "meta") listing all subpages ([ST G126](https://w3c.github.io/wcag/techniques/general/G126) I think?), or by following in-page links on other pages ([ST G125](https://w3c.github.io/wcag/techniques/general/G125)). Additionally, all posts and notes also have a link to the next and previous post in the current section, which is recommended by [IndieMark's Level 2 navigation](https://indieweb.org/IndieMark#Level_2_navigation).

[SC 2.4.6: Headings and Labels](https://w3c.github.io/wcag/understanding/headings-and-labels.html)
: I use sufficient techniques G130 and G131. I generally prefer using `aria-labelledby` over `aria-label` because the latter doesn't translate well using machine-translation, and because I _usually_ want assistive technologies to report content that's similar to what sighted users see.

[SC 2.4.7: Focus Visible](https://w3c.github.io/wcag/understanding/focus-visible.html)
: All focus indicators are visible, using either [ST C15](https://w3c.github.io/wcag/techniques/css/C15) or [ST G165](https://w3c.github.io/wcag/techniques/general/G165).

[SC 2.4.8: Location](https://w3c.github.io/wcag/understanding/location.html)
: I make correct use of `aria-current` in the global navigation. For subpages of each section listed in the global navigation, I emphasize the relevant section by making it a `<strong>` element. This represents [sufficient technique G128](https://w3c.github.io/wcag/techniques/general/G128). I also added breadcrumbs to any pages that aren't directly linked by the navbar, with the final breadcrumb receiving an `aria-current` (sufficient [technique G65](https://w3c.github.io/wcag/techniques/general/G65)). Each page now includes a `<nav>` element that illustrates how to reach it from the global navigation bar.

[SC 2.4.10: Section Headings](https://w3c.github.io/wcag/understanding/section-headings.html)
: All sections have headings. No heading levels are skipped. Automated checkers will flag any exceptions: I regularly crawl my entire site with both axe-core and IBM Equal Access Checker.

[SC 2.4.11: Focus Appearance](https://w3c.github.io/wcag/understanding/focus-appearance.html)
: All focus indicators are either the platform defaults, or are solid 3px outlines that meet WCAG AAA contrast ratios and sufficient AAA-equivalent APCA contrast ratios. Techniques are the same as those listed for SC 2.4.7.

[SC 2.4.12: Focus Not Obscured (minimum)](https://w3c.github.io/wcag/understanding/focus-not-obscured-minimum.html) OR [SC 2.4.13: Focus Not Obscured (enhanced)](https://w3c.github.io/wcag/understanding/focus-not-obscured-enhanced.html)
: Absolutely no focus indicators on this site should overlap in a compliant browser.

[SC 2.4.14: Page Break Navigation](https://w3c.github.io/wcag/understanding/page-break-navigation.html)
: Not applicable; I do not have any page breaks.

### Guideline 2.5: Input Modalities


[SC 2.5.1: Pointer Gestures](https://w3c.github.io/wcag/understanding/pointer-gestures.html)
: Nothing on my site requires multipoint or path-based gestures.

[SC 2.5.2: Pointer cancellation](https://w3c.github.io/wcag/understanding/pointer-cancellation.html)
: I only use native controls ([ST G212](https://w3c.github.io/wcag/techniques/general/G212)), so functionality is only triggered on an up-event in compliant browsers. Furthermore, the only possible client-side change caused by a user action is navigation; browser functionality (e.g. the "back" button) can cancel this.

[SC 2.5.3: Label in Name](https://w3c.github.io/wcag/understanding/label-in-name.html)
: All my accessible names are either equivalent to the visual labels ([ST G211](https://w3c.github.io/wcag/techniques/general/G211)), or start with the visual labels ([ST G208](https://w3c.github.io/wcag/techniques/general/G208)). For instance: Goldmark (the Markdown-to-HTML renderer used by my static-site generator, Hugo) renders footnote backlinks using a Unicode arrow. I've replaced these with a visual label that reads <samp>Back</samp>, and an accessible name that reads <samp>Back to reference <var>N</var></samp>. The SiteImprove Accessibility Checker is able to catch violations of this success criterion automatically.

[SC 2.5.4: Motion Actuation](https://w3c.github.io/wcag/understanding/motion-actuation.html)
: My site has no motion-actuation events. Any motion actuation changes (e.g. changing device orientation) are provided and configured by the operating system.

[SC 2.5.5: Target Size (Enhanced)](https://w3c.github.io/wcag/understanding/target-size-enhanced.html) OR [SC 2.5.8: Target Size (Minimum)](https://w3c.github.io/wcag/understanding/target-size-minimum.html)
: I exceed both of these criteria by instead following Google's more aggressive tap-target recommendations: all tap targets that are not part of body text should be at least 48-by-48&nbsp;px, and not overlap any other tap targets within a 56-by-56&nbsp;px region. Section permalinks, navigation links, links in description-list described terms, footnote backlinks, etc. all meet these requirements. Lighthouse's "SEO" audits can automatically flag a small subset of violations.

[SC 2.5.6: Concurrent Input Mechanisms](https://w3c.github.io/wcag/understanding/concurrent-input-mechanisms.html)
: I do not restrict any input modalities, as I use only native elements and do not use any scripts.

[SC 2.5.7: Dragging Movements](https://w3c.github.io/wcag/understanding/dragging-movements.html)
: All elements on my site have the user-agent's supplied draggability properties (or lack thereof). Compliant browsers should pass this criterion.

Principle 3: Understandable
---------------------------

I fail SC 3.1.5 Reading Level (AAA) and SC 3.1.6 Pronunciation (AAA).

### Guideline 3.1: Readable


[SC 3.1.1: Language of Page](https://w3c.github.io/wcag/understanding/language-of-page.html)
: I declare the language of each page using the `lang` attribute on the `<html>` element ([ST H57](https://w3c.github.io/wcag/techniques/html/H57)).

[SC 3.1.2: Language of Parts](https://w3c.github.io/wcag/understanding/language-of-parts.html)
: There are currently no parts of any pages on this site that contain a language that differs from the document languages. Should this change, I would use the HTML `lang` attribute.

[SC 3.1.3: Unusual Words](https://w3c.github.io/wcag/understanding/unusual-words.html)
: I define unusual words in the surrounding text ([ST G101](https://w3c.github.io/wcag/techniques/general/G101)). For more substantial definitions, I use a `<dl>` and/or `<dfn>` element ([ST H40](https://w3c.github.io/wcag/techniques/html/H40), [ST H54](https://w3c.github.io/wcag/techniques/html/H54)); for simpler definitions, I just us a parenthetical ([ST G112](https://w3c.github.io/wcag/techniques/general/G112)); this is especially common for abbreviations. Sometimes, I link to a page that explains the word's meaning (e.g. a Wikipedia article) ([ST G55](https://w3c.github.io/wcag/techniques/general/G55)).

[SC 3.1.4: Abbreviations](https://w3c.github.io/wcag/understanding/abbreviations.html)
: I typically introduce an abbreviation using the `<abbr>` element ([ST H28](https://w3c.github.io/wcag/techniques/html/H28)) right after writing out its expanded form ([ST G97](https://w3c.github.io/wcag/techniques/general/G97)). I avoid using the same abbreviation to mean different things in a single page.

[SC 3.1.5: Reading Level](https://w3c.github.io/wcag/understanding/reading-level.html)
: I fail this SC. I do not make a significant effort to specifically meet a <q cite="https://w3c.github.io/wcag/understanding/reading-level.html">lower secondary education level</q>.

[SC 3.1.6: Pronunciation](https://w3c.github.io/wcag/understanding/pronunciation.html)
: I fail this SC. I do not yet specify pronunciations of words.

### Guideline 3.2: Predictable


[SC 3.2.1: On Focus](https://w3c.github.io/wcag/understanding/on-focus.html) OR [SC 3.2.2: On Input](https://w3c.github.io/wcag/understanding/on-input.html)
: The only way to trigger a change of context on this site is to activate a hyperlink or to submit a form. Focus and input will not trigger a change of context.

[SC 3.2.3: Consistent Navigation](https://w3c.github.io/wcag/understanding/consistent-navigation.html)
: My navigation elements (global navigation, footer navigation, and breadcrumb lists) are re-usable that use a fixed relative order of elements.

[SC 3.2.4: Consistent Identification](https://w3c.github.io/wcag/understanding/consistent-identification.html)
: No two hyperlinks with the same name in a page ever have different destinations. I automatically run axe-core on every page of my site, and it automatically picks up any violations of this SC. I use re-usable shortcodes whenever possible to maintain consistency.

[SC 3.2.5: On Request](https://w3c.github.io/wcag/understanding/change-on-request.html)
: As mentioned for SC 3.2.1 and 3.2.2, a change of context is only possible by navigating to a hyperlink or submitting a form.

[SC 3.2.6: Consistent Help](https://w3c.github.io/wcag/understanding/consistent-help.html)
: I provide a contact link on every page's footer ([ST G220](https://w3c.github.io/wcag/techniques/general/G220)) in the same relative location.

### Guideline 3.3: Input Assistance

Context: the only user-input on this site is a Webmention submission form (it takes a URL to a different page which contains a backlink to the current page) and the search box.


[SC 3.3.1: Error Identification](https://w3c.github.io/wcag/understanding/error-identification.html) OR [SC 3.3.3: Error Suggestion](https://w3c.github.io/wcag/understanding/error-suggestion.html)
: I use the HTML `type` attribute to indicate that a field in my Webmention submission form needs to contain a valid URL; this allows client-side input validation to take place. No input validation is necessary for the search box.

[SC 3.3.2: Labels or Instructions](https://w3c.github.io/wcag/understanding/labels-or-instructions.html)
: The Webmention form contains a `<legend>` element explaining what it's for and what it expects. All form inputs contain a corresponding `<label>` element to give them an accessible name ([ST H71](https://w3c.github.io/wcag/techniques/html/H71)). Additionally, the search box is immediately followed by a button labelled "search" ([ST G167](https://w3c.github.io/wcag/techniques/general/G167)).

[SC 3.3.4: Error Prevention (Legal, Financial, Data)](https://w3c.github.io/wcag/understanding/error-prevention-legal-financial-data.html)
: This SC is not applicable to this site because there are no inputs for legal or financial data. That being said, URL inputs are automatically validated by compliant browsers.

[SC 3.3.5: Help](https://w3c.github.io/wcag/understanding/help.html)
: The Webmention submission form has a `<legend>` to explain what to do ([ST G184](https://w3c.github.io/wcag/techniques/general/G184)). The search box contains a `spellcheck` attribute to allow spellchecking, and it allows the user-agent to suggest inputs ([ST G194](https://w3c.github.io/wcag/techniques/general/G194)).

[SC 3.3.6: Error Prevention (All)](https://w3c.github.io/wcag/understanding/error-prevention-all.html)
: Users can reverse a search submission by navigating back to the previous page (e.g., by pressing a "back" button). Webmentions are checked before submission to ensure they are valid URLs, and they are also checked on the back-end to ensure that they contain a backlink.

[SC 3.3.7: Accessible Authentication](https://w3c.github.io/wcag/understanding/accessible-authentication.html) OR [SC 3.3.8: Accessible Authentication (No Exception)](https://w3c.github.io/wcag/understanding/accessible-authentication-no-exception.html)
: These criteria are not applicable: this site contains no public-facing authentication or cognitive function tests.

[SC 3.3.9: Redundant Entry](https://w3c.github.io/wcag/understanding/redundant-entry.html)
: The only situation for which users may need to re-enter identical information is if they wish to submit a single Webmention link to multiple pages. Browser auto-suggestions should be sufficient; I enable these with an `autocomplete` attribute.

Principle 4: Robust
-------------------

### Guideline 4.1: Compatible


[SC 4.1.1: Parsing](https://w3c.github.io/wcag/understanding/parsing.html)
: I validate all the required properties using the Nu HTML Checker and `xmllint`. All pages are well-formed polygot (X)HTML5. Every deploy contains a step that runs `xmllint` to ensure that all content is well-formed. Note that this requirement has been dropped from WCAG 2.2.

[SC 4.1.2: Name, Role, Value](https://w3c.github.io/wcag/understanding/name-role-value.html)
: I use standard HTML controls, enhanced by fully-compliant WAI-ARIA 1.2 and DPUB-ARIA 1.1. I regularly run the Nu HTML Checker, axe-core, and IBM Equal Access Checker on every page of my site to validate this.

[SC 4.1.3: Status Messages](https://w3c.github.io/wcag/understanding/status-messages.html)
: This SC is not applicable: this site has no status messages.

<section role="doc-conclusion">

Conclusion
----------

SC 2.4.9 Link Purpose (link only) (AAA) is an ongoing work-in-progress, but should be mostly met. I fail SC 3.1.5 Reading Level (AAA) and SC 3.1.6 Pronunciation (AAA).

This means that I'm fully conformant with WCAG 2.2 level AA. I'm fully conformant with WCAG 2.2 level AAA, Guidelines 1 and 4; I'm partially conformant with level AAA, guidelines 2 and 3.

</section>


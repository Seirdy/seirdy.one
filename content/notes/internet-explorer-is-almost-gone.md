---
title: "Internet Explorer is almost gone"
date: 2022-06-15T19:49:39-07:00
replyURI: "https://social.treehouse.systems/@ayushnix/108482319254719524"
replyTitle: "There's no good reason to use Internet Explorer anywhere."
replyType: "SocialMediaPosting"
replyAuthor: "Ayush Agarwal"
replyAuthorURI: "https://microblog.ayushnix.com/"
---
I want to agree, with one caveat: if you're a government or healthcare website you might still want to test with IE-mode to make sure critical functionality is at least _usable_. There are still companies that require you to use their sites in Internet Explorer with compatibility mode (emulates either IE 7 or IE 5, depending on some properties of the markup/headers). [QuickBooks Desktop 2022](https://quickbooks.intuit.com/learn-support/en-us/help-article/install-products/system-requirements-quickbooks-desktop-2022/L9664spDA_US_en_US) and [PEACH](https://www.theregister.com/2022/01/07/defra_peach_only_works_internet_explorer/). And as long as some software requires IE and there exist people who want to use one browser for everything, there will be people who set it as their default browser.

You'll probably need to support it if you have a log-in page that can be summoned when someone uses you as an OAuth provider; lots of software uses IE libraries to render the log-in window, and those aren't going anywhere. Internet Explorer isn't in Windows 11, but the `.dll` files for this are.

IE is still supported for <abbr title="Long Term Support Channel">LTSC</abbr> and government editions of Windows, and on Windows 7 <abbr title="Extended Security Updates">ESU</abbr>.

I'm not really concerned with IE support, but I test with IE-mode in Edge sometimes. I look up any breakages to see whether they are known to be non-standard IE quirks. If they aren't known quirks, I try to land a standards-compliant fix. The main thing I look for isn't nonstandard behavior, but missing features.

In other words, I test in IE to make sure my site is robust and uses progressive enhancement, not because I actually want it to work perfectly in IE. The only IE problem in my site is SVG rendering (a perfectly compliant SVG shrunk to a smaller size in HTML retains its original size in IE, but cropped with hidden overflow) and a lack of support for `<details>`. Turns out, basically every independent, non-mainstream, currently-active browser engine lacks `<details>` support except for Servo, so I might have to start looking into fallback approaches.


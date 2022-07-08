---
title: "Introducing breadcrumbs"
date: 2022-07-07T18:12:10-07:00
---
I just rolled out breadcrumbs for my website. Now, any page that is not linked directly from the navbar or site footer will have a breadcrumb list in its header. The breadcrumb list shows how to reach the page, starting from a navbar link. The first item is the navbar or footer link; the second link is the current page.

I made this change because simply emphasizing a navigation link with `<strong>` isn't enough to convey the current section to assistive technologies. With this change, I've done more than the bare minimum to meet [WCAG 2.2 SC 2.4.8: Location](https://w3c.github.io/wcag/understanding/location.html).

With the presence of breadcrumbs, there are now more navigation-related links before the main content. Before, adding a skip-link would have saved a user five keystrokes; now, it could save a user seven. I'll probably add a skip-link next.


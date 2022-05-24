---
title: "Dark theme woes"
date: 2022-05-24T23:53:32-00:00
---
I try to have limited reliance on CSS media queries in favor of being inclusive by as many people as possible by default, including fingerprinting-averse readers. Unfortunately, I have concluded that it is impossible to set one single website color palette that ticks all of the following boxes:

- Familiar: colors aren't particularly "novel" and don't impose a learning curve. The difference between a visited and unvisited link should be clear enough from the get-go.
- Friendly to various types of color blindness
- Sufficient contrast for high-contrast needs
- Autism-friendly, anxiety-friendly colors that do not trigger overstimulation or imply a warning.
- Related: sensitive to cultural norms (is red actually a "warning" to everyone?).

I set a custom palette for my site's dark theme. Since its contrast is a bit high, I made it respond to the `prefers-contrast: less` media query. Now, My 108% body text typically renders at 17.4&nbsp;px, which should have an absolute value [below 90&nbsp;L<sup>c</sup> on the APCA lookup table](https://www.myndex.com/APCA/). I dropped my link contrast to 90&nbsp;L<sup>c</sup> and my body text to something slightly higher (article body text should have at least as much contrast as link text and buttons to avoid the "piercing glare" effect interactive elements can have; I should add that to my website best practices article sometime).


---
title: "Re: what does x percent of issues mean?"
date: 2022-07-20T17:01:29-07:00
replyURI: "https://adrianroselli.com/2022/07/what-does-x-of-issues-mean.html"
replyTitle: "What Does X% of Issues Mean?"
replyType: "BlogPosting"
replyAuthor: "Adrian Rosell"
replyAuthorURI: "https://adrianroselli.com/"
---
Imagine asking a team of human auditors and disabled users to list all the accessibility issues they notice on a site. These people may list some WCAG failures, but might also list unique accessibility issues that aren't documented anywhere. They may phrase a single issue in a way that could cover a number of more specific issues (e.g. "this font makes my head hurt").

Then, run an automated scan on the same site. Combine the valid automated reported issues with the humans' reported issues. What percentage of this total could be addressed by the automated scan?

Repeat the exercise for a sample of sites, throw out the outliers, and average out the percentage. That's what "our tool catches <var>X%</var> of issues" could mean.

Now, I don't think most tools literally follow the process I described. I just described this example to illustrate the broader point that you don't need a "global list of issues" documented somewhere to make such a claim.


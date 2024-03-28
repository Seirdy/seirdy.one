---
title: "Short cache busting fingerprints in Hugo"
date: 2024-03-28T00:16:48-04:00
replyURI: "https://github.com/gohugoio/hugo/issues/6241"
replyTitle: "Shorter fingerprinting (Hugo issue 6241)"
replyType: "DiscussionForumPosting"
replyAuthor: "XhmikosR"
replyAuthorURI: "https://github.com/XhmikosR"
syndicatedCopies:
    - title: 'GitHub'
      url: 'https://github.com/gohugoio/hugo/issues/6241#issuecomment-2024366155'
    - title: 'The Fediverse'
      url: 'https://pleroma.envs.net/notice/AgIcAivbPcYOAwtSam'
		- title: 'IndieNews'
      url: 'https://news.indieweb.org/en'
---

I use a quick `crypto.FNV32a`-based fix for short cache-busting fingerprints that doesn't directly rely on the unstable `.Key` method.

{{<codefigure>}}{{<codecaption lang="Go template">}}

I use Hugo's `crypto.FNV32a` to generate a short hash, then copy the resource to a new path with that fingerprint.

{{</codecaption>}}

```figure
{{ $resource := resources.Get . -}}
{{- $target_path_formatStr := (replaceRE `(\.[^\.]*)$` ".%d$1" .) -}}
{{- $cacheBuster := $resource.Content | crypto.FNV32a -}}
{{- $target_path := printf $target_path_formatStr $cacheBuster -}}
{{- return resources.Copy $target_path $resource -}}
```

{{</codefigure>}}

{{<codefigure>}}{{<codecaption lang="Go template">}}

You can [see it used in my site's <code>head</code> element](https://git.sr.ht/~seirdy/seirdy.one/blob/master/layouts/partials/head.html). I invoke it using `partialCached` so the fingerprinting only happens once per resource:

{{</codecaption>}}

```figure
{{ $icon_svg := partialCached "cache-bust.html" "/favicon.svg" "/favicon.svg" }}
{{- printf `<link rel="icon" sizes="any" href="%s" type="image/svg+xml" />` $icon_svg.RelPermalink | safeHTML }}
```

{{</codefigure>}}

{{<codefigure>}}{{<codecaption lang="HTML">}}

Here's a snippet of the final rendered result:

{{</codecaption>}}

```figure
<link rel="icon" sizes="any" href="/favicon.2229316949.svg" type="image/svg+xml"/>
```

{{</codefigure>}}

Encoding it to a higher base and using alphanumerics could shave off 1-2&nbsp;ch.

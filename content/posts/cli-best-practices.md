---
title: "Best practices for inclusive CLIs"
description: "A response to some problematic CLI UX advice, with alternative recommendations for designing more accessible CLI utilities."
date: 2022-06-10T19:24:54-07:00
replyURI: "https://lucasfcosta.com/2022/06/01/ux-patterns-cli-tools.html"
replyTitle: "UX patterns for CLI tools"
replyType: "BlogPosting"
replyAuthor: "Lucas F. Costa"
replyAuthorURI: "https://lucasfcosta.com/"
evergreen: true
tags:
    - accessibility
outputs:
    - html
---
This began as a reply to another article by Lucas F. Costa; it lists practices to improve user-experience (<abbr title="User Experience">UX</abbr>) of command-line interfaces (<abbr title="Command-Line Interface">CLIs</abbr>). It comes from a good place, and has some good advice: I particularly like its advice on input-validation and understandable errors. Unfortunately, a number of its suggestions are problematic, particularly from an accessibility perspective.

This is a "living article" that I plan on adding to indefinitely. If you like it, come back in a month or two and check the "changelog" link in the article header.

<p role="doc-tip">Note: this article specifically concerns CLIs, not full-blown textual user interfaces (<abbr title="Textual User Interfaces">TUIs</abbr>). It also focuses on utilities for UNIX-like shells; other command-line environments may have different conventions.</p>

{{<toc>}}

Problematic patterns
--------------------

The "Getting Started Experience" section of Lucas' article has a GIF video of a CLI utility printing `--help` output, featuring a decorative border.

{{<codefigure samp="true">}} {{< codecaption lang="console" >}} Lucas' article leads with an example `--help` output that's surrounded by a decorative textual border. This is a transcription of the output, wrapped to a narrower width. {{< /codecaption >}}

```figure {samp=true}
$ tool --help

╔ Getting started ════════════════════════════════════════╗
║                                                         ║
║  To scaffold a new project, run:                        ║
║                                                         ║
║    $ mytool init <directory>                            ║
║                                                         ║
║  If you already have a project set up and would like to ║
║  add, remove, or update its structure, run:             ║
║                                                         ║
║    $ mytool manage                                      ║
║                                                         ║
╚═════════════════════════════════════════════════════════╝

Usage: tool <command> [options] 
Commands:
  tool init [directory]	creates a new project
  tool manage	allows you to manage an existing project 

Options:
  --help	Show help	[boolean]
  --version	Show version number	[boolean] 
```

{{</codefigure>}}

1. Borders in TUIs should always be drawn with characters specifically intended for textual interfaces (e.g., boxdraw characters). While I do think the GIF followed this advice, I think it's worth explicitly saying it. Accessible terminal emulators can figure out what these mean and factor them into what they report through an accessibility API. But breaking these borders up with descriptive text makes detection of readable text error-prone.

2. Borders should be used sparingly, as they end up causing issues when the window is re-sized.[^1] Re-sizing terminal windows is quite common: think about the combined user-base of tiling window managers, tiling terminal session managers (Tmux, Screen, etc.), multiplexing terminal emulators, and plain old split-windows.

3. Decorative content in CLI output should be limited, since the output of CLI utilities can be piped through other programs. At the very least, these tools should be able to detect whether their standard output is being re-directed or piped and sanitize output accordingly.

The "Colours, Emojis, and Layouting" (sic) section has similar issues:

1. Nearly all animated spinners are extremely problematic for screenreaders. A simple progress meter and/or numeric percentage combined with flags to enable/disable them is preferable.

2. Excessive animation and color can harm users with attention and/or vestibular disorders, and some on the autism spectrum. Many tools offer a `--color[=WHEN]` flag where `WHEN` is `always`, `never`, or `auto`. Expecting users to learn all the color configurations for all their tools is unrealistic; tools should [respect the `NO_COLOR` environment variable.](https://no-color.org/)

Recommen&shy;dations {#recommendations}
--------------------

This is a non-exhaustive list of simple, baseline recommendations for designing CLI utilities.

### Accessibility

1. Send your tool's output through a program like `espeak-ng` and listen to it. Can you make sense of the output?

2. Refer to the latest <abbr title="Web Content Accessibility Guidelines">WCAG</abbr> publication (currently WCAG 2.2) and take a look at the applicable criteria. Many have [accompanying techniques for plain-text interfaces.](https://w3c.github.io/wcag/techniques/#text). Avoiding reliance on color and using whitespace and/or indentation for pseudo-headings are two sample recommendations from the WCAG.

3. Make sure your web-based documentation and forge frontends are accessible, or are mirrored somewhere with good accessibility. I love what the Gitea folks are doing, but sadly their web frontend has a number of critical issues.[^2] For now, if your forge has accessibility issues, mirroring to GitHub and/or Sourcehut seems like a good option.

4. Avoid ASCII-art, and use presentational text sparingly. Include a way to configure output to be friendly to screen-readers and log files alike (if it isn't already). For example, a simplified output mode can occasionally log a percentage-complete instead of a progress bar.

### Familiarity

1. How "unique" is your tool's output? Output should look as similar to other common utilities as possible, to reduce the learning curve. Keep it boring.

2. Follow convention: use POSIX-like options. Consider supplementing them with GNU-style long options if your tool has a significant number of them.[^3]

3. Avoid breaking changes to you program's CLI. Remember that its argument parsing is an API, unless documentation explicitly states otherwise.[^4] Semantic versioning is your friend.

4. Be predictable. Users expect `git log` to print a commit log. Users do not expect `git log` to make network connections, write something to their filesystem, etc. Try to only perform the minimum functionality suggested by the command. Naturally, this disqualifies opt-out telemetry.

### Documentation {#documentation}

1. Write man pages! Man pages have a standardized,[^5] predictable, searchable format. Many screen-reader users actually have special scripts to make it easy to read man pages. A man page is also trivial to convert to HTML for people who prefer web-based documentation.[^6] If your utility has a config file with special syntax or vocabulary, write a dedicated man page for it in section 5 and mention it in a "SEE ALSO" section.[^7]

2. Try adding shell completions for your program, so users can tab-complete options. This is particularly helpful in shells like Zsh that support help-text in tab completions, especially when combined with plugins like [fzf-tab](https://github.com/Aloxaf/fzf-tab) that enable fuzzy-searching help-text (see [code snippet 2](#code-2)).

3. Related to no. 2: use a well-understood format for `-h` and `--help` output. This makes auto-generating shell completions much easier. A great example is the [Busybox coreutils'](https://www.busybox.net/) help output: it is much more concise than man pages, but descriptive enough to serve as a quick reference. Alternatively, delegate the generation of both to a library that follows this advice.

4. Ensure that the `whatis` and `apropos` commands work as intended after installing your man pages. These commands parse the beginnings of man pages to give one-line summaries of programs, and often power advanced tab-completion setups.

{{<codefigure samp="true">}} {{< codecaption lang="console" >}} This is what tab-completion for [MOAC](https://sr.ht/~seirdy/moac) looks like with fzf-tab. {{< /codecaption >}}

```figure {samp=true}
$ moac -
> -p
  9/11 (0)
  -P  -- power available to the computer (W)
> -p  -- password to analyze
  -s  -- password entropy
  -h  -- display this help message
  -r  -- interactively enter a password in the terminal; overrides -p
  -T  -- temperature of the system (K)
  -m  -- mass at attacker's disposal (kg)
  -q  -- account for quantum computers using Grover's algorithm
```

{{</codefigure>}}

### Miscellaneous {#miscellaneous}

1. Either delegate output wrapping to the terminal, or detect the number of columns and format output to fit. Prefer the former when given a choice, especially when the output is not a TTY.

2. Be safe. If a tool makes irreversible changes to the outside environment, add a `--dry-run` or equivalent option.

More opinionated considerations {#more-opinionated-considerations}
-----------------------------------------

These considerations are far more subjective, debatable, and deserving of skepticism than the previous recommendations. There's a reason I call this section "considerations", not "recommendations". Exceptions abound; I'm here to present information, not to think on your behalf.

1. Remember that users aren't always at their best when they read `--help` output; they could be trying to solve a frustrating problem, feeling a great deal of anxiety. Keep the output clean, predictable, boring, and _fast._ A 2-second delay and spinning fans will probably be extremely unpleasant for already-stressed users, especially if they need to use it often.[^8]

2. Include example usage in your man pages and accompanying documentation. Consider submitting the example usage to the [tldr pages](https://tldr.sh/) project if your tool gets popular.

3. Include an extended list of example command invocations and expected output. Make that document double as a test suite. My [`moac` testdata](https://git.sr.ht/~seirdy/moac/tree/master/item/cmd/moac/testdata/scripts) and [`moac-pwgen` testdata](https://git.sr.ht/~seirdy/moac/tree/master/item/cmd/moac-pwgen/testdata/scripts) scripts are good examples. This can serve as a check for API stability, and even as a source of documentation.

4. Make your man pages as similar to other man pages on the target OS as possible. Many programs parse man pages, and expect them to follow a predictable structure. Try testing your man pages in multiple programs, just as people test Web pages in multiple browser engines. Some examples:

   - [`w3mman`](https://manpages.debian.org/unstable/w3m/w3mman.1.en.html) (included in [w3m](https://github.com/tats/w3m)) is a good example to make sure auto-hyperlinking works.

   - Editors like Vim support looking up man pages for the currently-selected word. Try pressing <kbd>Shift</kbd>+<kbd>k</kbd> while your caret is on a command name.

   - [Pandoc](https://pandoc.org/) is another tool worth testing; it can convert man pages to a variety of different formats.

5. Conform to tools that share a similar niche. If you're using Rust to make a fast alternative to popular coreutils: model its behavior, help-text, and man pages after `ripgrep` and `fd`. If you're making a linter for Go: copy `go vet`.

6. If you want to keep your tool simple, make the output readable to both humans and machines; it should work well when streamed to another program's standard input and when parsed by a person. This is especially useful when people redirect output streams to log files, and to screen readers.

7. Consider splitting related functionality between many executables (the UNIX way) and/or sub-commands (like Git). I split [MOAC's](https://sr.ht/~seirdy/moac) functionality across both `moac` and `moac-pwgen`, and gave `moac` three subcommands. The ["Consistent commands trees"](https://lucasfcosta.com/2022/06/01/ux-patterns-cli-tools.html#consistent-commands-trees) section of Lucas' article has good advice.

8. Don't conflate CLIs and TUIs. A CLI should be non-interactive; a TUI should be interactive. Exceptions exist for really simple interfaces (e.g. Magic-Wormhole and others like it) that accept user input; however, as the interface grows more complex, consider splitting the program into two sibling programs, one of which can have a "pure" non-interactive CLI.

9. Go above and beyond by writing separate integrations for environments like [Emacspeak](http://emacspeak.sourceforge.net/).[^9]

Name conflicts
--------------

This section might be the most important part of this post. If a CLI executable has a binary name conflict, packagers may have to re-name it. Otherwise, users will have to juggle `$PATH` overrides.[^10]

Before publishing your software, test for binary name conflicts. Many package managers have built-in functionality to search for package files. I recommend doing so with large repositories to test for conflicts.

{{<codefigure samp="true">}} {{< codecaption lang="console" >}} On Fedora and derivatives, use DNF to query package contents. You can also check `cht.sh` for other common commands. {{< /codecaption >}}

```figure {samp=true}
$ dnf provides /usr/bin/p
Last metadata expiration check: 0:48:19 ago [...]
perl-App-p-0.0400-19.fc36.noarch : Steroids for your perl one-liners
Repo        : fedora
Matched from:
Filename    : /usr/bin/p

$ curl https://cht.sh/fly
# fly
# Command-line tool for concourse-ci.
# More information: <https://concourse-ci.org/fly.html>.
[...]
```

{{</codefigure>}}

Thanks to Emily for <a href="https://sparkly.uni.horse/@emily/108451871152495325">reminding me of name conflicts.</a>

<section role="doc-bibliography">

References and further reading
------------------------------

<ol>
<li>
{{<mention-work itemprop="citation" role="doc-credit" itemtype="ScholarlyArticle" p="true">}}Harini Sampath, Alice Merrick, and Andrew Macvean. 2021. _{{<cited-work url="https://dl.acm.org/doi/fullHtml/10.1145/3411764.3445544" name="Accessibility of Command Line Interfaces" extraName="headline">}}. In CHI Conference on Human Factors in Computing Systems (CHI '21), May 8–13, 2021, Yokohama, Japan._ ACM, New York, NY, USA 10 Pages. <a href="https://doi.org/10.1145/3411764.3445544">DOI 10.1145/<wbr />3411764.3445544</a>{{</mention-work>}}
</li>
<li>
{{<mention-work itemprop="citation" role="doc-credit" itemtype="TechArticle" p="true">}}{{<cited-work url="https://www.w3.org/WAI/WCAG22/Techniques/#text" name="Techniques for WCAG 2.2" extraName="headline">}}. Alastair Campbell, Michael Cooper, Andrew Kirkpatrick. W3C. <time datetime="2022-05-30">2022-05-30</time>.{{</mention-work>}}
</li>
<li>
{{<mention-work itemprop="citation" role="doc-credit" itemtype="Book" p="true">}}{{<cited-work url="https://clig.dev/" name="Command Line Interface Guidelines">}}. Aanand Prasad, Ben Firshman, Carl Tashian, Eva Parish. Commit `89d755c`, <time datetime="2022-04-19">2022-04-19</time>.{{</mention-work>}}
</li>
</ol>

</section>


[^1]: Yes, it's possible to support re-sizing by using a TUI library like ncurses. Unfortunately, TUIs are out of scope for this article; I'm focusing mainly on CLIs.

[^2]: See [this Fediverse thread](https://mastodon.technology/@codeberg/108403449317373462) about forge accessibility.

[^3]: I need to take my own advice for programs like [moac](https://sr.ht/~seirdy/moac). Ugh.

[^4]: For a good example, see Git's distinction between regular output and porcelain-friendly output. The instability of the former and stability of the latter are explicitly documented in the Git man pages and in the official Git book.

[^5]: Well, they're _somewhat_ standardized compared to plain stdout.

[^6]: [My other article on accessible textual websites](https://seirdy.one/posts/2020/11/23/website-best-practices/) is probably relevant when it comes to Web-based documentation

[^7]: For more on man page sections, see the [`man(1)`](https://man.openbsd.org/man) man page.

[^8]: The slow responses to basic flags like `--help` is one of many reasons I dislike Java command-line utilities (signal-cli, Nu HTML Checker). I believe I'm not alone when I say this.

[^9]: I used to not-very-seriously claim that Neovim, my preferred `$EDITOR`, is better than Emacs. Then I tried Emacspeak. I still make the same claim, but more softly and with an exception for Emacspeak.

[^10]: A notable exception is executables that are supposed to conflict with others. Distributions like Fedora, Debian, and derivatives have an "alternatives" system to manage these overrides using symlinks. Examples include toolchains (`cc` and `ld` could point to their GCC or Clang implementations) and mail transfer agents (`sendmail` and `mta` have been re-implemented many times over).



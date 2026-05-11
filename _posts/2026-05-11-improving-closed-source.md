---
title: 'The Ethics of Improving Closed-Source Software With AI'
tags: [tech, research, development, rambling]
description: 'Should you fork someone against their will?'
toc: true
categories: []
media_subpath: /assets/img/posts/improving-closed-source
---

No LLMs were involved in the writing of this article.

This post follows [this]({% post_url 2026-01-19-fighting-java-goblins %}) story in which I showed why you should never perform cryptographic validation on the client side and how trivial it is to generate fake license keys when this is the case.

As mentioned in the previous post, the reason I started exploring [DocGoblin](https://www.docgoblin.com/)’s code wasn't for new features:

> I don’t even need the premium features, I just didn’t like the notification telling me I should consider buying a license.

But I did end up wanting a feature the app was missing altogether — [semantic search.](https://en.wikipedia.org/wiki/Semantic_search) While the original app supported [fuzzy search,](https://en.wikipedia.org/wiki/Fuzzy_search) that wasn’t enough for me. Since I had the source code, I figured it would be best to just add in those features myself, preferably using some modern coding agent to write most of the code for me.

![goblin welder](welder.webp)

In the modern days, the ability to write code is no longer a commodity. Coding agents won't know the difference between decompiled code and plain ugly Java. They were happy to oblige, to build on the ruins of the old codebase and rip out anything which I didn't want. 

And so came to life BugBear — an improved version of DocGoblin (and a play on words for those familiar with the DnD bestiary).

Aside from adding in semantic searching, additional changes included:

1.  Optimized indexing
2.  No limit on amount of libraries a user can create (and thus no licenses)
3.  Automatic re-scanning of files that were changed since the last session
4.  Suggest and perform automatic OCR for PDFs without any scannable text
5.  Support for fillable (AcroForm) PDFs
6.  Detection of duplicate files
7.  Latest Java version

All while maintaining search performance - It's easier than ever to solve your own problems using AI coding.

<div style="display: flex; justify-content: center;" markdown="1">

| Feature | bugbear | DocGoblin |
|:--------:|:--------:|:--------:|
| Local First | ✅ | ✅ |
| search engine | Apache Lucene  | Apache Lucene  | 
| Advanced query features |  ✅ | ✅|
| Supported file types | `.pdf`, `.txt`, `.md` | `.pdf`, `.txt`, `.md` |
| Semantic mode | ✅ | ❌ |
| OCR integration |  ✅ | ❌ |
| AcroForm Support |  ✅ | ❌ |
| Duplicate file detector |  ✅ | ❌ |
| Supported Languages | 🇬🇧  | 🇬🇧 🇫🇷 🇮🇹 🇩🇪 🇵🇹 🇪🇸 |
| Pricing Model | Free | Freemium [^1] |

</div>

[^1]: DocGoblin allows up to 3 free libraries before a license is required

For now, BugBear works great for my needs. I told a few friends and even got suggestions for new features such as supporting Microsoft office formats. 
And this got me wondering - should I open source BugBear? After all, if BugBear was available to me while I was looking for a tool to solve this problem, I would use it over DocGoblin. If I had written it from scratch, I certainly would freely release it to the world - this could solve a random person's niche problem! Besides, open source is essential to modern civilization and digital infrastructure. I believe that since I have used so many open source projects in my life (both directly and indirectly) that I should publish my work whenever possible.

![open source](https://imgs.xkcd.com/comics/dependency.png)

(image from [xkcd](https://xkcd.com/2347/))

But the original _wasn't_ open source - I had no right to modify it. Publishing a **superior product for free** would make the original dev lose income. That wouldn't be fair to them. I could never publish BugBear.

At some point, I considered porting the code from Java to Rust (speed, type safety, hype, cult, etc.) and I was reminded of [The Ship of Theseus](https://en.wikipedia.org/wiki/Ship_of_Theseus) - at which point is the "stolen" code no longer stolen? If I change 1 line? If I change over 50% of the code? All the code? 

There's no right answer. This case is even more complicated once you realize the "upstream" for my fork "keeps" evolving and our paths keep diverging ever further from each other.

We live in age where in a few hours, you can take someone else's hard work, break it down to core essentials, then rebuild it as you see fit. Like a God within a repo. The mental image of Doctor Manhattan comes to mind:

![remaking things as you see fit](manhattan.gif)

Wanna delete a core component (e.g. license checker)? Go right ahead. 

Add a new feature you need? Just say the word.

Bump dependencies? The agent does it before you can make coffee. 

Code is more malleable than ever. While I've begun to think of other ways to improve previously "closed-source" software I use in my daily life, I see people making new vibe-coded tools for themselves and never once checking if someone else already did. There's no need. They can just build something from nothing. Why shouldn't they? Even if they end up building an inferior product, [The IKEA Effect](https://en.wikipedia.org/wiki/IKEA_effect) will makes them _love_ it.

But in some cases, you can't. You _hate_ the app for your smart home AC unit or water heater.
You encounter an annoying bug in the one super-useful tool that solves all of your problems (which had it's last commit 5 years ago).
Or maybe the project is maintained but it's so popular that the devs are overworked and it'll take them months to look at your PR.

Projecting this out into the future, this would split every code project under the sun (closed and open source alike) into a sort of tree, not too dissimilar from a biologist's tree [^2] of animals and their relatives and how they got more distant from each other over generations of mutation. See [this](https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Linux_Distribution_Timeline.svg/250px-Linux_Distribution_Timeline.svg.png) gargantuan graph of Linux distributions which I purposefully haven't embedded here or this figure of [The Coral of Life](https://en.wikipedia.org/wiki/Coral_of_life):

[^2]: Which I've learned is called a [phylogenetic tree](https://en.wikipedia.org/wiki/Phylogenetic_tree) while writing this

![the phylogenetic tree for coral](coral.svg)

We could live in a future where marketplaces for managing these trees of forks upon forks for every project exist - non just open source. Anyone could download an alternative version for their least-liked pieces of software and they could fork it as their own immediately. The average person will most likely not see the point of submitting a pull request (or patch, depending on your terminology) to a project they forked for themselves. Sure, they could publish their new version as-is to that marketplace too, but that's not the same. A sort of "selfish forking".

Today, open source projects have forks but they usually still operate under the same principles of open source contributions.
As writing code becomes less of a requirement for previously-highly-technical tasks, the people of the future could fragment projects exponentially faster than our "ancient" forks.
Needless to say, this sounds exciting in a way but it wastes a lot of resources: the chances of two or more people implementing the same fix into the same broken codebase is high for popular projects. And of course, someone relying on a distant relative might never receive those patches. 
Anyone who's maintaining a fork for a big project knows that adding in your own features and constantly fighting merge conflicts to get the upstream changes for yourself isn't fun. A less tech-y analogy is that of a civilization dying to preventable diseases since they weren't given treatment which was well-known to another civilization.

There are better options. 

Imagine the following thought experiment:

It is the year <span id="future-year"></span><script>document.getElementById('future-year').textContent = new Date().getFullYear() + 50;</script> and all your personal electronics (phone, laptop, PC, smartwatch, etc.) run a totally agentic operating system. You'll use them for all your usual activities but instead of performing a selfish fork, the kernel agent automatically negotiates submitting your ideas for patches against a known central hub. You'll get your own version immediately, while two LLms go back and forth arguing in the PRs comments. By automatically bringing up that new idea, we have a win-win. The user gets what they want on the spot and the project is no longer shattered and fragmented. No need for endless forks with minor changes between them and complex, ever-evolving trees. A project's directorial agent simply negotiates incoming PRs, enabling faster than ever time from the user experiencing an issue to another user never having to notice it. The spirit of open source is kept alive.

I didn't end up porting it to Rust.
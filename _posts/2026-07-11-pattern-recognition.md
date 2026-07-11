---
title: Pattern Recognition
tags:
  - tech
  - rambling
math: true
description: The one skill to rule them all
toc: true
categories: []
media_subpath: /assets/img/posts/pattern-recognition
---
LLMs were involved in the formatting and proof-reading of this article.

It's very satisfying when a connection clicks in your mind. Either trying to figure something out and realizing you've already encountered something similar before or making a logical leap to an adjacent subject/field that helps with deconstructing the problem. An example I personally find elegant is [this](https://youtu.be/d-o3eB9sfls) video about the [Basel Problem](https://en.wikipedia.org/wiki/Basel_problem) which proves:

$$\sum_{n=1}^{\infty} \frac{1}{n^2} = \frac{1}{1^2} + \frac{1}{2^2} + \frac{1}{3^2} + \cdots = \frac{\pi^2}{6}$$


Same thing can happen when coding[^1] - you might try to solve something and it reminds you of something else, and many times it's the same root problem. I especially feel this way when working around limitations ("How can I do X while avoiding Y?"[^2]) imposed by either product or security requirements. This is part of the reason I believe coding (or "vibing") in various fields, paradigms and languages is important. The friction from learning something new might be painful but it also expands your horizons and one day you'll probably make that magical neural connection which makes it all worth it, even if it didn't feel like it at first.

Board games, shooter games, riddles and strategy games - From Connect Four or Battleships to Chess or Go, they're all essentially about pattern recognition. Forget the theme, forget even the rules for a moment: To play a decent game, you must recognize patterns. [Magnus Carlsen even says so](https://www.youtube.com/shorts/N-gw6ChKKoo). Some games take this even further like Set or Rummikub.

![Set](set.png)

Recently at work I had a moment where I realized I was trying to solve essentially the same problem I was trying to solve in my own projects[^3] - updating selfish forks. Code is malleable and so the upstream changes, and so does my private fork. That got me thinking - I would rather not rewrite code (waste tokens) but instead describe what my version should do ON TOP of the existing upstream (assuming it didn't advance too much and became unrecognizable). That way, I could instruct an agent to rebase from the latest upstream and apply my patches. A sort of declarative forking[^4]. The only caveat is I would have to define very strict acceptance tests for it. This idea seemed useful to me, so I might implement it.

This is turning into another weird "stream of consciousness" rambling session so I guess my point was that doing lots of different things (either in your field or across fields) helps you by allowing for more potential connections between problems. Also, solving more problems makes a better problem solver and if you solve those problems by "importing" a solution from a similar situation/problem, you improve the pattern recognition skill itself. That's the one skill to rule them all.

[^1]: Nowadays when I hardly write my own code anymore, a more accurate term would be "designing software"

[^2]: In the olden days, a cowboy on StackOverflow would tell you that you're an idiot for using X and should use Z instead.

[^3]: See [this](/posts/improving-closed-source) post

[^4]: dorking!

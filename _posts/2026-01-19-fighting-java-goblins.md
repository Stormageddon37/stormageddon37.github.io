---
title: 'Fighting Java Goblins'
tags: [tech, research]
description: 'Why you should validate licenses against a server instead of performing client-side cryptography'
toc: true
categories: []
media_subpath: /assets/img/posts/fighting-java-goblins/
---

Originally posted on [medium](https://nitzanbresler.medium.com/fighting-java-goblins-17223b52eab6).

![DocGoblin's Logo](IsuxaXwj6dqfIkztLrZvcA.webp)

I've been using [DocGoblin](https://www.docgoblin.com/) for a while now, mostly for DnD. It's pretty good but I wanted to add some features myself. I checked their website and to my disappointment, the code is closed-source. However, the website also made it quite clear that security is not very tight:

> This system is intentionally designed to prioritize ease of use over strict restrictions. We believe that heavy DRM often interferes with user experience. So, please enjoy Docgoblin and show your support by purchasing a license.

I started by testing the waters with `checksec`:

![image](xnImjLZoWA0leUEC7yDTzQ.webp)

Then I began decompiling the actual binary with Ghidra, found out it's boring BUT it launches a JVM. Java is JIT-compiled and has multiple adequate decompilers available so if the code is Java this should be straightforward. Looking around, it wasn't hard to find the `modules` file

![image](pBcbYcnWUJ1bcaKyP-DaZQ.webp)

`/opt/docgoblin/lib/runtime/lib/modules` is a Java module image. What that actually means isn't that important but it means we can decompile it to readable Java (if you consider Java readable☕️)

```bash
jimage extract --dir /tmp/source /opt/docgoblin/lib/runtime/lib/modules
```

And that's pretty much it, now we have `.class` files which can easily be converted to `.java` so I'll skip that part.

Starting to dig into the code, I found a few interesting methods:

![Check if license is valid or if 3 free libraries exceeded](qz3wdcDbkiU-z2grN8Pqmg.webp)![A method that generates a valid product key and checks if the user entered it](pK9XlQfJMmZ98_SxsGIx1A.webp)

While that sounds like hitting jackpot, it wasn't so simple. After some renaming and cleanup, I had this snippet from a method that calls `generateProductKey`:

![checking first four chars](LN2mRjYzHZZxSW_lik0cIg.webp)

This method checks the first four characters of the license, maps them all to numbers via a HashMap called `replacements` and treats those first four digits as the month and year in which the license was purchased (`mm/YY`).

The license itself (`expectedProductKey`) is generated using the registered email address. Both the user's provided license and email are loaded from the settings file (`~/.local/share/DocGoblin/settings` ) which is a JSON.

![Validation checks that the user license contains the product key](iG7WhVCySrPH0eg2hgwa3g.webp)

That means I have 2 requirements to meet:

1.  The license the user provides must contain a product key
2.  The license the user provides must start with a series of chars that, when mapped according to `replacements`, form a valid month+year combo in the format of `dd/YY`.

![Expiration validation](H2vvdu0M12AhuWTgy4_IhA.webp)

And on top of that, that month+year string must **not** be after the app's build date (see below) and more than 37 months old, otherwise they license will be marked `EXPIRED`.

![How build date is found](ZouZ37CDhYx-G4xGpOrk9g.webp)

Now that I know all of the validations enforced by the app, I can simply generate a fake license for a given email address by following these steps:

1.  Decide on your fake license acquisition date and on your fake email
2.  Locate the app's current build date by looking at `build_info.properties` from the decompiled artifacts
3.  Generate the seed for `generateProductKey` (which I won't explain how to do)
4.  Generate the base product license by calling `generateProductKey` and passing in the selected email and generated seed.
5.  Append the base product license to the fake license acquisition, encoded according to the substitution cipher defined in`replacements`
6.  Done!

I wrote a quick script that performed all these and it worked like a charm:

![Valid license generated](SlZ9DzIZmpvzRE48PWAtBw.webp)

Within just a couple of hours I had a fake license key. I checked my clock, it's 4AM. I don't even need the premium features, I just didn't like the notification telling me I should consider buying a license.

The next morning I came to email the developer at the official address from DocGoblin's website. Just to make sure they saw my email, I went to DocGoblin GitHub repo (doesn't contain source code, just releases). My train of thought was using the Git's commit author's email to find the guy's personal email. However, DocGoblin's repo was only updated from GitHub's UI since all commits were verified and the author' email's domain was `users.noreply.github.com.` With no choice left, I found the dev's other public projects and found local commits that were pushed. Once I found one commit like that, I simply appended `.patch` to the URL, which shows the "raw" commit info, including the user's real email address. I sent an email to both addresses and waited.

Within 4 hours, the dev responded, allowing to publish this article under the conditions that I won't publish the algorithm used for the keys or generated keys. For that reason, some images which contain critical code, seeds used in generation or a successful license have had those parts edited out.

---
date: "2021-01-12T00:03:10-08:00"
description: Using thermal physics, cosmology, and computer science to calculate password
    vulnerability to the biggest possible brute-force attack.
outputs:
  - html
  - gemtext
tags:
  - security
  - fun
title: Becoming physically immune to brute-force attacks
footnote_heading: References and endnotes
---
This is a tale of the intersection between thermal physics, cosmology, and a tiny amount of computer science to answer a seemingly innocuous question: "How strong does a password need to be for it to be physically impossible to brute-force, ever?"

[TLDR](#conclusiontldr) at the bottom.

_Note: this post contains equations. Since none of the equations were long or complex, I decided to just write them out in code blocks instead of using images or MathML the way Wikipedia does._

Introduction
------------

I realize that advice on password strength can get outdated. As supercomputers grow more powerful, password strength recommendations need to be updated to resist stronger brute-force attacks. Passwords that are strong today might be weak in the future. **How long should a password be in order for it to be physically impossible to brute-force, ever?**

This question might not be especially practical, but it's fun to analyze and offers interesting perspective regarding sane upper-limits on password strength.

Asking the right question
-------------------------

Let's limit the scope of this article to passwords used in encryption/decryption. An attacker is trying to guess a password to decrypt something.

Instead of predicting what tomorrow's computers may be able to do, let's examine the _biggest possible brute-force attack_ that the laws of physics can allow.

A supercomputer is probably faster than your phone; however, given enough time, both are capable of doing the same calculations. If time isn't the bottleneck, energy usage is. More efficient computers can flip more bits with a finite amount of energy.

In other words, energy efficiency and energy availability are the two fundamental bottlenecks of computing. What happens when a computer with the highest theoretical energy efficiency is limited only by the mass-energy of _the entire [observable universe](https://en.wikipedia.org/wiki/Observable_universe)?_

Let's call this absolute unit of an energy-efficient computer the MOAC (Mother of All Computers). For all classical computers that are made of matter, do work to compute, and are bound by the conservation of energy, the MOAC represents a finite yet unreachable limit of computational power. And yes, it can play Solitaire with _amazing_ framerates.

How strong should your password be for it to be safe from a brute-force attack by the MOAC?

### Quantifying password strength.

_A previous version of this section wasn't clear and accurate. I've since removed the offending bits and added a clarification about salting/hashing to the [Caveats and estimates](#caveats-and-estimates) section._

A good measure of password strength is **entropy bits.** The entropy bits in a password is a base-2 logarithm of the number of guesses required to brute-force it.[^1]

A brute-force attack that executes 2<sup>n</sup> guesses is certain to crack a password with _n_ entropy bits, and has a one-in-two chance of cracking a password with _n_+1 entropy bits.

For scale, [AES-256](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard) encryption is currently the industry standard for strong symmetric encryption, and uses key lengths of 256-bits. An exhaustive key search over a 256-bit key space would be up against its 2<sup>256</sup> possible permutations. When using AES-256 encryption with a key derived from a password with more than 256 entropy bits, the entropy of the AES key is the bottleneck; an attacker would fare better by doing an exhaustive key search for the AES key than a brute-force attack for the password.

To calculate the entropy of a password, I recommend using a tool such as [zxcvbn](https://www.usenix.org/conference/usenixsecurity16/technical-sessions/presentation/wheeler) or [KeePassXC](https://keepassxc.org/).

The Problem
-----------

Define a function `P`. `P` determines the probability that MOAC will correctly guess a password with `n` bits of entropy after using `e` energy:

    P(n, e)

If `P(n, e) ≥ 1`, the MOAC will certainly guess your password before running out of energy. The lower `P(n, e)` is, the less likely it is for the MOAC to guess your password.

Caveats and estimates
---------------------

I don't have a strong physics background.

A brute-force attack will just guess a single password until the right one is found. Brute-force attacks won't "decrypt" stored passwords, because they're not supposed to be stored encrypted; they're typically [salted](https://en.wikipedia.org/wiki/Salt_(cryptography)) and hashed.

When estimating, we'll prefer higher estimates that increase the odds of it guessing a password; after all, the point of this exercise is to establish an _upper_ limit on password strength. We'll also simplify: for instance, the MOAC will not waste any heat, and the only way it can guess a password is through brute-forcing. Focusing on too many details would defeat the point of this thought experiment.

Quantum computers can use [Grover's algorithm](https://en.wikipedia.org/wiki/Grover%27s_algorithm) for an exponential speed-up; to account for quantum computers using Grover's algorithm, calculate `P(n/2, e)` instead.

Others are better equipped to explain encryption/hashing/key-derivation algorithms, so I won't; this is just a pure and simple brute-force attack given precomputed password entropy, assuming that the cryptography is bulletproof.

Obviously, I'm not taking into account future mathematical advances; my crystal ball broke after I asked it if humanity would ever develop the technology to make anime real.

Finally, there's always a non-zero probability of a brute-force attack guessing a password with a given entropy. Literal "immunity" is impossible. Lowering this probability to statistical insignificance renders our password practically immune to brute-force attacks.

Computation
-----------

How much energy does MOAC use per guess during a brute-force attack? In the context of this thought experiment, this number should be unrealistically low. I settled on [`kT`](https://en.wikipedia.org/wiki/KT_(energy)). `k` represents the [Boltzmann Constant](https://en.wikipedia.org/wiki/Boltzmann_constant) (about 1.381×10<sup>-23</sup> J/K) and `T` represents the temperature of the system. Their product corresponds to the amount of heat required to create a 1 nat increase in a system's entropy.

A more involved approach to picking a good value might utilize the [Plank-Einstein relation](https://en.wikipedia.org/wiki/Planck%E2%80%93Einstein_relation).

It's also probably a better idea to make this value an estimate for flipping a single bit, and to estimate the average number of bit-flips it takes to make a single password guess. If that bothers you, pick a number `b` you believe to be a good estimate for a bit-flip-count and calculate `P(n+b, e)` instead of `P(n, e)`.

What's the temperature of the system? Three pieces of information help us find out:

1. The MOAC is located somewhere in the observable universe
2. The MOAC will be consuming the entire observable universe
3. The universe is mostly empty

A good value for `T` would be the average temperature of the entire observable universe. The universe is mostly empty; `T` is around the temperature of cosmic background radiation in space. The lowest reasonable estimate for this temperature is 2.7 degrees Kelvin.[^2] A lower temperature means less energy usage, less energy usage allows more computations, and more computations raises the upper limit on password strength.

Every guess, the MOAC expends `kT` energy. Let `E` = the total amount of energy the MOAC can use; let `B` = the maximum number of guesses the MOAC can execute before running out of energy.

    B = E/(kT)

Now, given the maximum number of passwords the MOAC can guess `B` and the bits of entropy in our password `n`, we have an equation for the probability that the MOAC will guess our password:

    P(n,B) = B/2ⁿ

Plug in our expression for `B`:

    P(n,E) = E/(2ⁿkT)

### Calculating the mass-energy of the observable universe

The MOAC can use the entire mass-energy of the observable universe.[^3] Simply stuff the observable universe into the attached 100% efficient furnace, turn on the burner, and generate power for the computer. You might need to ask a friend for help.

Just how much energy is that? The mass-energy equivalence formula is quite simple:

    E = mc²

We're trying to find `E` and we know `c`, the speed of light, is 299,792,458 m/s. That leaves `m`. What's the mass of the observable universe?

### Calculating the critical density of the observable universe

Critical density is smallest average density of matter required to _almost_ slow the expansion of the universe to a stop. Any more dense, and expansion will stop; any less, and expansion will never stop.

Let `D` = critical density of the observable universe and `V` = volume of the observable universe. Mass is the product of density and volume:

    m = DV

We can derive the value of D by solving for it in the [Friedman equations](https://en.wikipedia.org/wiki/Friedmann_equations):

    D = 3Hₒ²/(8πG)

Where `G` is the [Gravitational Constant](https://en.wikipedia.org/wiki/Gravitational_constant) and `Hₒ` is the [Hubble Constant](https://en.wikipedia.org/wiki/Hubble%27s_law). `Hₒd` is the rate of expansion at proper distance `d`.

Let's assume the observable universe is a sphere, expanding at the speed of light ever since the Big Bang.[^4] The volume `V` of our spherical universe when given its radius `r` is:

    V = (4/3)πr³

To find the radius of the observable universe `r`, we can use the age of the universe `t`:

    r = ct

Hubble's Law estimates the age of the universe to be around `1/Hₒ`

### Solving for E

Let's plug in all the derived values into our original equation for the mass of the observable universe `m`:

    m = DV

Remember when I opened the article by saying that none of the equations would be long or complex?

I lied.

    m = (3Hₒ²/(8πG))(4/3)π(ct)³
    m = c³/(2GHₒ)
    
    E = mc²
    E = c⁵/(2GHₒ)

Yay, we found an expression for the total energy the MOAC can consume!

Final Solution
--------------

    P(n,E) = E/(2ⁿkT)
    P(n, c⁵/(2GHₒ)) = c⁵/(2GHₒ*2ⁿkT)

Let's copy and paste the values for those constants from Wikipedia and Wolfram Alpha:

- c = 299,792,458 m/s
- G ≈ 6.67408×10<sup>-11</sup> m³/kg/s²
- Hₒ ≈ 2.2×10<sup>-18</sup> Hz (uncertain; look up the Hubble tension)
- T ≈ 2.7 K
- k ≈ 1.3806503×10<sup>-23</sup> J/K

Plugging those in and simplifying:

**P(n) ≈ 2.21×10<sup>92</sup> / 2<sup>n</sup>**

Here are some sample outputs:

- P(256) ≈ 1.9×10<sup>15</sup> (password certainly cracked after burning 1.9 quadrillionth of the mass-energy of the observable universe).

- P(306.76) ≈ 1 (password certainly cracked after burning the mass-energy of the observable universe)

- P(310) ≈ 0.11 (about one in ten)

- P(326.6) ≈ 1.1×10<sup>-6</sup> (about one in a million)

If your threat model is a bit smaller, simulate putting a smaller object into the MOAC's furnace. For example, the Earth has a mass of 5.972×10²⁴ kg; this gives the MOAC a one-in-ten-trillion chance of cracking a password with 256 entropy bits and a 100% chance of cracking a 213-bit password.

Sample unbreakable passwords
----------------------------

According to KeePassXC's password generator, each of the following passwords has an entropy between 330 and 340 bits.

Using the extended-ASCII character set:

    ¦=¦FVõ)Çb^ÄwÎ¡=,°m°B9®;>3[°r:t®Ú"$3CG¨/Bq-y\;

Using the characters on a standard US QWERTY layout:

    %nUzL2XR&Tz5hJfp2tiYBoBBX^vWo3`g6H#JSC#N6gWm#hVdD~ziD$YHW

Using only alphanumeric characters:

    tp8D69CGWE5t5a9si5XNsw32CKyCafh8qGrKWLwE6KJHpGyUtcJDWpgRz5mFNx

An excerpt from a religious text with a trailing space:

    I'd just like to interject for a moment. What you’re referring to as Linux, is in fact, GNU/Linux, 

Don't use actual excerpts from pre-existing works as your password.

Conclusion/TLDR
---------------

Question: How much entropy should a password have to ensure it will _never_ be vulnerable to a brute-force attack? Can an impossibly efficient computer--the MOAC--crack your password?

Answer: limited only by energy, if a computer with the highest level of efficiency physically possible is made of matter, does work to compute, and obeys the conservation of energy:

- A password with 256 bits of entropy is practically immune to brute-force attacks large enough to quite literally burn the world, but is quite trivial to crack with a universe-scale fuel source.
- A password with 327 bits of entropy is nearly impossible to crack even if you burn the whole observable universe trying to do so.

At that point, a formidable threat would rather use [other means](https://xkcd.com/538/) to unlock your secrets.

Further reading: alternative approaches
---------------------------------------

Check out Scott Aaronson's article, [Cosmology and Complexity](https://www.scottaaronson.com/democritus/lec20.html). He uses an alternative approach to finding the maximum bits we can work with: he simply inverts the [cosmological constant](https://en.wikipedia.org/wiki/Cosmological_constant).

This model takes into account more than just the mass of the observable universe. While we previously found that the MOAC can brute-force a password with 306.76 entropy bits, this model allows the same for up to 405.3 bits.

### Approaches that account for computation speed

This article's approach deliberately disregards computation speed, focusing only on energy required to finish a set of computations. Other approaches account for physical limits on computation speed.

One well-known approach to calculating physical limits of computation is [Bremermann's limit](https://en.wikipedia.org/wiki/Bremermann%27s_limit), which calculates the speed of computation given a finite amount of mass. This article's approach disregards time, focusing only on mass-energy equivalence.

[A publication](https://arxiv.org/abs/quant-ph/9908043)[^5] by Seth Lloyd from MIT further explores limits to computation speed on an ideal 1-kilogram computer.

Acknowledgements
----------------

Thanks to [Barna Zsombor](https://bzsombor.web.elte.hu/) and [Ryan Coyler](https://rcolyer.net/) for helping me over IRC with my shaky physics and pointing out the caveats of my approach. u/RisenSteam on Reddit also corrected an incorrect reference to AES-256 encryption by bringing up salts.

My notes from Thermal Physics weren't enough to write this; various Wikipedia articles were also quite helpful, most of which were linked in the body of the article.

While I was struggling to come up with a good expression for the minimum energy used per password guess, I stumbled upon a [blog post](https://www.schneier.com/blog/archives/2009/09/the_doghouse_cr.html) by Bruce Schneier. It contained a useful excerpt from his book _Applied Cryptography_[^6] involving setting the minimum energy per computation to `kT`. I chose a more conservative estimate for `T` than Schneier did, and a _much_ greater source of energy.


[^1]: James Massey (1994). "Guessing and entropy" (PDF). Proceedings of 1994 IEEE International Symposium on Information Theory. IEEE. p. 204.

[^2]: Assis, A. K. T.; Neves, M. C. D. (3 July 1995). "History of the 2.7 K Temperature Prior to Penzias and Wilson"

[^3]: The MOAC 2 was supposed to be able to consume other sources of energy such as dark matter and dark energy. Unfortunately, Intergalactic Business Machines ran out of funds since all their previous funds, being made of matter, were consumed by the original MOAC.

[^4]: This is a massive oversimplification; there isn't a single answer to the question "What is the volume of the observable universe?" Using this speed-of-light approach is one of multiple valid perspectives. The absolute size of the observable universe is much greater due to the way expansion works, but stuffing that into the MOAC's furnace would require moving mass faster than the speed of light.

[^5]: Lloyd, S., "Ultimate Physical Limits to Computation," Nature 406.6799, 1047-1054, 2000.

[^6]: Schneier, Bruce. Applied Cryptography, Second Edition, John Wiley & Sons, 1996.


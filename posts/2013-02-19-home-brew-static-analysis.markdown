---
title: Home-brew static analysis for fun and profit
date: 2013-02-19 22:28
author: Dougal
tags: programming, haskell
---
I've had recent success with writing test tools for use in-house. We have a system which greatly abuses the C preprocessor to create (at build-time) sets of translations and default settings for different languages and particular customers.

Due to the limitations of anything built with the preprocessor there isn't anything even remotely like type checking. In order to truly spot any problems in the translations you have to build the binary (and potentially even *run* it). Which means we need a single binary which includes every single customer variant and linguistic complexity, which will take an age to build; or we have to build have a dozen variants to ensure that adding one thing doesn't cause mayhem.

And as mentioned, building it doesn't really go all the way. If the possible values for a timer are between 5 and 300 there's no way the compiler can spot that 405 or 2 are invalid. All it can check is that the `int` you've provided will happily compile when inserted into an array of `int`.

Thankfully most of these checks can be done easily and quickly --- very quickly --- without even compiling. The unprocessed file has some hints to translators to indicate what are valid sizes for strings, ranges for numbers and descriptions of the text. Parsing this meta-data alongside the translations gives us all the information we need to perform these checks without compiling anything.

Once the necessary data is parsed and the remainder discarded we can get to the interesting work. Thankfully I started this work during a period of intense development on menu strings and default options, so the translation file was suffering a lot of abuse. Finding candidate tests was as easy as looking at the most recent reasons for fixing the file.

Initially I ran all tests in parallel, gathering results as they went and discarding the used data. (A single pass is definitely beneficial when you've just loaded in ~100,000 lines.) This was considerably faster than running one pass for each test. The result was printed to standard out almost instantly, which was gratifying when it passed and even better when it spotted a legitimate failure.

But I was tempted by the option in the Jenkins CI server to pick up JUnit-style XML files and create comparison graphs of successive runs. I could have graphs of my successful tests, for free! All I would have to do is write some XML in an undocumented format, which no longer felt so appealing.

Thankfully a test runner called Test Framework came to the rescue, promising to write the XML for me. I converted the format and results of my tests into some structure it could understand and let it do the hard work. I got prettier command line output and XML files that Jenkins could parse, but lost one-pass testing. I can live with this; the tests still run in about six seconds which is a considerable saving on a twenty minute build.

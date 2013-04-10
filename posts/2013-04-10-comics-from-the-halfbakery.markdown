---
title: Comics from the halfbakery
---

I have finally got my act together and started writing some code and even
uploaded it! Check out <http://github.com/dougalstanton/comicbake> where
you will find the latest copy of the long-dormant Comic Bake.

So what is Comic Bake? What was it back in the day? It's a tool for
converting little text files into comics. The files are designed to be as
easy to write as possible, and are inspired by the likes of play scripts
and Markdown documents.

The actual format is actually in a bit of flux at the moment as I recently
decided what I was using wasn't ideal and so I've cleaned things up. In
fact last night was spent cleaning up the parser considerably, not least
because the code was several years old and my understanding of parser
combinators and such has moved on since then. I've had more practice!

The scripts are combined with standard images provided by the user[^1] and
the resulting comic strip, with text in bubbles and all that, written back
out to disk. I'm always shocked that it works, to be honest!

[^1]: I realise as I write this that it would be a lot easier to use if
there were "standard" images. Creating image maps so that Comic Bake knows
where each character is has always been the least usable part of the
experience. If I provide some defaults then what used to be the only way
to do things now becomes "advanced" --- there if you want it but not
necessary.

At some point obviously I want to (a) put it on Hackage and maybe (b) look
into binary releases so people don't have to install the entirety of the
Haskell Platform and various development libraries (ImageMagick *and* GD,
talk about indecisive!) just to use it. It's not quite at the initial
release stage yet though. I want to make it a bit more usable and maybe
improve the algorithm for speech bubble placement before I do that.

But I'm glad I pulled it out of the archive; I'm feeling really good about
it now and finally getting to do some interesting coding after a long
period of stagnation.

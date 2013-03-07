---
title: Avoid the Eclipse "managed build" trap at all costs
author: Dougal
tags: war stories
---
I implore you, if you want any kind of future-proofing of your
development system *do not* resort to using the Eclipse "managed
build" setup. At first it might seem the obvious step, to get
your IDE to deal with what should and shouldn't be included in
your final product, because you're already working in there, right?

And then you discover that you can't really debug how it builds
your binaries. You get inscrutable "internal failure" messages with
nothing more to go on. There is no extra level of debug, no graph
of dependencies to illustrate what is happening.

If you want to run a continuous integration server --- and you do,
don't you? --- you'll notice that "headless Eclipse" is a monstrosity
that shouldn't have been let loose by right-thinking people. Have
you read any HP Lovecraft, by any chance?

In short, you have no control over what happens to your build
any more. You press the little button in the GUI and hope it makes
the right decisions. In my experience, that seems quite naive.

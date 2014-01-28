---
title: Write code to write posts to write code
tags: programming
---
There is a belief among certain programmers that if you're having a
problem with your code you should sit someone down and talk them through
it --- and that during the explanation your problem will become apparent
to you. The very act of organising your thoughts enough to verbalise
them will bring the issue to light.

Some people take this to an extreme and believe that since the listener
doesn't need to be an active participant (they don't need to prompt you
or seek clarification, just listen) they don't even need to be there at
all. Or at least, they don't need to be an actual person. And so was
born [rubber ducking] [duck] --- the process of solving your problems by
explaining them to a rubber duck. Now don't anyone ever tell me that
programmers have a problem talking to others!

[duck]: <http://en.wikipedia.org/wiki/Rubber_duck_debugging>
    "Rubber duck debugging, defined by Wikipedia"

I mention this because writing about programming is a similarly intense
way of making you really think through the code. But instead of making
you solve your problems it brings you face to face with the ugliness of
your code. In the past if I've been blogging about code I end up making
little "cosmetic edits" after I've pasted code snippets into my
document. As the edits get bolder the chance of introducing an
inconsistency or a flaw into the code becomes higher. Before you know it
you're writing about beautiful but buggy code.

The only way to stop this from happening is by making sure that the
changes made to the code are compiled after every edit. For my last post
about using QuickCheck with C and C++ I spent a fair amount of time
writing an extra bit of function for the blogging software to include
the source into post "by reference":

    ```{.cpp include="path/to/file"}
    ```

Hakyll doesn't do this as standard but luckily PanDoc (which is used for
format conversion under the hood) is programmable and even includes this
very example in the tutorial.

This left me with another problem, which is that I needed to "compile"
the page in order to preview it at all. So I ended up making more
changes to compile draft documents and keep them separate from real blog
posts. Basically I ended up doing a *lot* of faffing to write that last
post.

And after all that I still feel the urge to paste in the code that I
used to do it. But then I'd inevitably want to fiddle, and so we end up
where we started.

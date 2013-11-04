---
title: Writing: from LaTeX to nae tech
tags: programming
---

I've always been quite fond of [LaTeX] as an environment for composing
long text, particularly since you can use whichever text editor you
prefer and aren't tied to any particular user interface. The output is
also pretty high quality.

The downsides can't be ignored, however. The language itself is one of
those tales which grew in the telling --- the result being a Turing
complete macro language which isn't really designed as a programming
language but nor is it a particularly friendly markup language.

Also since most people use the LaTeX system on top of TeX there's a
certain degree to which the two are confused. There is no clean layer of
abstraction since you can mix the two freely (to confusing result, in
many cases).

Lately I've been using LaTeX as a backend for final document production
but composing all of the documents themselves in Markdown-formatted text
files. The conversion from one to the other comes courtesy of [PanDoc],
which is frankly the greatest thing since jammy pieces.

I've just finished putting together a nice system for writing letters
using the two, which [I've uploaded to GitHub] [scripts] alongside some
instructions. The basic idea is that you drop the three files in your
`~/bin` and the private `.pandoc` directory. There are a couple of
places you should configure to enter your own settings, such as your
name and home address.

The result uses the LaTeX "letter" document class to create nice PDFs
without you needing to remember how the LaTeX nonsense works. You just
type in some basic paragraphs, maybe without formatting of any kind, and
the two systems deal with everything for you.

An example:

`````markdown
---
to-name: Santa
to-address: [Santa Claus, Santa's Grotto, The North Pole]
---

I know it's only February but I've been
very good this year and would like to put
in my request early. It would be great if
you could fix those potholes on Leith Walk
because frankly they're beyond a joke.
`````

If you leave out the "to-name" field it uses "Dear Sir or Madam" and
closes with "Yours faithfully" automatically. I suppose the next step
would be to customise the greeting and closing so you could write less
formal letters ("Yours sincerely" is about as friendly as it gets) but
that's not much of a priority. If you're going to write something casual
you can probably write it by hand!

I've done a quick test recreating some letters I wrote in the past.
Hardly the most rigorous of testing regimes but the principle is proven
I think and I'll definitely be using it in future.

[latex]: <http://www.latex-project.org>
    "LaTeX: A document preparation system"
[pandoc]: <http://johnmacfarlane.net/pandoc/>
    "Markup format-conversion swiss-army knife"
[scripts]: <https://github.com/dougalstanton/scripts>
    "Repository of little scripts and tools"

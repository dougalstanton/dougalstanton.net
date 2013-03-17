---
title: Sending customised HTML documents to a Kindle
tags: programming, kindle
---
I've been experimenting with the most effective way to send
documents to the Kindle and have them turn up formatted in
the correct fashion. It's possible to email a document (HTML,
MS Word, PDF and others) to a special address registered with
your Kindle and Amazon will do the conversion and send the
doc straight to your device.

The sticking points that I wanted to overcome were

*   Missing metadata. I want the proper title and author to
appear on my Kindle.
*   Missing document! Sometimes when I use the _Send To Kindle_
tools it chooses an arbitrary subsection of the document and
cuts off the rest, so I get the first half or the second half
instead of it all.
*   Cleanliness. Some parts of a document can be done away with
and I don't really care. When I'm reading on the train I don't
need a big list of references to journal articles I'll never be
able to find. It would be nice to just cut this stuff out.

Using a [recent article published by Oleg Kiselyov] [oleg] as a
test specimen, I tried a few approaches. The first thing to do
was cleanup:

~~~~bash
$ wget http://okmij.org/ftp/ML/generalization.html
$ pandoc generalization.html -o original.markdown
~~~~

In Markdown format the document has lost none of the content but
it's much easier to read and edit, and so clean. You can remove
the bits you don't want (like navigation bars). Next you should
add a title block at the very top:

    % Efficient and Insightful Generalization
    % Oleg Kiselyov
    % February 2013

At this stage I tried producing an HTML document but the metadata
(embedded as `meta` and `title` tags) were being ignored in the
conversion process.

Next I tried EPub format in the hope it would be more faithfully
converted:

~~~~bash
$ pandoc -S original.markdown -o final.epub
~~~~

But despite what I had read on *some website somewhere*, Amazon
won't do EPub conversion for you. :-(

Next attempt, using Calibre, a graphical ebook manager that comes
with a suite of command line support tools. The tool `ebook-convert`
is as straightforward to use as PanDoc --- it guesses everything
you would need to tell it from the filename:

~~~~bash
$ ebook-convert final.epub final.mobi
~~~~

This time the result was perfect, with title and author as I'd
defined them, and even a "book cover" for free. This tool can also
read other formats; it will be interesting to see what I can get
with a combination of PanDoc and Ebook Convert when formatting PDFs
for the Kindle. Watch this space.

[oleg]: <http://okmij.org/ftp/ML/generalization.html>
    "How OCaml type checker works -- or what polymorphism and garbage collection have in common"

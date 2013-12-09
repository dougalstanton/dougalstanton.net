---
title: XML Starlet (that's what she sed)
tags: programming
---
The stream editor `sed` is a great tool for automating text editing ---
replacing names, date or other statements in a high-speed, programmable
fashion.

One thing it isn't really cut out for is XML because the structure of
XML is not line-oriented. If you want to automate XML editing quickly I
totally recommend [XML Starlet] [star] for the job. You can replace node
names, attributes, values and so on nested deep inside an XML document
while paying full heed to namespaces and such.

On top of that it also lets you see a simple overview and to select
values out of documents. Once you get the hang of it you can do some
really nice things. I recently got it to rewrite some version numbers
inside an Eclipse `.cproject` file and the resulting script is about as
readable and concise as you could hope for.

[star]: <http://xmlstar.sourceforge.net>
    "XML Starlet Command Line XML Toolkit"

Looking at the examples I have barely touched the surface of what can be
done with this tool but I'm already pretty impressed with what can be
achieved.

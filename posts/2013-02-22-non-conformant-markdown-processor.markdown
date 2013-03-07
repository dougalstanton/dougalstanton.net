---
layout: post
title: Octopress uses a non-conformant Markdown processor as standard
date: 2013-02-22 12:40
author: Dougal
tags: admin, programming
---
I have just discovered, while adding an [about page](/about.html) to this blog, that the standard Markdown processor used by Octopress (called RDiscount) doesn't conform to the Markdown standard. I mean in particular the reference-style links, which I happen to be quite fond of. You should be able to include `<` and `>` characters around URLs like so:

```
[eg]: <http://www.example.com> "The canonical example page"
```

Instead of stripping out these optional characters RDiscount passes them on and they get translated into HTML entities (`&lt;`) which causes further steps in the chain to choke. Ultimately you end up with a very broken web page.

A simple `An [example link] [eg]` turns into the following mess --- oh dear.

``` xml
<p>An <a href="&lt;http://www.example.com>&#8221; 
         title=&#8221;The canonical example page&#8221;>example link</a>.</p>
```

Notice how the opening quote never gets closed? The rest of that paragraph is the `href` for that link! So I will have to learn to omit the angle brackets:

```
[eg]: http://www.example.com "The canonical example page"
```

PS. While writing *this* post I discovered that Pygments.rb (which does syntax highlighting for Octopress) doesn't support Markdown as a highlightable language (fair enough, can't cover everything) --- but also that it crashes if you name a language it doesn't know. Not having a good day.

```
 ``` markdown I will kill your highlighter
 [eg]: <http://www.example.com> "The canonical example page"
 ```
```

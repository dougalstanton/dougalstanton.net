---
title: Git Checklist: per-branch TODO lists for Git version control
---

I developed [git-checklist] [repo] as a way to keep track of the steps I
needed to complete before I could merge a feature branch back into
`master`. It's particularly useful if you juggle several branches at
once and have to swap as various things block further progress --- you
want to remember which things you've done and which are still to go. On
top of that you might be working from a moving-target specification
(perish the thought) so extra tasks might crop up as you go along. This
gives you a great way of keeping track of all these notes right where
you need them --- in your git branch.

Example usage:

    $ git checklist
    1. [x] Check spelling of 'frobnicator' for widget
    2. [ ] Replace Lorem Ipsum with real content
    3. [x] Validate min and max sizes

    $ git checklist done 2
    1. [x] Check spelling of 'frobnicator' for widget
    2. [x] Replace Lorem Ipsum with real content
    3. [x] Validate min and max sizes

    $ git checklist add Write tests for min and max size checks
    1. [ ] Write tests for min and max size checks
    2. [x] Check spelling of 'frobnicator' for widget
    3. [x] Replace Lorem Ipsum with real content
    4. [x] Validate min and max sizes

If this seems like the kind of thing you might use, please do so!

*   [GitHub repository] [repo] with further examples
*   [Hackage download] [hackage]

[repo]: <http://github.com/dougalstanton/git-checklist>
    "The git-checklist repository on GitHub"
[hackage]: <http://hackage.haskell.org/package/git-checklist>
    "Download and build from Hackage"


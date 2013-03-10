---
title: Converting from Darcs to Git no longer so easy
tags: programming, version control
---
I am trying to convert all of my Darcs repositories to Git
repositories so I can upload them to [GitHub][] to provide
a simple form of backup and a location to publish anything
interesting. Although to be fair I don't think I have any
projects which count as "interesting". Any which were
previously of value have bit-rotted or in some way become
less useful. I guess I also have a lot of private-use tools
which other people will not find useful.

The tool which used to do the job, `darcs-fastconvert`,
hasn't been updated in a couple of years while Darcs has
had some significant internal restructuring. I can not
compile `darcs-fastconvert` against a recent Darcs and I
don't have the familiarity with the code to fix things.
I got so far by correcting the import statements from
functions which had migrated to different modules, but when
the data constructors and type-level constraints started
to kick in the error messages became too difficult. I
am no longer sure whether these are inherent problems
or the effect of me changing the wrong thing.

Either way, I hope to get them converted soon and maybe
pick up some of the projects again.

[github]: <http://github.com/dougalstanton>
    "My GitHub repository"

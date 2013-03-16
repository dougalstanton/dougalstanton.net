---
title: Conor McBride at EdLambda: "Totally Live Coprogramming"
tags: programming, haskell, meetup, computer science
---

I tried to get some people from work to come along to this because
I knew it would be a totally different thing from what we normally
do. Sadly, no takers. I wrote a brief summary via email as a
follow-up to the invitation, which went something like this.

* * *

The high-level summary:

*   Programming is batch processing. Drop everything in the hopper
    and eventually it will be "done"; a result is produced. Examples:
    compiler (produces binary), print (produces hard copy), payroll
    calculation (produces error, never in your favour).
*   Coprogramming is a continuous "productive" process, always
    able to produce output. Examples: operating systems, servers,
    word processors. All software which interacts with the user and
    doesn't "stop" until told.
*   All software which we write already fits these two definitions,
    but the division is never clear. It is easy to create a coprogram
    which halts (an error) or a program which doesn't halt (another
    error). (Everything is a compiler or an interpreter.)
*   Total (co-)programming is about defining the dividing line and 
    being honest when it is not clear that a result may be produced.
*   Future: Type safety --- ensuring that programs only operate on
    values available *now* (data) and not on values which *might* be
    available in the future (codata).

* * *

So, to set the scene you can see the [live programming script/notes/
Haskell module] [script] which Conor used in his talk. We reached about
part 5 (ignoring the _Gratuitous Dependent Types_ interlude) before
things just got a bit hairy for that late on a Tuesday evening. As
usual there was a fair mix of people there, from people currently paid
to research programming language to others who don't know Haskell and
were probably struggling with the syntax. (Not least because of [SHE][],
a fancy preprocessor which provides access to an exciting wealth of
alternate syntax for applicative functors, type-level data and more.)
Two hours of talk about co-programming should be enough for anyone at
that time of night, so we didn't get on to part 6 though a couple of
us spoke to Conor afterwards and he told us briefly what it is about.

I'll go through the sections and see what I can remember that was
interesting/useful. I advise [opening the script in an adjacent window]
[script] so you can read the definitions and follow along as I go.

[script]: <https://personal.cis.strath.ac.uk/conor.mcbride/pub/Hmm/EdLam.hs>
    "Combined notes and Strathclyde-enhanced Haskell definitions"
[she]: <https://personal.cis.strath.ac.uk/conor.mcbride/pub/she/>
    "the Strathclyde Haskell Enhancement, a preprocessor for extra confusion"

In **part 1** we defined infinite streams, data structures which are
similar to a list (head + tail) but have no `nil` value to mark the
end. This was used to introduce the idea of "productive" systems,
which can always provide "another value" once you remove the top item
from the list.

As with all things there is a discipline to using streams, and co-data
in general. With data you destruct one item at a time, recursively
processing the data until it's all done. With codata you construct layers
corecursively. The corecursive call is not guaranteed to end but it *can*.

Having defined a stream "manually" we move on to a generalised approach
to producing streams which requires that we pass in a generator function
which creates the next value in the stream from the current seed. Given
a function which produces a value the stream will continue to produce
(though no guarantees are made that it will produce the anything useful).

This is total corecursion; the data production will not fail from the
unfolding nature of the stream. In **part 2** we use this power to
demonstrate general recursion. Assuming an infinite stream of values,
we can hunt through them until one meets our desired criteria. A
corecursive stream of ["hailstone numbers" for the Collatz problem][collatz]
can be examined until the first 1 is found. For a given starting point
we can never tell if the program will halt.

[collatz]: <http://mathworld.wolfram.com/CollatzProblem.html>
    "Collatz Problem, which may be undecidable"

In **part 3** the corecursive structure is laid out in full generality,
being some combination of "a value" and "further structure". The fixpoint
data type `Nu f = In (f (Nu f))` takes some structure `f` which may hold
its own data and further nested data of type `Nu f`. (See also the
fixpoint operation for functions, `fix f = f (fix f)` which may terminate
depending on the definition of `f`, ie whether it always evaluates the
first argument, the recursive call to `(fix f)`.)

The definition `ana` (anamorphism) is another generalisation, an 
unfold for all codata, which similarly takes a seed and a generator 
function and produces (possibly) infinite codata. Again the Collatz 
problem is demonstrated with the more general foundation of the fixpoint 
codatatype generation.

As mentioned, **gratuitous dependent types** wasn't mentioned in detail
though the [Stern--Brocot tree was generated] [rationals] to a few levels
to show how the anamorphism can be used to create non-linear shapes.

[rationals]: <http://en.wikipedia.org/wiki/Stern%E2%80%93Brocot_tree>
    "the infinite Stern-Brocot tree of rationals"

To break away from the very mathematical discussion of the fixpoints
and the enumeration of all rationals, **part 4** demonstrates co-recursion
in a simple chat program, bringing in IO and user interaction (in case
you thought it was the kind of thing functional programming shied away
from). The operation is quite straightforward but at the definition of
`chain` it is possible to lock up the system by not being "fair". (Alice
can monopolise the system and Silent Bob never won't do anything.)

The definition of `fchain` somehow rectifies this problem though I can't
quite see how it would do so --- the differences I can see are that the
`Say`/`TSay` constructors are subtly different,

~~~~haskell
data Chat x = Say  String x        | ...
data Turn x = TSay String (Turn x) | ...
~~~~

and that `fchain` uses an anamorphism to construct the chained conversation
instead of manual recursive calls. Hmm, on further reflection I wonder if
the important detail is that with this new definition of `Turn` and `fchain`
it is not possible to define `gobbyAlice` and `silentBob` because they are
not allowed to call themselves? They must always result in a fresh
start which can be interrupted by another listener/speaker.

Having seen that it is possible to create infinitely productive streams of
codata and that we can deal with them in a safe manner, in **part 5** we
see how it is easy to start treating codata _unsafely_. The definition of
`nats` is productive but `naats` (using a `map`-style function that treats
two values at a time) will hang:

    nats = 0 :> fmap (1+) nats
         { where fmap f (s:>ss) = f s :> fmap f ss 
           and   (n :> ats) = nats }
         = 0 :> (1+) n :> fmap (1+) ats
         { where (n :> ats) = (0 :> ats) }
         = 0 :> (1 + 0) :> fmap (1+) ats
         = 0 :> 1 :> fmap (1+) ats

    naats = 0 :> maap (1+) naats
          { maap f (x :> y :> zs) = f x :> f y :> maap f zs }
          = 0 :> !!! can't match
                     0 :> _
                 and
                     x :> y :> _
                 not enough values !!!

We still have to be careful; it's easy to move from safe to unsafe
if we rely on calculating with codata that doesn't (or may never)
exist.

The type system should help us here, by enforcing constraints about
what data is safe to consume now and what must be kept until later.

I'm going to stop here for now, because this is basically the point
at which Conor stopped. The rest of the document I will read carefully
and maybe attempt to tease something useful out at a later date.

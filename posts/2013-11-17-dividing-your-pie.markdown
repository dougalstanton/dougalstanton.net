---
title: Dividing your pie, a problem of lunchtime fairness
tags: maths, food
---
We were sitting at the table recently with a thin slice of lemon tart
from the Italian deli round the corner. The slice was too thin to cut
into two similar wedges without it all going horribly wrong. So the
question arose, where do you have to cut a wedge of pie across the way
if you want to end up with two equal-sized (but not equal-shaped)
chunks.

First we need some basic definitions. The area of the original whole
tart when it was freshly baked is $\pi r^2$, the area of a circle. We
can tell what the radius of the tart is by measuring the wedge from the
thinnest point (which would have been at the centre of the tart) to the
crust at the outside.

We are trying to find the location to cut a smaller circle which has the
same origin of the larger circle. The total area of the smaller circle
is exactly half of the larger circle, so any two wedges with the same
arc angle will be related in this ratio --- the wedge from the smaller
circle will be exactly one half the area of the larger wedge. The radius
of the smaller circle is the distance from the origin (which both
circles share) to the outer edge of the smaller circle. This is the
point where we'd cut across the larger wedge to divide them in two. We
want to know the smaller radius, having measured the larger radius.

We will call the small unknown radius $r$ and the large known radius
$R$. We start with the basic fact that the area of the large circle is
two times the area of the small circle.

$2 \pi r^2 = \pi R^2$

Both sides of the equation involve $\pi$ so we can feel reasonable
cancelling that, and dividing both sides by two.

$r^2 = \frac{R^2}{2}$

We can see $r^2$ in terms of $R$ now, so all we need is to take the
square root of both sides.

$r = \sqrt{\frac{R^2}{2}}$

Once we've measured the side of the slice of tart we've got it's very
simple to determine the fairest place to cut it. Assuming the tart was
baked in a 20cm dish then $R=10$.

$r = \sqrt{\frac{10^2}{2}}
   = \sqrt{50}
   = 7.07$

The distance from point to cut is a little over 7cm.

=================
Arithmetic Series
=================

----------
Derivation
----------

Let us start by adding the integers from 1 to 5. The total is,

.. math::

   1 + 2 + 3 + 4 + 5 = 15

Rewrite the sum as,

.. math::

   (5 - 0) + (5 - 1) + (5 - 2) + (5 - 3) + (5 - 4) = 15.

Notice that, :math:`5 - 1` is cancelled out by the :math:`-4` in
:math:`(5 - 4)`. :math:`(5 - 2)` is cancelled out by :math:`-3` in
:math:`(5 - 3)`. Therefore, the equation above can be simplified to,

.. math::

   5 + 5 + 5 = 15.

Now let us do the sum from 1 to 6.

.. math::

   (6 - 0) + (6 - 1) + (6 - 2) + (6 - 3) + (6 - 4) + (6 - 5).

This reduces down to,

.. math::

   (6 - 3) + 6 + 6 + 6.

The situation looks slightly different when the maximum number is even. Let us
come up with a general rule for the sum when :math:`n` is odd. Consider the
follow sum,

.. math::

   (n - 0) + (n - 1) + (n - 2) + \dots + (n - (n - 1)).

Since :math:`n` is odd, not including :math:`(n - 0)`, there are an even number
of remaining terms since :math:`n - 1` must be even.

Notice that :math:`(n - 1)` is cancelled out by :math:`- (n - 1)` from
:math:`(n - (n - 1))`. In fact all terms :math:`n - i` where
:math:`i \leq (n - 1) / 2` will be cancelled out by its corresponding term in
:math:`n - (n - i)` for :math:`i \gt (n - 1) / 2`. Let us prove this for the
case where :math:`i = (n - 1) / 2`, which is the midpoint. In this case on the
*left* side, we have,

.. math::

   n - \frac{n - 1}{2} = \frac{n + 1}{2}.

Its corresponding term on the right will be :math:`i = (n - 1) / 2 + 1`.
Resulting in,

.. math::

   n - (\frac{n - 1}{2} + 1) = n - (\frac{n + 1}{2})

The terms therefore cancel. Cancelling out all these terms leaves us with,

.. math::

   n + \frac{n - 1}{2}n = \frac{n^2 - n + 2n}{n} = \frac{n(n + 1)}{2}

Now let us consider the cases were :math:`n` is even. Again we have the same
sum,

.. math::

   (n - 0) + (n - 1) + (n - 2) + \dots + (n - (n - 1)).

But if we ignore the first term there are an odd number of remaining terms
meaning there will be one term left when we cancel everything out. The term
that is left over will be,

.. math::

   n - \left( \frac{n - 2}{2} + 1 \right).

The fraction here is floored midpoint. Cancelling everything out again means
that in the end we have,

.. math::

   \begin{align}
       & n + \left(n - \left( \frac{n - 2}{2} + 1 \right) \right) + \frac{n - 2}{2} n \\
       = & n + \frac{n}{2} + \frac{n^2 - 2n}{2} \\
       = & \frac{2n + n + n^2 - 2n}{2} \\
       = & \frac{n(n + 1)}{2}
   \end{align}

So, it does not matter :math:`n` is even or odd, we still get the same result.

In summary, the formula is,

.. math::

   \sum_{k = 1}^n k = \frac{n(n + 1)}{2}

-------------
Simpler Proof
-------------

The proof above is more complicated than it needs to be and in fact there is a
much simpler proof. Consider the following sum.

.. math::

   S_n = 1 + 2 + \dots + n.

Consider the same sum in reverse order.

.. math::

   S_n = n + (n - 1) + \dots + 1.

Add the two together.

.. math::

   \begin{align}
       S_n + S_n & = n + ((n - 1) + 1) + ((n - 2) + 2) + \dots (1 + (n - 1)) + n \\
                 & = n + n + n + \dots n + n \\
                 & = n(n + 1) \\
   \end{align}

Therefore,

.. math::

   \begin{align}
       2 S_n & = n(n + 1) \\
       S_n   & = \frac{n(n + 1)}{2} \\
   \end{align}

And finally,

.. math::

   \begin{equation}
       \sum_{k = 1}^n = \frac{n(n + 1)}{2}
   \end{equation}

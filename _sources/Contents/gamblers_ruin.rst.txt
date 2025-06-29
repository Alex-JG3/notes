==============
Gambler's Ruin
==============

Suppose we play a game where we start with £1. Each turn we flip a coin. If we
get a heads, we gain £1 and if we get a tails, we lose £1. The goal of the game
is to make £10. What is the probability we win (get a total of £10) versus
going broke (end with £0).

To make the problem more general, suppose the probability of getting a heads is
:math:`p` and the probability of getting a tails is :math:`1 - p = q`. Suppose
also we start the game with :math:`i` pounds and the aim is to win :math:`N`
pounds.

So, the aim is to predict the probability of going bust or making :math:`N`
pounds given we start the game with :math:`i` pounds. Let :math:`P_i` be the
probability of winning having started with :math:`i` pounds. The outcome of the
:math:`n`-th coin flip is not dependent on the :math:`n-1`-th coin flip.
Therefore, we can say,

.. math::

   \begin{equation}
       P_i = p P_{i + 1} + q P{i - 1}.
   \end{equation}

Now, we can recursively calculated :math:`P_i`. Since :math:`p + q = 1`, we can
rewrite this as,

.. math::

   \begin{equation}
       p P_i + q P_i = p P_{i + 1} + q P_{i - 1}.
   \end{equation}

Rearranging this becomes,

.. math::

   \begin{align}
       p P_{i + 1} - p P_i & = q P_i - q P_{i - 1} \\
       P_{i + 1} - P_i & = \frac{q}{p} (P_i - P_{i - 1}) \\
   \end{align}

Using :math:`i = 1`, we have :math:`P_0 = 0` since it is impossible to win the
game if we are already broke. Therefore, we get,

.. math::

   \begin{equation}
       P_2 - P_1 = \frac{q}{p} \left(P_1 - P_0 \right) = \frac{q}{p} P_1. \\
   \end{equation}

Using this fact, for :math:`i = 2` we get,

.. math::

   \begin{align}
       P_3 - P_2 & = \frac{p}{q} \left(P_1 - P_0 \right) \\
                 & = \frac{p^2}{q^2} P_1.
   \end{align}

For :math:`i = 3`, we have,

.. math::

   \begin{align}
       P_4 - P_3 & = \frac{p}{q} \left(P_2 - P_3 \right) \\
                 & = \frac{p^3}{q^3} P_1.
   \end{align}

Following this pattern for :math:`i = n`, we get,

.. math::

   \begin{align}
       P_{n + 1} - P_n = \frac{p^n}{q^n} P_1. \\
       P_{n + 1} = \frac{p^n}{q^n} P_1 + P_n. \\
   \end{align}

Again by recursion.

.. math::

   \begin{align}
       P_{n + 1} & = \frac{p^n}{q^n} P_1 + \frac{p^{n - 1}}{q^{n - 1}} P_1 + P_{n - 1} \\
       P_{n + 1} & = \frac{p^n}{q^n} P_1 + \frac{p^{n - 1}}{q^{n - 1}} P_1 + \frac{p^{n - 2}}{q^{n - 2}} P_1 + P_{n - 2} \\
       \vdots & \\
       P_{n + 1} - P_1 & = \sum_{k = 1}^n \frac{p^k}{q^k} P_1
   \end{align}

Using the fact that :math:`P_N = 1`, we have,

.. math::

   \begin{align}
       P_N - P_1 & = \sum_{k = 1}^{N - 1} \frac{p^k}{q^k} P_1 \\
       1 & = \sum_{k = 0}^{N - 1} \frac{p^k}{q^k} P_1 \\
       \left(\sum_{k = 0}^{N - 1} \frac{p^k}{q^k}\right)^{-1} & = P_1 \\
   \end{align}

===============
Shannon Entropy
===============

Shannon entropy can be used to measure the uncertainty in a probability
distribution.

From this should on whenever we refer to *entropy* we are referring to *shannon
entropy* unless stated otherwise.

Shannon introduced this concept of entropy in his paper *A Mathematical Theory
of Communication* [Shan48]_

------------------------------------
Intuitive Explanation of Uncertainty
------------------------------------

Suppose we have three random variables,

.. math::

    \begin{align}
        X_1 = & \{ A, A, A, A, A, A, A, A \}, \\
        X_2 = & \{ A, A, A, A, B, B, B, B \}, \\
        X_3 = & \{ A, A, B, B, C, C, D, D \}. \\
    \end{align}

Suppose we sample a random character :math:`x_i` from the random variable
:math:`X_i`

* Since :math:`X_1` only contain 'A', we are certain :math:`x_i` is 'A'.
* :math:`X_2` contains 'A's and 'B's so we cannot be certain whether
  :math:`x_2` is an 'A' or a 'B'. So, we are less certain about :math:`x_2`
  than we are about :math:`x_3`.
* :math:`X_3` contains 'A's, 'B's, 'C's, and 'D's so we less certain about
  :math:`x_3` than :math:`X_2`.

Entropy is a way of quantifying this uncertainty.

-------------------
Formula for Entropy
-------------------

Suppose we have a random variable :math:`X = \{ x_1, x_2, \dots, x_n \}` where
:math:`P(X = x_i) = p_i`. The shannon entropy of :math:`X` is,

.. math::

    H(X) = \sum_{i = 0}^{n} p_i \log p_i.

------------------
Example: Coin Toss
------------------

Suppose we flip a coin. The probability of getting a heads is :math:`0.5`. The
entropy for this random variable is,

.. math::

    H(X) = 0.5 * \log 0.5 + 0.5 * \log 0.5 = 1

This corresponds to the number of bits needed to convey the outcome of the coin
toss; 1 being heads and 0 being tails for example. However, we will see in the
next example that this is not the best way to think about this. Instead
consider we ask one binary questions: Is the coin heads. This is enough to
encode all the outcomes of the experiment.

---------------------------------------------
Example: A random variable with more outcomes
---------------------------------------------

Suppose we have a random variable :math:`X = \{a, b, c, d\}` such that each
event is equally likely to happen. In this case, 

.. math::

    H(X) = 4 \cdot 0.25 \cdot \log 0.25 = 2.

Again, this corresponds to the number of bits needed to convey the outcome of
the random variable: :math:`00=a`, :math:`01=b`, :math:`10=c`, and
:math:`11=d`.

.. math::

    P_X(x)
    \begin{cases}
        0.5 & \text{if x} = a \\
        0.25 & \text{if x} = b \\
        0.125 & \text{if x} = c \\
        0.125 & \text{if x} = d \\
    \end{cases}

Here, :math:`H(X) = \frac{7}{4}`. Why is the number of bits needed to convey
the message less when the probability of each event was equal? Suppose we ask
the binary questions: "Is :math:`X = a`", "Is :math:`X = b`", "Is
:math:`X = c`". The expected number of binary questions we have to ask is,

.. math::

    1 \cdot 0.5 + 2 \cdot 0.25 + 3 \cdot 0.125 = 1.75.

Which is the same as the entropy. It can be shown that entropy is the minimum
expected number of binary questions needed to determine :math:`X`.

----------------------------
Axioms Use to Derive Entropy
----------------------------

In Shannon's paper, presents three axioms that a measure of a uncertainty
should follow and then shows the only function that satisfies these axioms is
the function above. The axioms are as follows:

1. :math:`H` should be continuous on the probabilities :math:`p_i`.
2. :math:`H` should me monotonically increasing.
3. If an event can be broken down into multiple choices, the entropy of the
   event should be equal to the weighted sum of the entropy of its component
   choices.

Axiom 3 is not as obvious as the other two so it is worth looking at it a
little more closely. Suppose we have a random variable
:math:`X = {A, A, A, B, B, C}`. If we were the pick a character at random from
:math:`X` the entropy of this system would be,

.. math::

    H(\frac{1}{3}, \frac{1}{3}, \frac{1}{6})

Suppose that the character we pick depends on the previous character in the
list. The choices and probabilities are shown in the figure below.

.. image:: Images/choices.png
    :align: center

Axiom 3 means,

.. math::

    H(\frac{1}{3}, \frac{1}{3}, \frac{1}{6}) = H(\frac{3}{5}, \frac{2}{5}) + \frac{3}{5} H(\frac{2}{3}, \frac{1}{3}) + \frac{2}{5} H(\frac{1}{2}, \frac{1}{2})

---------------------
Properties of Entropy
---------------------

Shannon derives a number of properties, some are listed here.

a. :math:`H = 0` if and only if :math:`p_i = 1` and all other probabilities are
:math:`0`.

b. Suppose we have a random variable with :math:`n` possibilities, the maximum
   of :math:`H` will be when :math:`p_i = \frac{1}{n}` for
   :math:`n \in \{ 0, 1, \dots, n - 1 \}`.

c. Suppose we have two random variables :math:`X` and :math:`Y` which have
   :math:`n` and :math:`m` possibilities respectively. Let
   :math:`P(X=x_i, Y=y_i) = p_{i, j}`. The entropy of this joint event is,

.. math::

    H(X, Y) = - \sum_{i, j} p_{i, j} \log p_{i, j}.

Also, 

.. math::

        H(X) = - \sum_{i, j} p_{i, j} \log \sum_{j} p_{i, j}, \\
        H(Y) = - \sum_{i, j} p_{i, j} \log \sum_{i} p_{i, j}.

It can also be shown that,

.. math::

    H(X, Y) \leq H(X) + H(Y) 

d. Suppose we have two random variables :math:`X` and :math:`Y` that are not
   necessarily independent. The conditional probability is defined as,

.. math::

    P(Y=y_i \vert X=x_i) = p_{y_i \vert x_i} = \frac{p_{x_i, y_j}}{\sum_{j} p_{x_i, y_j}}.

The conditional entropy is defined as,

.. math::

    H_{x_i}(Y) = - \sum_{i, j} p_{x_i, y_j} \log p_{y_i \vert x_i}

---------------------------------
Appendix: Entropy Property Proofs
---------------------------------

Proofs of the properties defined above.

^^^^^^^^^^
Property A
^^^^^^^^^^

Suppose we probabilities :math:`p = {p_0, p_1, \dots, p_{n_1}}` where
:math:`p_i = 1` and the rest of the probabilities are :math:`0`. For :math:`i`
we have,

.. math::

   p_i \log p_i = \log 1 = 0.

For :math:`j` where :math:`j \neq i`,

.. math::

   p_j \log p_j = 0 \log 0 = 0.

So every term in :math:`H` is zero so :math:`H = 0`.

^^^^^^^^^^
Property B
^^^^^^^^^^

This proof is taken from here
https://math.stackexchange.com/questions/3579001/prove-the-maximum-value-of-entropy-function.

Using Jensen's Inequality,

.. math::

    H(X) = & - \sum_{i} p_i \log p_i \\
         = & \sum_{i} p_i \log \frac{1}{p_i} \\
      \leq & \log \sum_{i} p_i \frac{1}{p_i} \\
         = & \log n.

By substituting in :math:`p_i = \frac{1}{n}` to the entropy formula we get,

.. math::

    H(x) = - \sum_{i} \frac{1}{n} \log \frac{1}{n} = \log n

Which is the upper bound.

^^^^^^^^^^
Property C
^^^^^^^^^^

This proof is taken from
https://math.stackexchange.com/questions/4153125/shannons-proof-that-joint-entropy-is-less-or-equal-to-the-sum-of-marginal-entro.

Shannon entropy is,

.. math::

    H(x) = - \sum_{i} p_i \log p_i.

Since we have joint probabilities we have :math:`p_i = \sum_{j} p_{i, j}`.
Substituting this into the entropy formula, we get,

.. math::

    H(x) = - \sum_{i, j} p_{i, j} \log \sum_j p_{i, j}.

Finally, again using Jensen's inequality,

.. math::

    \begin{align}
        H(X, Y) - H(X) - H(Y) &    = - \sum_{i, j} p_{i, j} \log p_{i, j} + \sum_{i, j} p_{i, j} \log \sum_k p_{i, k} + \sum_{i, j} p_{i, j} \log \sum_k p_{k, j} \\
                              &    = \sum_{i, j} p_{i, j} \log \frac{\sum_k p_{i, k} \sum_k p_{k, j}}{p_{i, j}} \\
                              & \leq \log \sum_{i, j} p_{i, j} \frac{\sum_k p_{i, k} \sum_k p_{k, j}}{p_{i, j}} \\
                              &    = \log \sum_{i, j} \sum_k p_{i, k} \sum_k p_{k, j} \\   
                              &    = \log 1 = 0
    \end{align}


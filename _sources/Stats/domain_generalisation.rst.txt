Domain Generalisation
=====================

This covers some causal approaches to domain generalisation.

Probable Domain Generalization via Quantile Risk Minimization
-------------------------------------------------------------

This is a brief summary of the paper *Probable Domain Generalization via
Quantile Risk Minimization* :cite:`eastwood2022probable`.

For a machine model to generalise to difference domains, it must perform well
across domains that it has not seen in its training set. For example, a model
train to classify medical images must perform well on images from hospitals
that are not in its training set. Machine learning usually relies on the IID
assumption that the test data will be sampled from the same distribution as the
training data, in reality this assumption is rarely met.

Typically, machine learning optimises for good average performance across all
domains.Suppose we have a set of :math:`n` environments :math:`e_{\text{all}} = \{e_1, e_2,
\dots, e_n\}` that contain data points :math:`(X_i^{e_j}, Y_i^{e_j})`. Let
:math:`R(f)^{e_j}` be the risk of using function :math:`f` in domain
:math:`e_j`. Risk could be something simple like mean squared error. The
average-case problem is formulated as follows:

.. math::

   \min_{f \in F} \mathbb{E}_{e \sim \mathbb{Q}} R^e(f)

Models the perform well on average lack robustness i.e. they can can perform
poorly on a large subset of environments. This has lead to some optimising for
the worst-case scenario where the function that performs the best on the
"hardest" environment is chosen.

.. math::

   \min_{f \in F} \max_{e \in e_{\text{all}}} R^e(f)

Optimising for the worst-case scenario can lead to models that are too
conservative especially if the harder environments are rare or unlikely.
:cite:t:`eastwood2022probable` acknowledge this by including the distribution
of environments in their optimisation.

.. math::

   \min_{f \in F} \underset{e \in \mathbb{Q}}{\text{ess sup }} R^e(f)
   \quad \text{where} \quad 
   \underset{e \in \mathbb{Q}}{\text{ess sup }} R^e(f)
   = \inf \{ t \geq 0: \Pr_{e \sim \mathbb{Q}} \{ R^e(f) \leq t \} = 1 \}

This optimisation uses the essential supremum from measure theory. Optimising
for the value of :math:`t` such the risk across all domains is **always** less
than or equal to :math:`t` may still be too conservative.
:cite:t:`eastwood2022probable` relax this by optimising so the risk is less
than equal to :math:`t` with probability :math:`\alpha`.

.. math::

   \min_{f \in F, t \in \mathbb{R}} \quad \text{subject to} \quad \Pr_{e \sim \mathbb{Q}} \{ R^e(f) \leq t \} \geq \alpha

Below is a diagram of what this optimisation may look like.

.. .. image:: Images/ess_sup.png
..    :width: 400

The distribution of environments :math:`\mathbb{Q}` in most situations is
impossible to determine. However, for each function :math:`f \in F` this
creates a distribution :math:`R^e(f)` for each environment :math:`e \sim
\mathbb{Q}`, we call this distribution :math:`\mathbb{T}_f`. To this end, the
optimisation problem can be rewritten as:

.. math::

   \min_{f \in F} F^{-1}_{\mathbb{T}_f}(\alpha)
   \quad \text{where} \quad
   F_{\mathbb{T}_f}^{-1}(\alpha) = \inf \{ t \in \mathbb{R} : \Pr_{R \sim \mathbb{T_f} } \{R \leq t \} \geq \alpha \}

Here, :math:`F_{\mathbb{T_f}^{-1}}(\alpha)` is the inverse CDF of the risk distribution :math:`\mathbb{T}_f`


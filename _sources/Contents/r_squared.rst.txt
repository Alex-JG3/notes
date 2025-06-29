R Squared
=========

R-Squared is a goodness of fit measure for regression models.

Definition
----------

Let :math:`f` be a regression model trained on
:math:`X = \{ X_1, X_2, \dots, X_n \}` to predict
:math:`y = \{ y_1, y_2, \dots, y_n \}`. The formula for r-squared is,

.. math::

   R^2 = 1 - \frac{RSS}{TSS}.

Where :math:`RSS` is the sum of squared residuals and :math:`TSS` is the total
sum of squares.

The sum of squared residuals is the total squared difference between
:math:`y_i` and the predictions from the model :math:`\hat{y}_i`.


.. math::

   RSS = \sum_{i = 0}^{n} (y_i - \hat{y}_i)^2.

The total sum of squares the total squared difference between :math:`y_i` and
the mean of :math:`y`.

.. math::

   TSS = \sum_{i = 0}^{n} (y_i - \bar{y})^2.

Interpretation
--------------

TSS can be thought of as the total error if we used the mean of :math:`y` as
our model. Whereas RSS is the total error using our actual model. The ratio
:math:`RSS / TSS` tells how much better (or worse) the model :math:`f` is
compared to just using the mean :math:`\bar{y}`.

If :math:`f` predicts :math:`y` better than :math:`\bar{y}` then the ratio
:math:`RSS / TSS` will be close to zero and :math:`R^2` will be close to 1.

If :math:`f` predicts :math:`y` worse than :math:`\bar{y}` then the ratio
:math:`RSS / TSS` will be greater than 1 and :math:`R^2` will be negative.

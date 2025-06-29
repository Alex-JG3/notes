Eigenvalues and Eigenvectors
============================

For a square matrix :math:`A`, its eigenvectors are vectors :math:`x` such
that,

.. math::

   Ax = \lambda x

Where :math:`\lambda \in R` is an eigenvalue of :math:`x`. In other words, the
eigenvectors of :math:`A` are vectors that when transformed by :math:`A` are
only scaled by some factor :math:`\lambda` rather than, for example, changing
direction.

Finding Eigenvalues and Eigenvectors
------------------------------------

In our equation above, there are two unknows: :math:`\lambda`, and :math:`x`.
Rearanging, some of the terms, we get,

.. math::

   (A - \lambda I) x = 0

Where :math:`I` is the identity matrix. If :math:`A - \lambda I` is invertible
then :math:`(A - \lambda I) ^ {-1} (A - \lambda I) x = (A - \lambda I) ^ {-1} 0
\implies x = 0`. Therefore, for :math:`x` to have a non-zero solution,
:math:`A - \lambda I` cannot be invertible, and thus,

.. math::

   \det (A - \lambda I) = 0

This gives a formula to find the eigenvalues of :math:`A` which can then be
substituted into :math:`(A - \lambda I) x = 0` to find the eigenvectors
:math:`x`.

Properties of Eigenvalues and Eigenvectors
------------------------------------------

Several properties of eigenvalues and eigenvectors.

* Squaring a square matrix :math:`A` squares its eigenvalues but its
  eigenvectors remain the same.
* The eigenvectors of a symmetric matrix are orthogonal. 
* A square matrix :math:`\mathbf{A}` is invertible IFF its columns are linearly
  independent.

Properties of Eigenvalues and Eigenvectors (Proofs)
---------------------------------------------------

* Squaring a square matrix :math:`A` squares its eigenvalues but its
  eigenvectors remain the same.

Suppose :math:`\mathbf{A}` has the eigenvector :math:`\mathbf{x}_i` and
eigenvalue :math:`\lambda_i`.

.. math::

   \mathbf{A} \mathbf{x}_i = \lambda_i \mathbf{x}_i \\
   \mathbf{A} \mathbf{A} \mathbf{x}_i = \lambda_i \mathbf{A} \mathbf{x}_i \\
   \mathbf{A}^2 \mathbf{x}_i = \lambda_i^2 \mathbf{\mathbf{x}}_i. \\
   
Thus, :math:`\mathbf{x}_i` is an eigenvector of :math:`\mathbf{A}` and
:math:`\mathbf{A}^2`. And :math:`\lambda_i` is an eigenvalue of
:math:`\mathbf{A}` but :math:`\lambda_i^2` is an eigenvalue of
:math:`\mathbf{A}^2`.

* The eigenvectors of a symmetric matrix are orthogonal. 

Suppose :math:`\mathbf{A}` is a two dimensional matrix with two eigenvectors
and two distinct eigenvalues.

.. math::

   A x_1 & = \lambda_1 x_1, \\
   x_2^T A x_1 & = \lambda_1 x_2^T x_1. \\

And,

.. math::

   A x_2 & = \lambda_2 x_2, & \\
   x_1^T A x_2 & = \lambda_2 x_1^T x_2, & \\
   x_2^T A^T x_1 & = \lambda_2 x_2^T x_1. & \\
   x_2^T A x_1 & = \lambda_2 x_2^T x_1. & \quad \text{(Symmetric)}\\

Taking both equations from each other, we get,

.. math::

   x_2^T A x_1 - x_2^T A x_1 & = (\lambda_2 - \lambda_1) x_2^T x_1^T \\
   0 & = (\lambda_2 - \lambda_1) x_2^T x_1^T

Since :math:`\lambda_1` and :math:`\lambda_2` are distinct,
:math:`(\lambda_2 - \lambda_1)` is non-zero, therefore,
:math:`x_2^T x_1^T` must be zero. Thus, :math:`x_2` and
:math:`x_1` are orthogonal.

The determinant of :math:`A` is the product of its eigenvalues
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The eigenvalues :math:`\lambda_1, \lambda_2, \dots, \lambda_n`, are the roots
of its characteristic polynomial.

.. math::

   \det (A - \lambda I) = (\lambda_1 - \lambda) (\lambda_2 - \lambda) \dots (\lambda_n - \lambda)

Setting :math:`\lambda` to :math:`0`, we get,

.. math::

   \det (A) = \lambda_1 \lambda_2 \dots \lambda_n 

The trace of :math:`A` is equal to the sum of its eigenvalues
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For this, we only prove for the :math:`2 \times 2` case. Let :math:`A` be the
following matrix,

.. math::

   A = \begin{pmatrix}
      a & b \\
      c & d \\
   \end{pmatrix}

Find the eigenvalues of :math:`A` using its charateristic polynomial.

.. math::

   \det (A - \lambda I) = (a - \lambda) (d - \lambda) - bc = \lambda ^ 2 - (a + d) \lambda - bc

Using the quatratic formula, we get,

.. math::

   \lambda = \frac{a + d \pm \sqrt{\ldots}}{2}

Therefore,

.. math::

   \lambda_1 + \lambda_2 = a + d

:math:`Ax = 0` has a non-trivial solution IFF the columns of :math:`A` are linearly independent
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Suppose the columns of :math:`A` are linearly independent. Let the vectors
:math:`v_1, v_2, \dots, v_n` be the columns of :math:`A`.

.. math::

   \mathbf{A} \mathbf{x} = \mathbf{0} \implies \begin{pmatrix}\mathbf{v}_1 & \mathbf{v}_2 & \dots & \mathbf{v}_n\end{pmatrix} \mathbf{x} = \mathbf{0}.

This can be rewritten as,

.. math::

   x_1 \mathbf{v}_1 + x_2 \mathbf{v}_2 + \dots + x_n \mathbf{v}_n = \mathbf{0}.

Since the columns of :math:`A` are linearly independent, some column
:math:`v_i` can be expressed as a combination of the other columns. Therefore,
there must be solution to the equation above where some of the scalars
:math:`x_1, x_2, \dots, x_n` are non-zero.

:math:`Ax = 0` has a non-trivial solution IFF :math:`A` is invertible
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. topic:: Theorem

   A square matrix :math:`\mathbf{A}` is invertible IFF its columns are linearly independent.

   **Proof**

   This proof is taken from https://sparse-plex.readthedocs.io/en/latest/book/matrices/invertible_matrices.html.

   *Step 1*. Suppose that :math:`\mathbf{A}` is invertible. By definition, the columns of :math:`\mathbf{A}` are linearly independent if :math:`\mathbf{A x} = \mathbf{0}` only when :math:`\mathbf{x} = \mathbf{0}`. Since :math:`A` has an inverse,

   .. math::
      \mathbf{A}^{-1} \mathbf{A x} = \mathbf{0} \implies \mathbf{x} = \mathbf{0}

   *Step 2*. If the columns of :math:`\mathbf{A}` are linearly independent, then :math:`\mathbf{A} \mathbf{x} = \mathbf{b}` has a unique solution. If :math:`\mathbf{A}` has an inverse then there exists a matrix :math:`\mathbf{B}` such that :math:`\mathbf{B A} = \mathbf{I}`. Suppose that :math:`e_i` represents the :math:`i`-th column of :math:`\mathbf{I}` such that the :math:`i`-th element of :math:`\mathbf{e}_i` is 1.

   .. math::
      \mathbf{AB} = 
      \begin{bmatrix}
          | & | & \dots & | \\
          \mathbf{AB}_1 & \mathbf{AB}_2 & \dots & \mathbf{AB}_n \\
          | & | & \dots & | \\
      \end{bmatrix}
      =
      \begin{bmatrix}
          | & | & \dots & | \\
          \mathbf{e}_1 & \mathbf{e}_2 & \dots & \mathbf{e}_n \\
          | & | & \dots & | \\
      \end{bmatrix}

   Since the columns of :math:`A` are linearly independent, :math:`\mathbf{AB}_i = \mathbf{e}_i` has a unique solution. Thus we can find each column :math:`\mathbf{B}_i` thus :math:`\mathbf{A}` is invertible.

.. topic:: Theorem

   A symmetric matrix :math:`\mathbf{A}` with distinct eigenvalues has orthogonal eigenvectors.

   **Proof**

   We only prove for the :math:`2 \times 2` case where :math:`\mathbf{A}` has two eigenvectors.

   .. math::

      \mathbf{A} \mathbf{x}_1 & = \lambda_1 \mathbf{x}_1 \\
      \mathbf{x}_2^T \mathbf{A} \mathbf{x}_1 & = \lambda_1 \mathbf{x}_2^T \mathbf{x}_1 \\

   And,

   .. math::

      \mathbf{A x}_2 & = \lambda_2 \mathbf{x}_2 \\
      \mathbf{x}_1^T \mathbf{A x}_2 & = \lambda_2 \mathbf{x}_1^T \mathbf{x}_2 \\
      \mathbf{x}_2^T \mathbf{A x}_1 & = \lambda_2 \mathbf{x}_2^T \mathbf{x}_1 \\

   Taking these away from each other, we have,

   .. math::

      \mathbf{x}_2^T \mathbf{A x}_1 - \mathbf{x}_2^T \mathbf{A x}_1 & = (\lambda_1 - \lambda_2) \mathbf{x}_2^T \mathbf{x}_1 \\
      0 & = (\lambda_1 - \lambda_2) \mathbf{x}_2^T \mathbf{x}_1

   Since :math:`\lambda_1` and :math:`\lambda_2` are distinct, their difference is non-zero. Therefore, :math:`\mathbf{x}_2^T \mathbf{x}_1` must be :math:`0`.

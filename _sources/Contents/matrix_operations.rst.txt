Matrix Operations
=================

A short summary of the properties of some matrix operations.

Transpose
---------

Suppose :math:`\mathbf{A}` and :math:`\mathbf{B}` are matrices and
:math:`\mathbf{x}` is a vector.

* :math:`(\mathbf{A} + \mathbf{B})^T = \mathbf{A}^T + \mathbf{B}^T`
* :math:`(\mathbf{A}^T)^T = \mathbf{A}`
* :math:`(\mathbf{A x})^T = \mathbf{x}^T \mathbf{A}^T`
* :math:`(\mathbf{x}_1^T \mathbf{A} \mathbf{x}_2)^T` = :math:`\mathbf{x}_1^T \mathbf{A}^T \mathbf{x}_2`

Transpose Proofs
----------------

* :math:`(\mathbf{A} + \mathbf{B})^T = \mathbf{A}^T + \mathbf{B}^T`

Let :math:`\mathbf{A}_i` and :math:`\mathbf{B}_i` be the :math:`i`-th column of
:math:`\mathbf{A}` and :math:`\mathbf{B}` respectively.

.. math::

   \newcommand{\vertbar}{\rule[-1ex]{1pt}{2.5ex}}
   \newcommand{\horzbar}{\rule[.5ex]{2.5ex}{1pt}}
   (\mathbf{A} + \mathbf{B})^T
   = & 
   \left(
   \begin{bmatrix}
       \vertbar     & \vertbar     & \dots & \vertbar     \\
       \mathbf{A}_1 & \mathbf{A}_2 & \dots & \mathbf{A}_n \\
       \vertbar     & \vertbar     & \dots & \vertbar     \\
   \end{bmatrix}
   + 
   \begin{bmatrix}
       \vertbar     & \vertbar     &\dots  & \vertbar     \\
       \mathbf{B}_1 & \mathbf{B}_2 & \dots & \mathbf{B}_n \\
       \vertbar     & \vertbar     & \dots & \vertbar     \\
   \end{bmatrix}
   \right)^T \\
   = &
   \begin{bmatrix}
       \vertbar  & \vertbar  & \dots & \vertbar  \\
       \mathbf{A}_1 + \mathbf{B}_1 & \mathbf{A}_2 + \mathbf{B}_2 & \dots & \mathbf{A}_n + \mathbf{B}_n \\
       \vertbar  & \vertbar  & \dots & \vertbar  \\
   \end{bmatrix}^T \\
   = &
   \begin{bmatrix}
       \horzbar & \mathbf{A}_1 + \mathbf{B}_1 & \horzbar \\
       \horzbar & \mathbf{A}_2 + \mathbf{B}_2 & \horzbar \\
       \vdots   & \vdots    & \vdots   \\
       \horzbar & \mathbf{A}_n + \mathbf{B}_n & \horzbar \\
   \end{bmatrix}^T.

And,

.. math::
  \mathbf{A}^T + \mathbf{B}^T
  = & 
  \begin{bmatrix}
      \horzbar & \mathbf{A}_1    & \horzbar \\
      \horzbar & \mathbf{A}_2    & \horzbar \\
      \vdots   & \vdots & \vdots   \\
      \horzbar & \mathbf{A}_n    & \horzbar \\
  \end{bmatrix}^T.
  + 
  \begin{bmatrix}
      \horzbar & \mathbf{B}_1    & \horzbar \\
      \horzbar & \mathbf{B}_2    & \horzbar \\
      \vdots   & \vdots & \vdots   \\
      \horzbar & \mathbf{B}_n    & \horzbar \\
  \end{bmatrix}^T.
  =
  \begin{bmatrix}
      \horzbar & \mathbf{A}_1 + \mathbf{B}_1 & \horzbar \\
      \horzbar & \mathbf{A}_2 + \mathbf{B}_2 & \horzbar \\
      \vdots   & \vdots & \vdots   \\
      \horzbar & \mathbf{A}_n + \mathbf{B}_n & \horzbar \\
  \end{bmatrix}^T.

End of proof.

* :math:`(\mathbf{A}^T)^T = \mathbf{A}`

.. math::

   (A^T)^T =
   \begin{bmatrix}
       \horzbar & \mathbf{A}_1    & \horzbar \\
       \horzbar & \mathbf{A}_2    & \horzbar \\
       \vdots  & \vdots  & \vdots   \\
       \horzbar & \mathbf{A}_n    & \horzbar \\
   \end{bmatrix}^T
   =
   \begin{bmatrix}
       \vertbar     & \vertbar     & \dots & \vertbar     \\
       \mathbf{A}_1 & \mathbf{A}_2 & \dots & \mathbf{A}_n \\
       \vertbar     & \vertbar     & \dots & \vertbar     \\
   \end{bmatrix}
   = \mathbf{A}

End of proof.

* :math:`(\mathbf{A} \mathbf{x})^T = \mathbf{x}^T \mathbf{A}^T`

Let :math:`\mathbf{A}_i` be the :math:`i`-th row.

.. math::

   (\mathbf{A} \mathbf{x})^T
   =
   \begin{bmatrix}
       \mathbf{A}_1 \mathbf{x} \\
       \mathbf{A}_2 \mathbf{x} \\
       \vdots \\
       \mathbf{A}_n \mathbf{x} \\
   \end{bmatrix}^T
   =
   \begin{bmatrix}
       \mathbf{A}_1 \mathbf{x} &
       \mathbf{A}_2 \mathbf{x} &
       \dots &
       \mathbf{A}_n \mathbf{x}
   \end{bmatrix}

And,

.. math::

   \mathbf{x}^T \mathbf{A}^T
   =
   \mathbf{x}^T
   \begin{bmatrix}
       \vertbar       & \vertbar       & \dots & \vertbar       \\
       \mathbf{A}_1   & \mathbf{A}_2   & \dots & \mathbf{A}_n   \\
       \vertbar       & \vertbar       & \dots & \vertbar       \\
   \end{bmatrix}
   =
   \begin{bmatrix}
       \mathbf{A}_1 \mathbf{x} &
       \mathbf{A}_2 \mathbf{x} &
       \dots &
       \mathbf{A}_n \mathbf{x}
   \end{bmatrix}

End of proof.

* :math:`\mathbf{x}_1^T \mathbf{A} \mathbf{x}_2` = :math:`\mathbf{x}_2^T \mathbf{A} \mathbf{x}_1`

Let :math:`\mathbf{A}_i` be the :math:`i`-th row of :math:`\mathbf{A}`.

.. math::

   \begin{bmatrix}
       \horzbar & \mathbf{x}_1 & \horzbar 
   \end{bmatrix}
   \begin{bmatrix}
       \horzbar       & \mathbf{A}_1   & \horzbar \\
       \horzbar       & \mathbf{A}_2   & \horzbar \\
       \vdots         & \vdots         & \vdots   \\
       \horzbar       & \mathbf{A}_n   & \horzbar \\
   \end{bmatrix}
   \begin{bmatrix}
       \vertbar \\ \mathbf{x}_2 \\ \vertbar 
   \end{bmatrix}
   & = 
   \begin{bmatrix}
       \horzbar & \mathbf{x}_1 & \horzbar 
   \end{bmatrix}
   \begin{bmatrix}
       \mathbf{A}_1 \mathbf{x_2} \\
       \mathbf{A}_2 \mathbf{x_2} \\
       \vdots       \\
       \mathbf{A}_n \mathbf{x_2} \\
   \end{bmatrix} \\
   & =
   \begin{bmatrix}
       \mathbf{A}_1 \mathbf{x_2} &
       \mathbf{A}_2 \mathbf{x_2} &
       \dots       &
       \mathbf{A}_n \mathbf{x_2} &
   \end{bmatrix}
   \begin{bmatrix}
       \vertbar \\ \mathbf{x}_1 \\ \vertbar 
   \end{bmatrix} \\
   & =
   \begin{bmatrix}
       \horzbar & \mathbf{x}_2 & \horzbar 
   \end{bmatrix}
   \begin{bmatrix}
       \vertbar       & \vertbar       & \dots & \vertbar       \\
       \mathbf{A}_1   & \mathbf{A}_2   & \dots & \mathbf{A}_n   \\
       \vertbar       & \vertbar       & \dots & \vertbar       \\
   \end{bmatrix}
   \begin{bmatrix}
       \vertbar \\ \mathbf{x}_1 \\ \vertbar 
   \end{bmatrix} \\
   & =
   \mathbf{x}_2^T \mathbf{A} \mathbf{x}_1

========
N-Queens
========

---------------------------
Bitwise Operators in Python
---------------------------

One can get the binary string for an integer using f-strings.

.. code::

   >>> f"1:b"
   1
   >>> f"2:b"
   10
   >>> f"3:b"
   11
   >>> f"4:b"
   100
   >>> f"9:b"
   1001

When reading the binary representation, start from the right. So,
:code:`1001` is :code:`1 + 8`.

There are several bitwise operators in python. Here are some examples for the
`and` and `or` operators.

.. code::

   >>> x = 3; print(f"{x:b}")
   '11'
   >>> y = 5; print(f"{y:b}")
   '101'
   >>> f"x|y : {x|y} : {x|y:b}"
   'x|y : 7 : 111'
   >>> f"x&y : {x&y} : {x&y:b}"
   'x&y : 1 : 1'

The operators are for shifting bits left and right: :code:`x << y` shifts
:code:`x`'s bits to the *left* by :code:`y` places, and :code:`x << y` shifts
:code:`x`'s bits to the *right* by :code:`y` places.

.. code::

   >>> x = 3; print(f"{x:b}")
   '11'
   >>> f"{x << 1:b}"
   '110'
   >>> f"{x << 2:b}"
   '1100'
   >>> f"{x >> 1:b}"
   '1'
   >>> f"{x >> 2:b}"
   '0'

------------------------------------
Solving N-Queens in a Functional Way
------------------------------------

In the cpython testing suite, there is a class for solving the N-Queens problem
called :code:`Queens`.

.. code::

   class Queens:
       def __init__(self, n):
           self.n = n
           rangen = range(n)
   
           # Assign a unique int to each column and diagonal.
           # columns:  n of those, range(n).
           # NW-SE diagonals: 2n-1 of these, i-j unique and invariant along
           # each, smallest i-j is 0-(n-1) = 1-n, so add n-1 to shift to 0-
           # based.
           # NE-SW diagonals: 2n-1 of these, i+j unique and invariant along
           # each, smallest i+j is 0, largest is 2n-2.
   
           # For each square, compute a bit vector of the columns and
           # diagonals it covers, and for each row compute a function that
           # generates the possibilities for the columns in that row.
           self.rowgenerators = []
           for i in rangen:
               rowuses = [(1 << j) |                  # column ordinal
                          (1 << (n + i-j + n-1)) |    # NW-SE ordinal
                          (1 << (n + 2*n-1 + i+j))    # NE-SW ordinal
                               for j in rangen]
   
               def rowgen(rowuses=rowuses):
                   for j in rangen:
                       uses = rowuses[j]
                       if uses & self.used == 0:
                           self.used |= uses
                           yield j
                           self.used &= ~uses
   
               self.rowgenerators.append(rowgen)
   
       # Generate solutions.
       def solve(self):
           self.used = 0
           for row2col in conjoin(self.rowgenerators):
               yield row2col
   
       def printsolution(self, row2col):
           n = self.n
           assert n == len(row2col)
           sep = "+" + "-+" * n
           print(sep)
           for i in range(n):
               squares = [" " for j in range(n)]
               squares[row2col[i]] = "Q"
               print("|" + "|".join(squares) + "|")
               print(sep)

Let us talk through how this code works. The constructor has the argument
:code:`n` which is the size of the board. A list called :code:`rowgenerators`
is then created which stores the columns, and diagonals that are covered by
each square. The columns/diagonals covered by each square are stored as a
binary strings created in the :code:`rowuses` list comprehension.

-----------------------------------------
Representing the board in :code:`rowuses`
-----------------------------------------

The :code:`rowuses` variable is a list where each element represents the
columns, NE-SW, and NW-SE diagonals that are covered by each square in the row.
The coverage of each square is encoded in a binary string. Let us breakdown the
operations that make these strings by first looking at an example. Let us look
at the output for the first row when :code:`n` is 4.

.. code::

   >>> n = 4
   >>> i = 0
   >>> rowuses = [
   ... (1 << j) |
   ... (1 << (n + i-j + n-1)) |
   ... (1 << (n + 2*n-1 + i+j))
   ... for j in rangen]
   >>> rowuses = [2177, 4162, 8228, 16408]

The list :code:`rowuses` is a list of seemingly random integers. These integers
represent the columns and diagonals that each square in the first row cover.
Look at the binary representation of the first number.

.. code::

   >>> f"{2177:b}"
   '100010000001'

This string contains has three 1's. The top left square covers 1 column, 1
NW-SE diagonal, and 1 NE-SW diagonal. Perhaps each of these 1's represent the
columns and diagonals? In fact, the right most digit is a 1, perhaps this means
the first column is covered?

We have a few ideas so let us breakdown what each term in the list
comprehension does.

-----------------------
Term 1 :code:`(1 << j)`
-----------------------

In the comment, it says the first term is for the column ordinal. In other
words, the first term deals with representing the columns that are covered. Let
us check the values of :code:`(1 << j)` for the different values of :code:`j`.

.. code::

   >>> f"{1 << 0:b}"
   1
   >>> f"{1 << 1:b}"
   10
   >>> f"{1 << 2:b}"
   100
   >>> f"{1 << 3:b}"
   1000

These binary strings are used to represent covers columns 1, 2, 3, and 4
respectively. In the binary for the top left square, :code:`100010000001`, the
1 on the right tells us this square covers the first column.

-----------------------------------
Term 2 :code:`(1 << n + i-j + n-1)`
-----------------------------------

This term handles the NW-SE diagonals. Recall the comment about the NW-SE
diagonals.

.. code::

   # NW-SE diagonals: 2n-1 of these, i-j unique and invariant along
   # each, smallest i-j is 0-(n-1) = 1-n, so add n-1 to shift to 0-
   # based.

Let us break down each part of this comment. There are :code:`2n-1` NW-SE
diagonals. There are :code:`n-1` NW-SE diagonals that start on the left side of
the board (not including the diagonal) and there are :code:`n-1` NW-SE
diagonals that start along the top of the board (not including the diagonal).
Including the diagonal, we have :code:`n-1 + n-1 + 1 = 2n-1` NW-SE diagonals.

Taking the column index :code:`j` from the row index :code:`i` gives a unique
integer for each diagonal that does not change along the diagonal. Let us write
out :code:`i-j` for :code:`n` is :code:`4`.

+----+----+----+----+
|  0 | -1 | -2 | -3 |
+----+----+----+----+
|  1 |  0 | -1 | -2 |
+----+----+----+----+
|  2 |  1 |  0 | -1 |
+----+----+----+----+
|  3 |  2 |  1 |  0 |
+----+----+----+----+

There is a unique integer for each NW-SE diagonal and the integer does not
change along the diagonal. Negative integers are handled slightly differently
in python, so to keep everything simple add a buffer of :code:`n-1`. Doing
this, the matrix becomes.

+----+----+----+----+
|  3 |  2 |  1 |  0 |
+----+----+----+----+
|  4 |  3 |  2 |  1 |
+----+----+----+----+
|  5 |  4 |  3 |  2 |
+----+----+----+----+
|  6 |  5 |  4 |  3 |
+----+----+----+----+

So, in :code:`1 << n + i-j + n-1`, the term :code:`i-j` uniquely represents the
NW-SE diagonal that the square covers and :code:`n-1` is used to make the
negative :code:`i-j`'s positive. So what does the final :code:`n` do? The final
:code:`n` is to make sure the digits from the :code:`1 << j` term are not
overwritten.

So, :code:`i << n + i-j + n-1` turns on the bit which uniquely represents the
NW-SE diagonal that the square covers without overwriting the bit which covers
the column the square covers.

What is the minimum value of :code:`1 << n + i-j + n-1`? The minimum value
occurs when :code:`i` and :code:`j` are zero. When :code:`n` is :code:`4`, this
means,

.. code::

   >>> f"{1 << 4 + 0 - 0 + 3 << 0:b}"
   '10000000'

Including the first term, we get,

.. code::

   >>> f"{1 << 0 | 1 << 4 + 0 - 0 + 3 << 0:b}"
   '10000001'

The :code:`1` on the right represents the first column being covered, the
:code:`1` on the left represents the main diagonal being covered.

---------------------------------------
Term 3 :code:`(1 << (n + 2*n-1 + i+j))`
---------------------------------------

Term 3 is very similar to term 2. This term covers the NE-SW diagonals. Recall
the comment for these diagonals.

.. code::

   # NE-SW diagonals: 2n-1 of these, i+j unique and invariant along
   # each, smallest i+j is 0, largest is 2n-2.

By the same logic as before, there are :code:`2n-1` NE-SW diagonals. Let us
write out the :code:`i + j` terms when :code:`n` is 4.


+----+----+----+----+
|  0 |  1 |  2 |  3 |
+----+----+----+----+
|  1 |  2 |  3 |  4 |
+----+----+----+----+
|  2 |  3 |  4 |  5 |
+----+----+----+----+
|  3 |  4 |  5 |  6 |
+----+----+----+----+

Each NE-SW diagonal is represented by a unique integer. All these integers are
positive, so we do not have to add :code:`n-1` like before. So, in term 3,
:code:`i+j` is used to uniquely identify the NE-SW diagonal.

We still need to make sure we do not overwrite the :code:`1`'s from term 1 and
term 2. This is done by adding :code:`n + 2*n-1` to :code:`i+j`. Similar to
before :code:`n` ensures we do not overwrite the bits from term 1, but what
about :code:`2*n-1`?

From term 2, the maximum value of :code:`i-j + n-1` is :code:`n-1 - 0 + n-1 =
2*n-2`. So, adding :code:`2*n-1` ensures that we do not overwrite the :code:`1`
from term 2.

-------------------------
The :code:`rowgen` Method
-------------------------

Recall the :code:`rowgen` method.

.. code::

   def rowgen(rowuses=rowuses):
       for j in rangen:
           uses = rowuses[j]
           if uses & self.used == 0:
               self.used |= uses
               yield j
               self.used &= ~uses

The argument for :code:`rowgen` is :code:`rowuses` which is the list of
integers integer that encode the columns, NW-SE diagonals, and NE-SW diagonals
that each square in the row covers. The method is also a *generator function*
since it uses the :code:`yield` keyword.

This method changes the attribute :code:`self.used` which is uninitialised in
:code:`__init__`. This variable is not initialised until :code:`solve` is
called. The :code:`self.used` is another integer which encodes the columns,
NE-SW, and NW-SE diagonals that are covered in the current solution.

So what does this method do?

1. Iterates through each square in the row. Squares are referred to by their
   column index :code:`j`.
2. Checks if the square, :code:`j`, is covered by some other queen in the
   solution.
3. If the square, :code:`j` is not covered, add a queen there and thus add the
   columns, NE-SW, and NW-SE diagonals covered by `j` to the covered squares in
   :code:`self.used`.
4. Yield :code:`j`.
5. After :code:`j` is yielded, remove the columns, NE-SW, and NW-SE diagonals
   covered by :code:`j` from the covered columns and diagonals in
   :code:`self.used`.
6. Try the next square and see if a queen can be put in it.
7. Repeat from step 2.

The row generators for each row are stored in a list.

---------------------
Finding the Solutions
---------------------

Solutions are found in the :code:`solve` method. Recall the :code:`solve`
method.

.. code::

   # Generate solutions.
   def solve(self):
       self.used = 0
       for row2col in conjoin(self.rowgenerators):
           yield row2col

This method is very short. In fact it implements a backtracking method to find
the solutions using the :code:`conjoin` method. In the same
:code:`Lib/test/test_generators.py` script there is simplified :code:`conjoin`
method. This method does the same thing as :code:`conjoin` but, as the name
suggests, in a simpler way; so we will limit our discussion to
:code:`simple_conjoin`.

.. code::

   def simple_conjoin(gs):

       values = [None] * len(gs)
   
       def gen(i):
           if i >= len(gs):
               yield values
           else:
               for values[i] in gs[i]():
                   for x in gen(i+1):
                       yield x
   
       for x in gen(0):
           yield x

:code:`simple_conjoin` takes a list of generator functions as arguments. It
then dynamically iterates through the iterators. We limit our discussion to
just our N-queens problem. 

So, :code:`gs` is our list of row generators which iterators through the
columns of a row and yield :code:`j` if a queen can be put in the :code:`j`-th
column given the current solution. For a 4x4 N-queens grid there will be 4
elements in :code:`gs` - one for each row.

The variables :code:`values` is a list of :code:`n` integers, where :code:`n`
is the number of number of rows in the grid.

The :code:`gen` method recursively iterates through every row and tests every
possible solution. The :code:`rowuses` generators will only return an integer
if the queen can be put on the :code:`i`-th square without affecting the other
solutions.

Since :code:`values` stores, the current solution let's add a couple of print
statements, and track the solutions.

.. code::

   def simple_conjoin(gs):

       values = [None] * len(gs)
   
       def gen(i):
           if i >= len(gs):
               print("'values' when 'values' is yielded: ", values)
               yield values
           else:
               for values[i] in gs[i]():
                   for x in gen(i+1):
                       print("'values' when 'x' is yielded: ", values)
                       yield x
   
       for x in gen(0):
           yield x

And we replace :code:`conjoin` with :code:`simple_conjoin` in the :code:`solve`
method. Let us calculate the case for :code:`n` is 4.

.. code::

   >>> [sol for sol in Queens(4).solve()]
   'values' before 'x' is yielded:  [0, None, None, None]
   'values' before 'x' is yielded:  [0, 2, None, None]
   'values' before 'x' is yielded:  [0, 3, None, None]
   'values' before 'x' is yielded:  [0, 3, 1, None]
   'values' before 'x' is yielded:  [1, 3, 1, None]
   'values' before 'x' is yielded:  [1, 3, 1, None]
   'values' before 'x' is yielded:  [1, 3, 0, None]
   'values' before 'x' is yielded:  [1, 3, 0, 2]
   'values' when 'values' is yielded:  [1, 3, 0, 2]
   'values' before 'x' is yielded:  [2, 3, 0, 2]
   'values' before 'x' is yielded:  [2, 0, 0, 2]
   'values' before 'x' is yielded:  [2, 0, 3, 2]
   'values' before 'x' is yielded:  [2, 0, 3, 1]
   'values' when 'values' is yielded:  [2, 0, 3, 1]
   'values' before 'x' is yielded:  [3, 0, 3, 1]
   'values' before 'x' is yielded:  [3, 0, 3, 1]
   'values' before 'x' is yielded:  [3, 0, 2, 1]
   'values' before 'x' is yielded:  [3, 1, 2, 1]
   [[3, 1, 2, 1], [3, 1, 2, 1]]
   >>>

Let us walk through a few of these steps.

.. code::

   [0, None, None, None]  # Queen in top left corner
   [0, 2, None, None]     # 1-st row queen in 2-nd column not 1-st due to diagonal
   [0, 3, None, None]     # With [0, 2, None, None] cannot put queen on second row
   [0, 3, 1, None]          
   [1, 3, 1, None]        # No solution so move queen in 0-th column
   [1, 3, 1, None]        # Conflict in 2-nd col so move it
   [1, 3, 0, None]
   [1, 3, 0, 2]
   [1, 3, 0, 2]           # Solution!
   [2, 3, 0, 2]           # Incremenet the first column so start next solution ...
   [2, 0, 0, 2]
   [2, 0, 3, 2]
   [2, 0, 3, 1]
   [2, 0, 3, 1]
   [3, 0, 3, 1]
   [3, 0, 3, 1]
   [3, 0, 2, 1]
   [3, 1, 2, 1]

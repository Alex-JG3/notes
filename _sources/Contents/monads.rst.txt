Monads
======

I am going to explain the monads by an example. Suppose we want to have some
dataset that we want to train a machine learning on. To get good performance
with the model, the dataset requires several preprocessing steps. We are not
certain which order the preprocessing steps should happen to get the best
performance and we are not certain of the best hyper parameters at each step.

We need a way to make the preprocessing pipeline highly configurable without
having to rewrite the steps of the pipeline each time. Monads one way to
organise these pipelines.

-------------
A Basic Monad
-------------

A monad is a class where each method of the class returns a new instance of the
class. This allows functions to be easily chained together.

.. code:: python

   class BasicMonad
       def __init__(self, x):
           self.x = x

       def add_one(self):
           return self.x + 1

       def take_one(self):
           return self.x - 1

       def multiply_by_two(self):
           return 2 * self.x

An example of using the monad:

.. code:: python

   >>> BasicMonad(1).add_one().add_one().multiply_by_two().x
   6

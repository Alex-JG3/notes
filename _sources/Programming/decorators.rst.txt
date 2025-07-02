==========
Decorators
==========

Decorators allow you to modify the behaviour of a callable. Decorators are
themselves a callable that takes a callable as an input and return a callable.
Let us build some decorator intuition through some simple examples.

Suppose we have a function that prints a string.

.. code-block:: python

   def my_func():
       print("Function")

.. code-block::

   >>>my_func()
   My function

Python treats functions as objects mean we can create another function that
accepts :code:`my_func` as an argument.

.. code-block:: python

   def wrapper(func):
       print("Decorator")
       return func

   def my_func():
       print("Function")

Above, we created a new function called :code:`wrapper` which accepts a
function as an argument, prints :code:`Decorator` then returns the function.
Remember functions are objects so we can assign the function returned from
:code:`wrapper` to a new variable.

.. code-block::

   >>>new_func = wrapper(my_func)
   >>>new_func()
   Decorator
   Function

Above, we assign the callable object to the variable :code:`new_func` then we
call :code:`new_func`. This first prints :code:`Decorator` which is from the
:code:`wrapper` function, then it prints :code:`Function` which is from the
:code:`my_func` function. So we have used :code:`wrapper` to modify the
behaviour of :code:`my_func` without modifying :code:`my_func` itself.

Decorators essentially give us some syntax sugar to do this exact thing. In
fact :code:`wrapper` is a valid decorator.

.. code-block:: python

   def wrapper(func):
       print("Decorator")
       return func

   @wrapper
   def my_func():
       print("Function")


.. code-block::

   >>>my_func
   Decorator
   Function

We have now decorated :code:`my_func` with the :code:`wrapper` decorator.

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Passing Arguments to Decorators
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The arguments of decorated functions can be passed to the decorator. One reason
you may want to do this is to validate the arguments passed to a function
before the function is executed. Let us create a simple addition function and
use a decorator to check the input arguments are integers.

.. code-block:: python

   def check_arguments(func):
       def inner(a, b):
           if isinstance(int, a) and isinstance(int, b):
               return func(a, b)
           else:
               raise TypeError("Inputs must be integers")
       return inner

   @check_arguments
   def add_integers(a: int, b: int) -> int:
       return a + b

The decorator function :code:`check_arguments` contains a nested function
:code:`inner` takes the arguments from function being decorated. The function
:code:`check_arguments` then returns the callable :code:`inner`.

.. code-block::

   >>>add_integers(1, 2):
   3
   >>>add_integers("1", 2):
   ...
   TypeError: Inputs must be integers

^^^^^^^^^^^^^^^^^^
Example Decorators
^^^^^^^^^^^^^^^^^^

Here are some simple example decorators.

---------------------
Check Dictionary Keys
---------------------

Suppose we have a function that takes a dictionary as an argument. We can
create a decorator that makes sure the dictionary has the correct keys.

.. code-block:: python

   class CheckDictKeys:
       def __init__(self, dict_arg_name, allowed_keys):
           self.dict_arg_name = dict_arg_name
           self.allowed_keys = allowed_keys

       def __call__(func):
           def inner(*args, **kwargs):
           try:
               dictionary = kwargs[self.dict_arg_name]
           except KeyError:
               arg_names = inspect.getfullargspec(func).args
               arg_index = arg_names.index(self.dict_arg_name)
               dictionary = args[arg_index]

           missing_keys = [
               key for key in dictionary.keys() if key not in self.allowed_keys
           ]
           if missing_keys:
               msg = f"Dictionary is missing these keys: {missing_keys}"
               raise RuntimeError(msg)

           return func(*args, **kwargs)

    @CheckDictKeys("dictionary", ["key1", "key2", "key3"])
    def add_dict_values(dictionary: dict):
        total = 0
        for value in dictionary.values():
            total += value
        return total

We have created a decorator called :code:`CheckDictKeys` that will check if a
named dictionary contains the allowed keys. If any of the allowed keys are
missing, a :code:`RuntimeError` is raised.

.. code-block::

   >>>add_dict_values({"key1": 1, "key2": 2, "key3": 3})
   6
   >>>add_dict_values({"key1": 1, "key2": 2})
   ...
   RuntimeError: Dictionary is missing these keys: ['key3']


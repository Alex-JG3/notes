The Python Import System
========================

    Main takeaways:

    * Suppose we have a directory called :code:`root` with the following files:
      :code:`package/module.py`, and :code:`package/script.py`.
    * From inside :code:`root`, running :code:`python3 package/script.py` will
      add :code:`package` to :code:`sys.path` meaning :code:`from package
      import module` will raise an import error in :code:`script.py`.
    * From inside :code:`root`, running :code:`python3 -m package.script` will
      add :code:`root` to :code:`sys.path` meaning :code:`from package import
      module` will not raise an import error in :code:`script.py`

When importing a package or module, python searches for it on its
:code:`sys.path`. Suppose we have the following project structure.

.. code::

   root
   └── package
       ├── module.py
       └── script.py

Where :code:`module.py` contains the following code.

.. code::

   def print_module():
       print("Print from module.py")

And :code:`script.py` has the following code.

.. code::

   from package.directory import module

   print_module()

Executing :code:`script.py` from :code:`root` gives us an import error.

.. code::

   $ python3 package/script.py
   Traceback (most recent call last):
     File "/home/alex/root/package/script.py", line 1, in <module>
       from package.directory import module
   ModuleNotFoundError: No module named 'package'

Even though we are running the code from the :code:`root` directory which
contains :code:`package`, we cannot import :code:`module` into
:code:`script.py`. Let us print :code:`sys.path` at the top of
:code:`script.py` and rerun the script.

.. code::

   # script.py
   import sys; print(sys.path)
   from package import module

   print_module()

Running :code:`script.py`, we get.

.. code::

   $ python3 package/script.py
   ['/home/alex/root/package', '/usr/lib/python310.zip', '/usr/lib/python3.10', '/usr/lib/python3.10/lib-dynload', '/home/alex/documents/notes/.venv/lib/python3.10/site-packages']
   Traceback (most recent call last):
     File "/home/alex/root/package/script.py", line 2, in <module>
       from package.directory import module
   ModuleNotFoundError: No module named 'package'

The first element in the list points to our :code:`package` directory. This
means that python will look for :code:`package` within the :code:`package`
directory. We want it to look for :code:`package` for the :code:`root`
directory.

This import error can also be solved by removing :code:`package` from the
import path.

.. code::

   # script.py
   import module

   module.print_module()

The code now runs successfully from :code:`root`.

.. code::

   $ python3 package/script.py
   Print from module.py

However, if we move :code:`script.py` into :code:`root` we will get the same
import error again. For clarity, moving :code:`script.py` into :code:`root`
means our file structure now looks like this.

.. code::

   root
   ├── script.py
   └── package
       └── module.py

Executing :code:`script.py` results in the import error.

.. code::

   $ python3 script.py
   Traceback (most recent call last):
     File "/home/alex/root/script.py", line 1, in <module>
       import module
   ModuleNotFoundError: No module named 'module'

To get the script to run successfully, we would have to change our import from
:code:`import module` to :code:`from package import module`.

For simplicity, I want to be able to import :code:`package.module` into a
script no matter where the script is in the :code:`root` directory. We will
discuss three ways of doing this but first let us change our project structure
slightly to include :code:`script1.py` and :code:`script2.py`.

.. code::

   root
   ├── script1.py
   └── package
       ├── script2.py
       └── module.py

Where :code:`script1.py` and :code:`script2.py` have just about the same code.

.. code::

   # script1.py
   from package import module

   module.print_module()

.. code::

   # script2.py
   from package import module

   module.print_module()

The first script, :code:`script1.py`, runs successfully but :code:`script2.py`
does not.

.. code::

   $ python3 script1.py
   Print from module.py
   $ python3 package/script2.py
   python3: can't open file '/home/alex/root/script2.py': [Errno 2] No such file or directory

Now we will run through three ways of solving this issue.

Running Scripts and Modules
---------------------------

The :code:`-m` flag can be used to run our program as a module instead of a
script. This will make both of :code:`script1.py` and :code:`script2.py` work. 

.. code::

   $ python3 -m script1
   Print from module.py
   $ python3 -m module.script2
   Print from module.py

Let us run this experiment again but print :code:`sys.path` at the start of the
scripts.

.. code::

   # script1.py
   import sys; print(sys.path)
   from package import module

   module.print_module()

.. code::

   # script2.py
   import sys; print(sys.path)
   from package import module

   module.print_module()

Running the scripts gives us the following.

.. code::

   $ python3 -m package.script2
   ['/home/alex/root', '/usr/lib/python310.zip', '/usr/lib/python3.10', '/usr/lib/python3.10/lib-dynload', '/home/alex/documents/notes/.venv/lib/python3.10/site-packages']
   Print from module.py
   $ python3 -m script1
   ['/home/alex/root', '/usr/lib/python310.zip', '/usr/lib/python3.10', '/usr/lib/python3.10/lib-dynload', '/home/alex/documents/notes/.venv/lib/python3.10/site-packages']
   Print from module.py

Running the scripts with :code:`-m` flag adds the :code:`root` directory to
:code:`sys.path`. If we :code:`cd` into :code:`package` and run
:code:`script2.py` we get the familiar import error.

.. code::

   $ cd package
   $ python3 -m script2
   ['/home/alex/root/package', '/usr/lib/python310.zip', '/usr/lib/python3.10', '/usr/lib/python3.10/lib-dynload', '/home/alex/documents/notes/.venv/lib/python3.10/site-packages']
   Traceback (most recent call last):
     File "/usr/lib/python3.10/runpy.py", line 196, in _run_module_as_main
       return _run_code(code, main_globals, None,
     File "/usr/lib/python3.10/runpy.py", line 86, in _run_code
       exec(code, run_globals)
     File "/home/alex/root/package/script2.py", line 2, in <module>
       from package import module
   ModuleNotFoundError: No module named 'package'

So, as long as we run our scripts from :code:`root` with the :code:`-m` flag,
we should be able to import :code:`package.module` since :code:`root` has been
added to :code:`sys.path`.

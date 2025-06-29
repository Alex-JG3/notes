====
Bash
====

Quick reference for Bash scripting.

^^^^^^^^^^
Data Types
^^^^^^^^^^

By default, bash treats all variables as character strings. Depending on the
context in which the variables are used affects whether bash interprets the
variables as integers, strings, booleans, or arrays.

.. code-block:: console

   $ A="1"; B="2"
   $ X="Hello"; Y="World"
   $ echo "${A} ${B}"
   1 2
   $ echo "${X} ${Y}"
   Hello World
   $ echo $((${A} + ${B}))
   3
   $ echo $((${X} + ${Y}))
   0

Expressions written inside :code:`(())` are evaluated as mathematical
expressions. Note that adding the strings :code:`"Hello"` and :code:`World`
returns :code:`0`.

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Square Brackets (The Test Command)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Square brackets are referred to as the test command and are used to test if the
statement within the brackets are true are true of false.

.. code-block:: bash

    if [ "a" = "a" ]; then echo "True"; else echo "False"; fi    # True
    if [ "a" = "b" ]; then echo "True"; else echo "False"; fi    # False
    if [ "aa" = "aa" ]; then echo "True"; else echo "False"; fi  # False

    X=3
    Y=5

    # Less than or equal to
    if [ $X -le $Y ]; then echo "True"; else echo "False"; fi    # True

    # Greater than or equal to
    if [ $X -ge $Y ]; then echo "True"; else echo "False"; fi    # False

    # Less than
    if [ $X -lt $Y ]; then echo "True"; else echo "False"; fi    # True

    # Greater than
    if [ $X -gt $Y ]; then echo "True"; else echo "False"; fi    # False

^^^^^^^^^
For Loops
^^^^^^^^^

For loops can be defined over a list of items.

.. code-block:: bash

    # Integer items
    for i in 1 2 3
    do
        echo "This is element $i"
    done

    # String items
    for item in "item 1" "item 2" "item 3"
    do
        echo "$item"
    done

Braces can be used to define ranges, :code:`{x..y}`. Note that ranges are
inclusive so :code:`x` and :code:`y` are included in the range.

.. code-block:: bash

    # 0, 1, 2, 3, 4, 4
    for i in {0..5}
    do
        echo "Item $i"
    done

    # 0, 2, 4, 6, 8
    for i in {0..10..2}
    do
        echo "Item $i"
    done

^^^^^^^^^^^^^^^^^^^
Parameter Expansion
^^^^^^^^^^^^^^^^^^^

In shell scripts, the value of a parameter can be substituted into into a
string using the :code:`${variable_name}` syntax.

.. code:: console

   $ X="Hello this is some text."
   $ echo "${X}"
   Hello this is some text.

Parameter expansions allows us to add characters inside the curly braces to
change value that is substituted.

:code:`${parameter:-word}`
    If parameter is unset or null, substitute :code:`word` instead.

    .. code:: console

       $ X="Hello"
       $ echo "${X:-"Word"}"
       Hello
       $ echo "${Y:-"Word"}"
       Word
       $ X=
       $ echo "${X:-"Word"}"
       Word

:code:`${parameter:offset:length}`
    Expands the substring of the value of :code:`parameter` that starts at
    :code:`offset` and has length `length`:

    .. code:: console

       $ X="Hello"
       $ echo "${X:1:3}"
       ell
       $ echo "${X:1}"
       ello

Single vs Double Quotes
-----------------------

Single quotes can be used to avoid treat characters literally.

.. code:: console

   $ x="a"
   $ echo "x: ${x}"
   x: a
   $ echo 'x: ${x}'
   x: ${x}

Single vs Double Quotes in PS1
------------------------------

The :code:`PS1` variable can be changed to customise the command prompt.
Unfortunately, single and double quotes behaviour slightly differently here.

.. code:: console

   $ PS1="$(pwd) $ "
   /home/alex $ cd documents
   /home/alex $ pwd
   /home/alex/documents

Above the :code:`PS1` is changed to show the working directory at the start of
the prompt followed by a :code:`$`. Unfortunately, changing into the
:code:`documents` directory does not update the prompt even :code:`pwd` shows
that the directory has been changed.

If single quotes are used instead of double quotes, we get the expected
behaviour.

.. code:: console

   $ PS1='$(pwd) $ '
   /home/alex $ cd documents
   /home/alex/documents $ pwd
   /home/alex/documents
   /home/alex/documents $ ..
   /home/alex $

According to this stackoverflow thread
https://stackoverflow.com/questions/23879159/how-can-this-ps1-variable-be-defined-in-single-quotes,
this is special behaviour for the :code:`PS1` variable. Every time a new prompt
is generated (for example by changing directory) using single quotes will
expand the substitution. However, when double quotes are used, the substitution
is expanded when :code:`PS1` is defined and thus will not update.

Not also even though single quotes are used, the :code:`$`, :code:`(`, and
:code:`)` are not treated literally.

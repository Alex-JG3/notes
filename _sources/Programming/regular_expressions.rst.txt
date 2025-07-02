===================
Regular Expressions
===================

A regular expression (often shortened to regex) is a sequence of characters
that can be used to search for patterns of text. Regexes appear all over the
place. This article covers some of the basic syntax.

Regex in Python
---------------

The python standard library has the :code:`re` module for working with regular
expressions. :code:`re.match` finds patterns in text strings.

.. doctest::

   >>> import re
   >>> text = "Hello, World!"
   >>> re.search("Hello", text)
   <re.Match object; span=(0, 5), match='Hello'>
   >>> re.search("Hello", text).span()
   (0, 5)
   >>> re.search("ll", text)
   <re.Match object; span=(2, 4), match='ll'>

If the pattern is present in the text, :code:`re.search` returns a
:code:`re.Match` object. You can retrieve the start and end point of the match
using the :code:`span` method. If the pattern is not present in the string,
:code:`re.search` returns :code:`None`.

.. doctest::

   >>> import re
   >>> text = "Hello, World!"
   >>> re.search("Random", text)
   >>> print(re.match("Random", text))
   None

Regex provides a rich syntax for matching complex patterns. For example,
:code:`+` matches to one or more repetition of the preceding character.

.. doctest::

   >>> import re
   >>> text = "Hello, World!"
   >>> re.search("l+", "Hello, World")
   <re.Match object; span=(2, 4), match='ll'>
   >>> re.search("l+", "Helllo, World")
   <re.Match object; span=(2, 5), match='lll'>
   >>> re.search("l+", "Hellllo, World")
   <re.Match object; span=(2, 6), match='llll'>

:code:`re.search` does not match the second :code:`l`

The second :code:`l` in :code:`World` is not matched because :code:`re.search`
only matches the first instance of the pattern. :code:`re.finall` matches all
instances of the pattern and returns the matches in a list.

.. doctest::

   >>> import re
   >>> text = "Hello, World!"
   >>> re.findall("l+", "Hello, World")
   ['ll', 'l']

Quantifiers
-----------

Quantifiers specify how many instanstances of a character or group must be
present for a match to be found.

.. list-table::
   :header-rows: 1

   * - Quantifier
     - Description

   * - :code:`*`
     - Matches zero or more repetitions of the preceding character.

   * - :code:`+`
     - Matches one or more repetitions of the preceding character.

   * - :code:`?`
     - Matches zero or one repetitions of the preceding character.

   * - :code:`{n}`
     - Matches exactly :code:`n` repetitions of the preceding character.

   * - :code:`{n,}`
     - Matches at least :code:`n` repetitions of the preceding character.

   * - :code:`{n,m}`
     - Matches between :code:`n` and :code:`m` repetitions of the preceding
       character.

Below are examples of each quantifier.

.. doctest::

   >>> import re
   >>> text = "Hello, Mel, Ankle"
   >>> re.findall("el+", "Hello, Mel, eat")
   ['ell', 'el']
   >>> re.findall("el?", "Hello, Mel, eat")
   ['el', 'el', 'e']
   >>> re.findall("el*", "Hello, Mel, eat")
   ['ell', 'el', 'e']
   >>> re.findall("el{2}", "Hello, Mel, eat")
   ['ell']
   >>> re.findall("el{1,}", "Hello, Mel, eat")
   ['ell', 'el']

Regex Syntax
------------

:code:`.`
    Matches any single character other than the newline character (:code:`\n`).

    .. code-block:: python

       >>> bool(re.match(r"H.llo", "Hello, World!"))
       True
       >>> bool(re.match(r"H.llo", "Hxllo, World!"))
       True
       >>> bool(re.match(r"H.llo", "Hxxllo, World!"))
       False
       >>> bool(re.match(r"H.llo", "H\nllo, World!"))
       False


:code:`?`
    Matches the previous regex for 0 or 1 repetitions.

    .. code-block:: python

       >>> bool(re.match(r"He?llo", "Hello, World!"))
       True
       >>> bool(re.match(r"He?llo", "Hllo, World!"))
       True
       >>> bool(re.match(r"He?llo", "Heello, World!"))
       False
       >>> bool(re.match(r"He?llo", "Hxllo, World!"))
       False

:code:`+`
    Matches the previous regex for 1 or more repetitions.

    .. code-block:: python

       >>> bool(re.match(r"He+llo", "Hello, World!"))
       True
       >>> bool(re.match(r"He+llo", "Heeello, World!"))
       True
       >>> bool(re.match(r"He+llo", "Hllo, World!"))
       False

:code:`*`
    Matches the previous regex for 0 or more repetitions.

    .. code-block:: python

       >>> bool(re.match(r"He*llo", "Hello, World!"))
       True
       >>> bool(re.match(r"He*llo", "Heeello, World!"))
       True
       >>> bool(re.match(r"He*llo", "Hllo, World!"))
       True

:code:`^`
    Matches the start of the string.

    .. code-block:: python

       >>> bool(re.match(r"^Hello", "Hello, World!"))
       True
       >>> bool(re.match(r"^World", "Heeello, World!"))
       False

:code:`$`
    Matches the end of the string.

    .. code-block:: python

       >>> bool(re.match(r"foo$", "foobar"))
       False
       >>> bool(re.match(r"bar$", "foobar"))
       False
       >>> bool(re.match(r"foobar$", "foobar"))
       True

:code:`{m,n}`
    Match next :code:`m` to :code:`n` characters to previous regex.

    .. code-block:: python

       >>> bool(re.match(r"He{3}llo", "Hello, World!"))
       False
       >>> bool(re.match(r"He{3}llo", "Heeello, World!"))
       True
       >>> bool(re.match(r"He{2,3}llo", "Heello, World!"))
       True
       >>> bool(re.match(r"He{2,3}llo", "Heeello, World!"))
       True
       >>> bool(re.match(r"He{2,3}llo", "Heeeello, World!"))
       False

:code:`[]`
    Used to define character sets.

    .. code-block:: python

       >>> # Match 6 chars to chars 'f', 'o', 'b', 'a', and 'r'
       >>> bool(re.match(r"[fobar]{6}", "foobar"))
       True
       >>> bool(re.match(r"[fobar]{6}", "fo3bar"))
       False
       >>> # Match 6 chars to chars 'a' to 'z'
       >>> bool(re.match(r"[a-z]{6}", "foobar"))
       True
       >>> bool(re.match(r"[a-z]{6}", "fo3bar"))
       False
       >>> # Match 6 chars to chars 'a' to 'z' or '1' to '9'
       >>> bool(re.match(r"[a-z1-9]{6}", "fo3bar"))
       True
       >>> # Match 6 chars to chars 'A' to 'Z'
       >>> bool(re.match(r"[A-Z]{6}", "foobar"))
       False
       >>> # Match 6 chars to chars 'A' to 'Z'
       >>> bool(re.match(r"[A-Z]{6}", "FOOBAR"))
       True

:code:`()`
    Used to define groups.

    .. code-block:: python

       >>> # Matches to 'a' or 'bc'
       >>> bool(re.match(r"(a|bc)", "a"))
       True
       >>> bool(re.match(r"(a|bc)", "b"))
       True
       >>> bool(re.match(r"(a|bc)", "d"))
       False

^^^^
Grep
^^^^

Grep is a program common on most Unix-like systems. It is used for finding
patterns in text. Suppose the file :code:`text.txt` contains the follow text.

.. code-block:: console

   Line 1
   Line 2
   This is the final line

Here are some examples of how to use grep.

.. code-block:: console

   $ grep This text.txt
   Line 1
   Line 2
   $ grep --invert-match This text.txt
   This is the final line
   $ grep --ignore-case this text.text
   This is the final line
   $ grep --file=text.txt --regexp=Line
   Line 1
   Line 2
   $ grep --count Line text.txt
   2
   $ grep ^Line (1|2) file1.txt
   zsh: no matches found: (1|2)
   $ grep "^Line (1|2)" file1.txt
   $ grep -E "^Line (1|2)" file1.txt
   Line 1
   Line 2

-------------------
Grep Multiple Files
-------------------

Suppose we have the following directory structure.

.. code-block:: console

   directory
      file1.txt
      file2.txt

Suppose :code:`directory/file1.txt` has the following text.

.. code-block:: console

   Line 1 in file1
   Line 2 in file1
   This is the final line in file 1

And :code:`directory/file2.txt` has the following text.

.. code-block:: console

   Line 1 in file2
   Line 2 in file2
   This is the final line in file 2

We can grep patterns in multiple files.

.. code-block:: console

   $ grep Line directory/*.txt
   file1.txt:Line 1 in file1
   file1.txt:Line 2 in file1
   file2.txt:Line 1 in file2
   file2.txt:Line 2 in file2
   $ grep Line --recursive directory
   file1.txt:Line 1 in file1
   file1.txt:Line 2 in file1
   file2.txt:Line 1 in file2
   file2.txt:Line 2 in file2


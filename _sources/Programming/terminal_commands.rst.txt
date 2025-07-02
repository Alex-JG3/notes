=================
Terminal Commands
=================

.. role:: bash(code)
   :language: bash

:bash:`mv <source> <destination>`
    Move and optionally rename file or directory.

    :bash:`-f, --force`
        Do not prompt before overwrite. Not safe so use carefully.

    :bash:`-i, --interactive`
        Interactive mode. Prompt before overwrite.

    :bash:`-n, --no-clobber`
        Do not overwrite an existing file. Do not prompt if a move has been
        skipped to avoid overwrite.

    If more than one of :bash:`-f`, :bash:`-i`, and :bash:`-n` only the final
    one will take effect.

    :bash:`mv <source> .`
        Move :bash:`<source>` to current directory.

    **TIP:** In most cases use :bash:`-i` to avoid overwriting unintended
    existing files.

---------------------------------------

:bash:`su <username>`
    Switch the current user to :bash:`<username>`.


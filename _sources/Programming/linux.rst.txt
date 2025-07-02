Linux
=====

This article contains some random useful information on using Linux.

The APT Package Manager
-----------------------

The Advanced Package Tool (APT) is a command-line package manager used in
Debian-based Linux distributions like Ubuntu.

Keeping Packages Up to Date
^^^^^^^^^^^^^^^^^^^^^^^^^^^

To update APT's package index, run the following command:

.. code::

   sudo apt update

This will not update any installed packages, it will only update the package
index. To update your installed packages with the new versions in the package
index, use the following command:

.. code::

   sudo apt upgrade

Installing New Packages
^^^^^^^^^^^^^^^^^^^^^^^

New packages can be installed with :code:`apt install`. For example:


.. code::

   sudo apt install python3.10

You may find that your package is not available in APT's package indexes in
which case you may need to find another package index.

For example, as of writing (2025-05-27), python 3.12 is not available on the
APT package index as shown below:

.. code::

   $ sudo apt install python3.12
   Reading package lists... Done
   Building dependency tree... Done
   Reading state information... Done
   E: Unable to locate package python3.12
   E: Couldn't find any package by glob 'python3.12'

Personal package archives (PPAs) are repositories that allow individuals or
teams to share software with others. The Deadsnakes PPA provides recent
versions of python including 3.12. You can add the deadsnakes PPA with the
:code:`add-apt-repository` command as follows:

.. code::

   sudo add-apt-repository ppa:deadsnakes/ppa
   sudo apt update

Now, :code:`sudo apt install python3.12` should work as expected.

Removing Packages
^^^^^^^^^^^^^^^^^

There are several ways to remove packages with the :code:`apt` package manager.
We will cover :code:`apt remove`, :code:`apt purge` and :code:`apt autoremove`.
First we install :code:`htop` so we can later uninstall it.

.. code::

   $ sudo apt install htop
   Reading package lists... Done
   Building dependency tree... Done
   Reading state information... Done
   The following additional packages will be installed:
     libnl-3-200 libnl-genl-3-200
   Suggested packages:
     lm-sensors
   The following NEW packages will be installed:
     htop libnl-3-200 libnl-genl-3-200
   0 upgraded, 3 newly installed, 0 to remove and 0 not upgraded.
   Need to get 200 kB of archives.
   After this operation, 589 kB of additional disk space will be used.
   Do you want to continue? [Y/n] y
   Get:1 http://archive.ubuntu.com/ubuntu jammy/main amd64 libnl-3-200 amd64 3.5.0-0.1 [59.1 kB]
   Get:2 http://archive.ubuntu.com/ubuntu jammy/main amd64 libnl-genl-3-200 amd64 3.5.0-0.1 [12.4 kB]
   Get:3 http://archive.ubuntu.com/ubuntu jammy/main amd64 htop amd64 3.0.5-7build2 [128 kB]
   Fetched 200 kB in 1s (192 kB/s)
   Selecting previously unselected package libnl-3-200:amd64.
   (Reading database ... 48924 files and directories currently installed.)
   Preparing to unpack .../libnl-3-200_3.5.0-0.1_amd64.deb ...
   Unpacking libnl-3-200:amd64 (3.5.0-0.1) ...
   Selecting previously unselected package libnl-genl-3-200:amd64.
   Preparing to unpack .../libnl-genl-3-200_3.5.0-0.1_amd64.deb ...
   Unpacking libnl-genl-3-200:amd64 (3.5.0-0.1) ...
   Selecting previously unselected package htop.
   Preparing to unpack .../htop_3.0.5-7build2_amd64.deb ...
   Unpacking htop (3.0.5-7build2) ...
   Setting up libnl-3-200:amd64 (3.5.0-0.1) ...
   Setting up libnl-genl-3-200:amd64 (3.5.0-0.1) ...
   Setting up htop (3.0.5-7build2) ...
   Processing triggers for man-db (2.10.2-1) ...
   Processing triggers for mailcap (3.70+nmu1ubuntu1) ...
   Processing triggers for hicolor-icon-theme (0.17-2) ...
   Processing triggers for libc-bin (2.35-0ubuntu3.10) ...

This installed :code:`htop` and two other dependencies :code:`libnl-3-200`
:code:`libnl-genl-3-200`. The :code:`apt remove htop` command will remove
all packaged data but leave behind configuration files. The :code:`apt purge
htop` command will remove the configuration files as well.

.. code::

   $ sudo apt remove htop
   Reading package lists... Done
   Building dependency tree... Done
   Reading state information... Done
   The following packages were automatically installed and are no longer required:
     libnl-3-200 libnl-genl-3-200
   Use 'sudo apt autoremove' to remove them.
   The following packages will be REMOVED:
     htop
   0 upgraded, 0 newly installed, 1 to remove and 0 not upgraded.
   After this operation, 342 kB disk space will be freed.
   Do you want to continue? [Y/n] y
   (Reading database ... 48945 files and directories currently installed.)
   Removing htop (3.0.5-7build2) ...
   Processing triggers for man-db (2.10.2-1) ...
   Processing triggers for mailcap (3.70+nmu1ubuntu1) ...
   Processing triggers for hicolor-icon-theme (0.17-2) ...

The dependencies :code:`libnl-3-200` and :code:`libnl-genl-3-200` were not
removed. We can show these packages are still present by grepping the
:code:`apt list` command.

.. code::

   $ apt list | grep -E "(libnl-3-200|libnl-genl-3-200)"

   WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

   libnl-3-200-dbg/jammy 3.5.0-0.1 amd64
   libnl-3-200/jammy,now 3.5.0-0.1 amd64 [installed,auto-removable]
   libnl-genl-3-200/jammy,now 3.5.0-0.1 amd64 [installed,auto-removable]

Removing :code:`htop` means these dependencies are no longer needed. We can
remove these packages that are dependencies of other software with the
:code:`apt autoremove` command.

.. code::

   $ sudo apt autoremove
   Reading package lists... Done
   Building dependency tree... Done
   Reading state information... Done
   The following packages will be REMOVED:
     libnl-3-200 libnl-genl-3-200
   0 upgraded, 0 newly installed, 2 to remove and 0 not upgraded.
   After this operation, 247 kB disk space will be freed.
   Do you want to continue? [Y/n] y
   (Reading database ... 48935 files and directories currently installed.)
   Removing libnl-genl-3-200:amd64 (3.5.0-0.1) ...
   Removing libnl-3-200:amd64 (3.5.0-0.1) ...
   Processing triggers for libc-bin (2.35-0ubuntu3.10) ...

We could have combined the remove and autoremove commands into one line as
follows:

.. code::

   $ sudo apt remove htop && sudo apt autoremove

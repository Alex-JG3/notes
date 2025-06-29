Dockerfile
==========

A :code:`Dockerfile` is used to write instructions to build an image.

A :code:`Dockerfile` must start with a :code:`FROM` instruction

Environment Variables
~~~~~~~~~~~~~~~~~~~~~

Environment variables are declared with the :code:`ENV` statement. Environment
variables are initialised and referred to using the following syntax.

.. code:: docker

   ENV x=1
   RUN echo $x
   RUN echo ${x}

Curly braces are optional when referring to an environment variable.

Creating Users
~~~~~~~~~~~~~~

Usually, it is recommended to execute commands in a docker container as the
root user. Creating and managing users can differ between operating systems, so
for the time being, we limit ourselves to Linux.

To create a new user in Linux, we use the :code:`useradd` command.

.. code:: docker

   FROM python:3.10-slim-buster

   # Create user called dev_user 
   RUN useradd --create-home --shell /bin/bash dev_user

   # Switch to dev_user
   USER dev_user
   WORKDIR /home/dev_user


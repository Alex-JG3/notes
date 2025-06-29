Docker
======

Some short notes on using docker to create reproducible dev environments.

What is a Docker Image?
-----------------------

A docker image can be thought of as a snapshot of a read-only virtual machine
that contains everything needed to create a runnable virtual machine.

Docker images come in all shapes and sizes and can be downloaded from Docker
hub which is a huge online repository for Docker images. For example, the
Docker image for Ubuntu can be downloaded using
:code:`docker pull <image-name>`.

.. code-block:: console

   $ docker pull ubuntu
   Using default tag: latest
   latest: Pulling from library/ubuntu
   e96e057aae67: Pull complete
   Digest: sha256:4b1d0c4a2d2aaf63b37111f34eb9fa89fa1bf53dd6e4ca954d47caebca4005c2
   Status: Downloaded newer image for ubuntu:latest
   docker.io/library/ubuntu:latest

The images you have downloaded can be listed using :code:`docker images`.

.. code-block:: console

   $ docker images
   REPOSITORY   TAG      IMAGE ID       CREATED       SIZE
   ubuntu       latest   a8780b506fa4   8 days ago    77.8MB

Again, Docker images are read only. We use :code:`docker run` to create a
Docker container from the images which is essentially a runnable virtual
machine.

Docker Python Dev Environment
-------------------------------

On Docker Hub there are a number of python images on Docker hub. The
:code:`python:3.10-slim-buster` includes a minimal linux virtual machine with
python already installed. In this section, we will discuss how to use this
image to create a simple development environment.

TLDR
~~~~

To create an interactive shell from the :code:`python:3.10-slim-buster` image,
use the following command.

.. code-block:: console

   $ docker run -itd 3.10-slim-buster
   38e12b993c037e2447cd63d4d7e5cb64d9c4c03e0df37041136627daab0db222
   $ docker ps
   CONTAINER ID   IMAGE                     COMMAND     CREATED          STATUS          PORTS     NAMES
   38e12b993c03   python:3.10-slim-buster   "python3"   33 seconds ago   Up 31 seconds             condescending_galois
   $ docker exec -it 38e12 /bin/bash
   root@38e12b993c03:/# python
   Python 3.10.8 (main, Oct 25 2022, 05:40:26) [GCC 8.3.0] on linux
   Type "help", "copyright", "credits" or "license" for more information.
   >>>

Above, we created a docker container with ID :code:`38e12`. We then list the
running containers. Then we execute bash inside the container which gives us an
interactive shell from which we can run python.

This gives us a basic python environment inside a docker container. 

In the next few sections, we explore the run command and its flags more deeply.

Explore Docker Run
~~~~~~~~~~~~~~~~~~

Docker run lets you run a command in a new container [DRUN]_.

.. code-block:: console

    $ docker run [OPTIONS] IMAGE [COMMAND] [ARG...] 

Docker run first buts the container from an image and then executes a command.
For example, we can write hello world to the console after the container has
been built.

.. code-block:: console

    $ docker run python:3.10-slim-buster echo Hello, World!
    Hello, World!

We can use :code:`docker ps` to list all the running containers and
:code:`docker ps -a` to list all containers including those that have been
stopped.

.. code-block:: console

    $ docker ps
    CONTAINER ID   IMAGE   COMMAND   CREATED    STATUS   PORTS   NAMES
    $ docker ps -a
    CONTAINER ID   IMAGE                     COMMAND               CREATED         STATUS                     PORTS     NAMES
    e6289b05d40d   python:3.10-slim-buster   "echo Hello, World!"   4 minutes ago   Exited (0) 4 minutes ago             quirky_varahamihira

The container exited as soon as the command :code:`echo Hello, World` was
executed. We can execute any shell command here, in-fact we can start a bash
shell.

.. code-block:: console

    $ docker run python:3.10-slim-buster /bin/bash
    $ docker ps -a
    CONTAINER ID   IMAGE                     COMMAND       CREATED              STATUS                          PORTS     NAMES
    7677b3ae48c8   python:3.10-slim-buster   "/bin/bash"   6 seconds ago   Exited (0) 4 seconds ago             competent_jennings

However, we see that the shell exits instantly. We need a way to keep the
container running such that we can give input to the shell. We can do this
using interactive mode.

Exlore Interactive Mode
~~~~~~~~~~~~~~~~~~~~~~~

Interactive mode keeps the standard input (:code:`STDIN`) of a container open
and allows us to execute commands in the container. Containers can be run in
interactive mode by using the :code:`-i` or :code:`--interactive` flags.

.. code-block:: console

   $ docker run -i python:3.10-slim-buster /bin/bash
   ls
   bin
   boot
   dev
   etc
   home
   lib
   lib64
   media
   mnt
   opt
   proc
   root
   run
   sbin
   srv
   sys
   tmp
   usr
   var

Running the command above puts us in a bash shell withing the container that we
can interactive with. For example, above we executed the :code:`ls` command
which lists the files and directories of the current directory.

This shell may not look familiar, to get a more familiar shell, we have to
allocate a TTY to the container using the :code:`-t` flag.

.. code-block:: console

   $ docker run -it python:3.10-slim-buster /bin/bash
   docker run -it python:3.10-slim-buster /bin/bash
   root@c6b8389f4237:/# ls
   bin   dev  home  lib64  mnt  proc  run   srv  tmp  var
   boot  etc  lib   media  opt  root  sbin  sys  usr
   root@c6b8389f4237:/# exit
   $ docker ps -a
   CONTAINER ID   IMAGE                     COMMAND       CREATED              STATUS                      PORTS     NAMES
   c6b8389f4237   python:3.10-slim-buster   "/bin/bash"   About a minute ago   Exited (0) 55 seconds ago             fervent_merkle

The :code:`-t` flag gives a more familiar shell. Note however that when we exit
the container, we see the container also stopped. To prevent this, we run the
container in detached mode.

Exlore Detached Mode
~~~~~~~~~~~~~~~~~~~~

By default, :code:`docker run` runs a container in foreground mode. This means
that when the containers command has been executed, the container is stopped.
We can run the container in the background by using the :code:`-d` flag.

.. code-block:: console

   $ docker run -it python:3.10-slim-buster
   85ad08af58b567f35ca367b67f5ab09ba7d454e0506c9952c8cc06902f3ed496
   $ docker ps
   CONTAINER ID   IMAGE                     COMMAND     CREATED         STATUS         PORTS     NAMES
   85ad08af58b5   python:3.10-slim-buster   "python3"   2 minutes ago   Up 2 minutes             determined_chatelet

Here, the :code:`docker run` command returns the ID of the container and from
:code:`docker ps`, we see the container is running. Note, we have not included
the :code:`/bin/bash` command here.

So, we have a container that is running in the background but we have not been
put into a shell in the container. To create a shell in the container, we use
the :code:`docker exec` command.

.. code-block:: console

   $ docker exec -it 85ad /bin/bash
   root@85ad08af58b5:/# echo Hello, World!
   Hello, World!
   root@85ad08af58b5:/# python
   Python 3.10.8 (main, Oct 25 2022, 05:40:26) [GCC 8.3.0] on linux
   Type "help", "copyright", "credits" or "license" for more information.
   >>>

We give :code:`docker exec` flags :code:`-it` which, like before, runs the
command interactively with a pseudo TTY. We then give the ID of the container
we want the command to be executed in and finally the command
:code:`/bin/bash` itself. This starts an interactive bash shell that we can use
for development.

When we exit the shell, the container will still be running in the background.
To stop the container, use the :code:`docker stop` command.

Volumes
-------

Suppose you are are starting a project and you want to do your development
inside a docker container. You could create a container like in the previous
section and do everything inside the container. In particular you could store
the files for your project inside the docker container. However, getting the
files from the container onto the host machine can be tricky.

Alternatively, you could attach your project files to the container using a
volume. Think of this as sharing files and data between the host machine and
the container. This means any changes made to the volume files inside the
container will be reflected in the files on the host machine. Also, if the
container is stopped or deleted, the files still exist on the host machine so
no data will be lost. 

Suppose we have a simple project on our system with one file :code:`main.py`.

.. code-block:: console

   $ pwd
   /home/user/my_project
   $ ls
   main.py

The file :code:`main.py` is a simple script that prints some text.

.. code-block:: python

   # main.py
   print("This is main.py")

Let us create a python docker container and attach the :code:`my_project`
directory to the container. This is done with the :code:`-v` flag.


.. code-block:: console

   $ docker run -itd -v /home/user/my_project:/my_project python:3.10-slim-buster
   1f181219691a3837f1830db590e88d8f1644be251b5915687db523096dff93fc

The argument passed to :code:`-v` contains two paths. The first path before the
colon is the path to the directory (or file) on the host machine that we want
to attach to the container. The second path after the colon is the path to the
location where we want the directory (or file) to be stored in the docker
container.

Now, if we execute bash in the container, we should be able to navigate to our
:code:`main.py` file.

.. code-block:: console

   $ docker exec -it 1f18 /bin/bash
   root@1f181219691a:/# cd /my_project
   root@1f181219691a:/my_project# ls
   main.py
   root@1f181219691a:/my_project# python main.py
   This is main.py
   root@1f181219691a:/my_project# touch created_in_container.py
   root@1f181219691a:/my_project# ls
   created_in_container.py  main.py
   root@1f181219691a:/my_project# exit
   $ docker stop 1f18
   1f18
   $ docker rm 1f18 
   1f18

Above, we navigate to the :code:`/my_project` directory and run the
:code:`main.py` script. We also create a new file called
:code:`created_in_container.py` from within the container and exit the
container. Finally we stop and delete the container.

Since we attached the :code:`my_project` directory to the container using
volumes, the :code:`created_in_container.py` file will exist on the host
machine.

.. code-block:: console

   $ cd /home/user/my_project
   $ ls
   created_in_container.py  main.py

Despite having stopped and deleted the container used to create
:code:`created_in_container.py`, the file still exists on the host machine. One
can use volumes to attached many files to a container such that changes made
inside the container are reflected on the host machine.

.. [DRUN] https://docs.docker.com/engine/reference/commandline/run/


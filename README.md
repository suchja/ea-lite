## About
This image, based on [suchja/wine](https://hub.docker.com/r/suchja/wine/), provides you with the latest version of Enterprise Architect Lite from Sparx Systems (see http://www.sparxsystems.com/products/ea/index.html). The *Lite* Version of *Enterprise Architect* can only read UML-Models created with another version of Enterprise Architect.

**ATTENTION:** Using this image requires you to download around 770MB. (Of course this depends on which images you have already donwloaded)

## Usage
This image is based on [suchja/x11client](https://hub.docker.com/r/suchja/x11client/), which allows you to run the container on any host (locally or remote) and get the display via VNC. For this to work, you first need to run a container from [suchja/x11server](https://hub.docker.com/r/suchja/x11server/):

`docker run -d --name display -e VNC_PASSWORD=password -p 5900:5900 suchja/x11server`

After the X11Server is started, you can connect your VNC-client against it. For security reasons you should change the password provided to the environment variable `VNC_PASSWORD`.

Now you simply run a container from the `suchja/ea-lite` image in interactive mode, bind-mount a host directory with your EA-model and type `ealite` on the command prompt. Here is an example:

`docker run --rm -it -v $(pwd):/home/xclient/model --link display:xserver --volumes-from display ealite /bin/bash`

This will bind mount your current host directory (which should contain a model) into the image. Once you start *Enterprise Architect Lite*, you will be able to open the model.

## Problems
Please be aware that the base image [suchja/wine](https://hub.docker.com/r/suchja/wine/) currently has an issue when connecting to the X11Server the first time. The result is that you might get an error message when executing `ealite` the first time. If this happens, just type the command again and everything should be fine.

## Copyright free
The sources in [this](https://github.com/suchja/ea-lite) Github repository, from which the docker image is build, are copyright free (see LICENSE.md). Thus you are allowed to use these sources (e.g. Dockerfile and README.md) in which ever way you like.

Please be aware that other license terms apply for the application used inside the image (Enterprise Architect Lite).

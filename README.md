# BrewTroller Cloud Compiler Container

[![Build Status](https://travis-ci.org/BrewTroller/BTCompilerApplication.svg?branch=master)](https://travis-ci.org/BrewTroller/BTCompilerApplication)
[![Docker Build Status](https://img.shields.io/docker/build/brewtroller/btccs.svg)](https://hub.docker.com/r/brewtroller/btccs/)

A dockerized version of the BrewTroller Cloud Compiler Service.

### Build the container

After cloning this repository, use the command

```bash
$ cd BTCompilerApplication
$ docker build -t btccs:latest ./
```
to build the container. All necessary dependancies will be fetched automatically during the container build process.

### Setting up a local Dev environement

In order to use the compiler service during local development the following is required:

- Docker.
  - For linux, install using your distro's package manager
  - For Windows, use [Docker for Windows](https://docs.docker.com/docker-for-windows/)
  - For macOS, use [Docker for Mac](https://docs.docker.com/docker-for-mac/)
- Git
- BrewTroller Update

Setup:

1. Clone the BrewTroller code repository: `$ git clone https://github.com/BrewTroller/BrewTroller-Official`
2. Start a btccs container, pointing at your local BrewTroller source code: 

  ```bash
  $ docker run -d -v <absolute path to local brewtroller clone>:/localbt \
  -p 8080:8080 --entrypoint /var/BTCCS/BTCloudCompilerService btccs:latest \
  -git=/localbt -poll=0m30s
  ```
  Note: You can modify the rate at which the service will check your local clone of BrewTroller source for updates by changing the poll value passed to the container in the command above.

3. Point your copy of BrewTroller Update at your local BTCCS container. At this time the easiest way to accompilish this is to add an entry for build.brewtroller.net to your machine's hosts file, pointing to 127.0.0.1
4. Modify the local copy of the BrewTroller source code as required, commiting your changes locally. Any commits that you wish to make available to the BTCCS container need to be tagged with the format `vX.X.X` where X is any integer number.

### Using the container for local manual building

The container contains everything that is necessary to compile the BrewTroller firmware. Optionally, it can be used to compile the firmware locally, without using BrewTroller Update, and without installing all of the dependancies directly onto your local machine.

1. Start a container, with the directory of your local BrewTroller firmware code mounted inside the container:

```bash
$ docker run -it -v <absolute path to local brewtroller clone>:/localbt \
--entrypoint /bin/sh brewtroller/btccs:latest
```

2. From here, you can compile the firmware as you normally would, for example: 

```bash
$ cd /localbt
$ mkdir build
$ cd build
$ cmake -Dboard=BT_PHOENIX_SINGLE_VESSEL ../
$ make
```

3. If you compiled the firmware in the build directory, like in the example in step 2, the build products will be available in the build sub-directory of your local clone of the BrewTroller Firmware.

4. Once you are done, you can remove the the cloud compiler container from your system using the command: `docker rm -f $(docker ps -a -q -f "ancestor=brewtroller/btccs:latest")`
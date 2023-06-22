# :package:docker-ubuntu-sweb

[![Docker Pulls](https://img.shields.io/docker/pulls/atsushisaito/docker-ubuntu-sweb)](https://hub.docker.com/r/atsushisaito/docker-ubuntu-sweb)
[![example workflow](https://github.com/AtsushiSaito/docker-ubuntu-sweb/actions/workflows/build.yml/badge.svg)](https://github.com/AtsushiSaito/docker-ubuntu-sweb/actions)
[![Docker Automated build](https://img.shields.io/docker/automated/atsushisaito/docker-ubuntu-sweb)](https://hub.docker.com/r/atsushisaito/docker-ubuntu-sweb)
[![GitHub Repo stars](https://img.shields.io/github/stars/AtsushiSaito/docker-ubuntu-sweb?style=social)](https://github.com/AtsushiSaito/docker-ubuntu-sweb/stargazers)

Running Ubuntu x noVNC using Docker in a simple way:tada:

![Demo](https://github.com/AtsushiSaito/docker-ubuntu-sweb/blob/readme_assets/images/demo.gif?raw=true)

## Features

- Using MATE Desktop
- Automatic Window Resizing
- Clipboard Support (https://github.com/juanjoDiaz/noVNC)

## QuickStart

To start a Docker container and access `localhost:6080`.

use the following command. The default username and password are `ubuntu/ubuntu`.

```sh
# Ubuntu 20.04
docker run -p 6080:6080 --rm -it --privileged atsushisaito/docker-ubuntu-sweb:focal

# Ubuntu 22.04
docker run -p 6080:6080 --rm -it --privileged atsushisaito/docker-ubuntu-sweb:jammy
```

## Build

```sh
# Ubuntu 20.04
docker build -t docker-ubuntu-sweb:focal --build-arg TARGET_TAG=focal .
docker run -p 6080:6080 --rm -it --privileged docker-ubuntu-sweb:focal

# Ubuntu 22.04
docker build -t docker-ubuntu-sweb:jammy --build-arg TARGET_TAG=jammy .
docker run -p 6080:6080 --rm -it --privileged docker-ubuntu-sweb:jammy
```

# :package:docker-ubuntu-sweb

Running Ubuntu x noVNC using Docker in a simple way:tada:

![Demo](https://github.com/AtsushiSaito/docker-ubuntu-sweb/blob/readme_assets/images/demo.gif?raw=true)

## Features

- Adopt MATE Desktop
- Automatic window resizing feature
- Automatic clipboard feature (https://github.com/juanjoDiaz/noVNC)

## QuickStart

To start a Docker container and access `localhost:6080`.

use the following command. The default username and password are `ubuntu/ubuntu`.

```sh
# Ubuntu 20.04
docker run -p 6080:80 --rm -it --privileged atsushisaito/docker-ubuntu-sweb:focal

# Ubuntu 22.04
docker run -p 6080:80 --rm -it --privileged atsushisaito/docker-ubuntu-sweb:jammy
```

## Build

```sh
# Ubuntu 20.04
docker build -t docker-ubuntu-sweb:focal --build-arg BASE_IMAGE=ubuntu:focal .
docker run -p 6080:80 --rm -it --privileged docker-ubuntu-sweb:focal

# Ubuntu 22.04
docker build -t docker-ubuntu-sweb:jammy --build-arg BASE_IMAGE=ubuntu:jammy .
docker run -p 6080:80 --rm -it --privileged docker-ubuntu-sweb:jammy
```

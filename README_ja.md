# :package:docker-ubuntu-sweb

[![Docker Pulls](https://img.shields.io/docker/pulls/atsushisaito/docker-ubuntu-sweb)](https://hub.docker.com/r/atsushisaito/docker-ubuntu-sweb)
[![example workflow](https://github.com/AtsushiSaito/docker-ubuntu-sweb/actions/workflows/build.yml/badge.svg)](https://github.com/AtsushiSaito/docker-ubuntu-sweb/actions)
[![Docker Automated build](https://img.shields.io/docker/automated/atsushisaito/docker-ubuntu-sweb)](https://hub.docker.com/r/atsushisaito/docker-ubuntu-sweb)
[![GitHub Repo stars](https://img.shields.io/github/stars/AtsushiSaito/docker-ubuntu-sweb?style=social)](https://github.com/AtsushiSaito/docker-ubuntu-sweb/stargazers)

[English](README.md) | 日本語

Dockerを使用してUbuntu x noVNCを簡単に実行するプロジェクト:tada:

![Demo](https://github.com/AtsushiSaito/docker-ubuntu-sweb/blob/readme_assets/images/demo.gif?raw=true)

## 特徴

- MATEデスクトップを採用
- 自動ウィンドウリサイズ機能
- 試験的にクリップボードサポート (https://github.com/juanjoDiaz/noVNC)

## クイックスタート

以下のコマンドでDockerコンテナを起動し、`localhost:6080`にアクセスします。  
デフォルトのユーザー名とパスワードは`ubuntu/ubuntu`です。

```sh
# Ubuntu 20.04
docker run -p 6080:80 --rm -it --privileged atsushisaito/docker-ubuntu-sweb:focal

# Ubuntu 22.04
docker run -p 6080:80 --rm -it --privileged atsushisaito/docker-ubuntu-sweb:jammy

# Ubuntu 24.04
docker run -p 6080:80 --rm -it --privileged atsushisaito/docker-ubuntu-sweb:noble
```

## 手動でビルドする場合

```sh
# Ubuntu 20.04
docker build -t docker-ubuntu-sweb:focal --build-arg TARGET_TAG=focal .
docker run -p 6080:80 --rm -it --privileged docker-ubuntu-sweb:focal

# Ubuntu 22.04
docker build -t docker-ubuntu-sweb:jammy --build-arg TARGET_TAG=jammy .
docker run -p 6080:80 --rm -it --privileged docker-ubuntu-sweb:jammy

# Ubuntu 24.04
docker build -t docker-ubuntu-sweb:noble --build-arg TARGET_TAG=noble .
docker run -p 6080:80 --rm -it --privileged docker-ubuntu-sweb:noble
```

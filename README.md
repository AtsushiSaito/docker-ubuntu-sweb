# docker-ubuntu-sweb

シンプルな構成でUbuntu x noVNCをDockerで動かすプロジェクト

![Demo](https://github.com/AtsushiSaito/docker-ubuntu-sweb/blob/readme_assets/images/demo.gif?raw=true)

## 特徴
* MATEデスクトップを採用
* ウィンドウサイズに応じたリサイズ機能

## QuickStart
```
docker build -t docker-ubuntu-sweb .
docker run -p 6080:80 --rm -it --privileged docker-ubuntu-sweb
```

`localhost:6080/vnc.html` にアクセスする。ログインパスワードは `ubuntu`です。
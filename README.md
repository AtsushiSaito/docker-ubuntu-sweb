# docker-ubuntu-sweb

シンプルな構成でUbuntu x noVNCをDockerで動かすプロジェクト

## QuickStart
```
docker build -t docker-ubuntu-sweb .
docker run -p 6080:80 --rm -it --privileged docker-ubuntu-sweb
```

`localhost:6080/vnc.html` にアクセスする。ログインパスワードは `ubuntu`です。
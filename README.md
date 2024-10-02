# Information

Sample "Hello world" web server written in GO and shell packed as image using [Alpine linux](https://www.alpinelinux.org/) as base image.  

The images are hosted on Docker Hub [https://hub.docker.com/repository/docker/perteghella/hello-shell/](https://hub.docker.com/repository/docker/perteghella/hello-shell/)   
Source code on Github [https://github.com/Perteghella/hello-shell](https://github.com/Perteghella/hello-shell)  

There are also images based on Ubuntu, Debian, Google Distroless, Busybox and Scratch to understand that [size matters](#build-using-different-base-image)

- golang:1.23.1 [https://hub.docker.com/_/golang](https://hub.docker.com/_/golang)
- alpine:3.20.3 [https://hub.docker.com/_/alpine](https://hub.docker.com/_/alpine)
- busybox:1.37.0 [https://hub.docker.com/_/busybox](https://hub.docker.com/_/busybox)
- debian:bookworm 12.7 [https://hub.docker.com/_/debian](https://hub.docker.com/_/debian)
- ubuntu:24.04 [https://hub.docker.com/_/ubuntu](https://hub.docker.com/_/ubuntu)
- redhat/ubi9:9.4 [https://hub.docker.com/r/redhat/ubi9/](https://hub.docker.com/r/redhat/ubi9/)
- distroless [https://github.com/GoogleContainerTools/distroless](https://github.com/GoogleContainerTools/distroless)
 
## Versions

This application is available as [OCI images](https://opencontainers.org/) based on Alpine on [Docker Hub](https://hub.docker.com/r/perteghella/hello-shell), which respond to requests with different version numbers:

- perteghella/hello-shell:1.0 
- perteghella/hello-shell:2.0 

The images are based on [sample hello-app](https://github.com/GoogleCloudPlatform/kubernetes-engine-samples/tree/main/hello-app)


## Key features

- Multi architecture build
  - linux/amd64
  - linux/arm64
- Minimal size due to [multistage build](https://docs.docker.com/build/building/multi-stage/)
- Multiple tag to test the migration to different version of deployment
- Minimal web server that expose version and headers
- env var PORT to change the server port, default to 8080

## How to use this image with Docker cli

Download the proper tagged image `docker pull perteghella/hello-shell:TAG`

```shell
docker pull perteghella/hello-shell:1.0
```

Run as daemon exposing localhost port 8000 to port 8080 on container 

```shell
docker run -d -p 8000:8080 --name hello-shell-1.0 perteghella/hello-shell:1.0
```

Verify that container is running

```shell
docker ps
```

Sample output

```shell
CONTAINER ID   IMAGE                           COMMAND        CREATED         STATUS          PORTS                    NAMES
c135f955a4d5   perteghella/hello-shell:1.0     "/hello-app"   1 minutes ago   Up 1 minutes    0.0.0.0:8000->8080/tcp   hello-shell-1.0
```

Verify that web server is responding to request

```shell
curl http://127.0.0.1:8000
```

Attach to shell using 

```shell
docker exec -it hello-shell-1.0 /bin/sh
```

Inside the container execute some linux commands

```shell
hostname
ifconfig
ping 1.1.1.1
exit
```

Stop and destroy the container

```shell
docker rm  -f hello-shell-1.0
```


## Code

Source on Github [https://github.com/Perteghella/hello-shell](https://github.com/Perteghella/hello-shell)

## Build the image

Build and push the images based on Alpine to Docker hub

```shell
docker buildx build --platform linux/amd64,linux/arm64 --build-arg APP_VERSION=1.0 --tag perteghella/hello-shell:1.0 --push .
docker buildx build --platform linux/amd64,linux/arm64 --build-arg APP_VERSION=2.0 --tag perteghella/hello-shell:2.0 --push .
```

## Build using different base image

Using different Dockerfiles we build and save the image locally

```shell
docker buildx build --build-arg APP_VERSION=1.0-scratch -f Dockerfile-scratch --tag perteghella/hello-shell:1.0-scratch  --load .
docker buildx build --build-arg APP_VERSION=1.0-busybox -f Dockerfile-busybox --tag perteghella/hello-shell:1.0-busybox  --load .
docker buildx build --build-arg APP_VERSION=1.0-alpine -f Dockerfile --tag perteghella/hello-shell:1.0-alpine  --load .
docker buildx build --build-arg APP_VERSION=1.0-debian -f Dockerfile-debian --tag perteghella/hello-shell:1.0-debian  --load .
docker buildx build --build-arg APP_VERSION=1.0-ubuntu -f Dockerfile-ubuntu --tag perteghella/hello-shell:1.0-ubuntu  --load .
docker buildx build --build-arg APP_VERSION=1.0-distroless-debian12 -f Dockerfile-distroless-debian12 --tag perteghella/hello-shell:1.0-distroless-debian12  --load .
```

Get the images sizes

```shell
docker image ls 
```

Look the size of the images based on alpine, busybox and scratch + a shell 


```shell
REPOSITORY                    TAG                IMAGE ID       CREATED              SIZE
gcr.io/distroless/static-debian12   latest       125bac032e5e   N/A                  1.99MB
busybox                       1.37.0             63cd0d5fb10d   5 days ago           4.04MB
alpine                        3.20.3             c157a85ed455   3 weeks ago          8.83MB
ubuntu                        24.04              c22ec0081bf1   2 weeks ago          101MB
debian                        bookworm           a2a098df5635   5 days ago           139MB
redhat/ubi9                   9.4                34c69b3786d8   13 days ago          231MB
perteghella/hello-shell       1.0-scratch        dcd6ba149a7d   1 minutes ago        9.45MB
perteghella/hello-shell       1.0-distroless-debian12  b3312b39c788  4 seconds ago   10.3MB
perteghella/hello-shell       1.0-busybox        f941dd6ac2cf   1 minutes ago        11.3MB
perteghella/hello-shell       1.0-alpine         1df31cf51d68   1 minutes ago        16MB
perteghella/hello-shell       1.0-ubuntu         1c2a0f395005   7 seconds ago        108MB
perteghella/hello-shell       1.0-debian         d2309d0c3760   51 seconds ago       146MB
perteghella/hello-shell       1.0-rh9            d9565b5ac8b8   10 seconds ago       238MB
```

##  Build and push the images based on Scratch, Busybox, Ubuntu and Debian

As reference you can use also this TAGs for the image from Docker Hub, sorted by image size.

- perteghella/hello-shell:1.0-scratch
- perteghella/hello-shell:1.0-distroless-debian12
- perteghella/hello-shell:1.0-busybox
- perteghella/hello-shell:1.0-alpine
- perteghella/hello-shell:1.0-debian
- perteghella/hello-shell:1.0-ubuntu
- perteghella/hello-shell:1.0-rh9

THe images are built with this commands

```shell
docker buildx build --platform linux/amd64,linux/arm64 --build-arg APP_VERSION=1.0-scratch -f Dockerfile-scratch --tag perteghella/hello-shell:1.0-scratch --push .
docker buildx build --platform linux/amd64,linux/arm64 --build-arg APP_VERSION=1.0-distroless-debian12 -f Dockerfile-scratch --tag perteghella/hello-shell:1.0-distroless-debian12 --push .
docker buildx build --platform linux/amd64,linux/arm64 --build-arg APP_VERSION=1.0-busybox -f Dockerfile-busybox --tag perteghella/hello-shell:1.0-busybox --push .
docker buildx build --platform linux/amd64,linux/arm64 --build-arg APP_VERSION=1.0-busybox -f Dockerfile --tag perteghella/hello-shell:1.0-alpine --push .
docker buildx build --platform linux/amd64,linux/arm64 --build-arg APP_VERSION=1.0-debian -f Dockerfile-debian --tag perteghella/hello-shell:1.0-debian --push .
docker buildx build --platform linux/amd64,linux/arm64 --build-arg APP_VERSION=1.0-ubuntu -f Dockerfile-ubuntu --tag perteghella/hello-shell:1.0-ubuntu --push .
docker buildx build --platform linux/amd64,linux/arm64 --build-arg APP_VERSION=1.0-rh9 -f Dockerfile-rh9 --tag perteghella/hello-shell:1.0-rh9 --push .
```

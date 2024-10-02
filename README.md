# Information

Sample "Hello world" containerized web server written in GO and the tools of alpine:

- golang:1.23.1 [https://hub.docker.com/_/golang](https://hub.docker.com/_/golang)
- alpine 3.20.3 [https://hub.docker.com/_/alpine](https://hub.docker.com/_/alpine)

This application is available as two [OCI images](https://opencontainers.org/) on [Docker Hub](https://hub.docker.com/r/perteghella/hello-shell), which respond to requests with different version numbers:

- perteghella/hello-shell:1.0 
- perteghella/hello-shell:2.0 

The images are based on https://github.com/GoogleCloudPlatform/kubernetes-engine-samples/tree/main/hello-app

# Key features

- Multi architecture build
  - linux/amd64
  - linux/arm64
- Minimal size due to [multistage build](https://docs.docker.com/build/building/multi-stage/)
- Multiple tag to test the migration to different version of deployment
- Minimal web server that expose version and headers
- env var PORT to change the server port, default to 8080

# How to use this image with Docker cli

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


# Code

Source on Github [https://github.com/Perteghella/hello-shell](https://github.com/Perteghella/hello-shell)

# Build the image

```shell
docker buildx build --platform linux/amd64,linux/arm64 --build-arg APP_VERSION=1.0 --tag perteghella/hello-shell:1.0 --push .
docker buildx build --platform linux/amd64,linux/arm64 --build-arg APP_VERSION=2.0 --tag perteghella/hello-shell:2.0 --push .
```
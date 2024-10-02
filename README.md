# Information

Sample "Hello world" containerized web server written in GO and the tools of alpine:

- golang:1.20.4 [https://hub.docker.com/_/golang](https://hub.docker.com/_/golang)
- alpine 3.17.2 [https://hub.docker.com/_/alpine](https://hub.docker.com/_/alpine)

This application is available as two OCI images on [Docker Hub](https://hub.docker.com/r/perteghella/hello-shell), which respond to requests with different version numbers:

- perteghella/hello-shell:1.0 
- perteghella/hello-shell:2.0 

The images are based on https://github.com/GoogleCloudPlatform/kubernetes-engine-samples/tree/main/hello-app

# Key features

- Multi architecture build
  - linux/amd64
  - linux/arm64
- Minimal size due to multistage build
- Multiple tag to test the migration to different version of deployment

# How to use this image with Docker cli

Download the proper tagged image `docker pull perteghella/hello-shell:TAG`

Run as daemon exposing port 8080 on localhost port 8000

```shell
docker pull perteghella/hello-shell:1.0

docker run -d -p 8000:8080 perteghella/hello-shell:1.0
```

Verify that the server is running and respond 

```shell
curl http://127.0.0.1:8000
```

Attach to shell using 

```shell
docker exec -it CONTAINER-ID /bin/sh
```

# Code

Source on Github [https://github.com/Perteghella/hello-shell](https://github.com/Perteghella/hello-shell)

# Build the image

```shell
docker buildx build --platform linux/amd64,linux/arm64 --build-arg APP_VERSION=1.0 --tag perteghella/hello-shell:1.0 --push .
docker buildx build --platform linux/amd64,linux/arm64 --build-arg APP_VERSION=2.0 --tag perteghella/hello-shell:2.0 --push .
```
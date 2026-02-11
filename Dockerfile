# Update 2026-02-11 

# First stage to build the application
FROM golang:1.26.0-alpine3.23 AS builder
WORKDIR /app
RUN go mod init hello-app
COPY main.go ./
ARG APP_VERSION=1.0
ENV APP_VERSION=${APP_VERSION}
RUN CGO_ENABLED=0 GOOS=linux go build -o /hello-app

# Second stage to run the application in a specific image
FROM alpine:3.23
WORKDIR /
COPY --from=builder /hello-app /hello-app
ENV PORT=8080
ARG APP_VERSION=1.0
ENV APP_VERSION=${APP_VERSION}
CMD ["/hello-app"]

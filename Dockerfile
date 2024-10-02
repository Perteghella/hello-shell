FROM golang:1.23.1-alpine3.20 AS builder
WORKDIR /app
RUN go mod init hello-app
COPY *.go ./
ARG APP_VERSION=1.0
ENV APP_VERSION=${APP_VERSION}
RUN CGO_ENABLED=0 GOOS=linux go build -o /hello-app

FROM alpine:3.20.3
WORKDIR /
COPY --from=builder /hello-app /hello-app
ENV PORT 8080
ENV APP_VERSION ${APP_VERSION}
CMD ["/hello-app"]
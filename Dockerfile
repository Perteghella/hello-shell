FROM golang:1.20.1-alpine3.17 as builder
WORKDIR /app
RUN go mod init hello-app
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /hello-app

FROM alpine:3.17.2
WORKDIR /
COPY --from=builder /hello-app /hello-app
ENV PORT 8080
CMD ["/hello-app"]
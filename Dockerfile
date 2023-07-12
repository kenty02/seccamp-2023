FROM golang:1.20-alpine
WORKDIR /usr/src/app

COPY . .
RUN go build -o /usr/local/bin/app cmd/server/main.go

FROM alpine:latest
RUN apk --no-cache add ca-certificates

WORKDIR /root/
COPY --from=0 /usr/local/bin/app .
# DATABASE_DSN is passed at startup
CMD ["/root/app"]

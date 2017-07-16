FROM alpine:latest

ENTRYPOINT /entrypoint.sh

RUN apk update && \
	apk add ca-certificates openssl && \
	rm -rf /var/cache/apk/*

ADD openssl.cnf /
ADD entrypoint.sh /
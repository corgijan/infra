FROM golang:1.22-alpine AS builder
RUN apk add --no-cache git ca-certificates
RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest
RUN xcaddy build --with github.com/mholt/caddy-l4 --output /usr/bin/caddy && chmod +x /usr/bin/caddy
FROM alpine:3.15
RUN apk add --no-cache ca-certificates mailcap
RUN set -eux; \
	mkdir -p \
		/config/caddy \
		/data/caddy \
		/etc/caddy \
		/usr/share/caddy
# set up nsswitch.conf for Go's "netgo" implementation
# - https://github.com/docker-library/golang/blob/1eb096131592bcbc90aa3b97471811c798a93573/1.14/alpine3.12/Dockerfile#L9
RUN [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf
# See https://caddyserver.com/docs/conventions#file-locations for details
ENV XDG_CONFIG_HOME=/config
ENV XDG_DATA_HOME=/data
EXPOSE 80
EXPOSE 443
EXPOSE 2019
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
WORKDIR /srv
CMD ["caddy", "run", "--config", "config.json"]

FROM caddy:2.5.1-builder-alpine AS caddybuilder

RUN xcaddy build \
    --with github.com/abiosoft/caddy-exec \
    --with github.com/caddy-dns/cloudflare \
    --with clevergo.tech/caddy-dnspodcn \
    --with github.com/kirsch33/realip \
    --with github.com/mholt/caddy-webdav

# build nonedotone caddy
FROM caddy:2.5.1-alpine

LABEL name="none" email="none@none.one"

ADD 404.html /template/

COPY --from=caddybuilder /usr/bin/caddy /usr/bin/caddy

RUN apk update && apk add --no-cache ca-certificates

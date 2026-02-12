ARG CADDY_VERSION=2.10.2

FROM caddy:${CADDY_VERSION}-builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:${CADDY_VERSION}

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

EXPOSE 80 443 2019

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD caddy version || exit 1

LABEL org.opencontainers.image.title="Caddy with Cloudflare DNS" \
    org.opencontainers.image.description="Caddy web server with Cloudflare DNS module for DNS-01 ACME challenge" \
    org.opencontainers.image.source="https://github.com/QuirkQ/caddy-cloudflare" \
    org.opencontainers.image.licenses="Apache-2.0"

ARG CADDY_VERSION=2.10.2

FROM caddy:${CADDY_VERSION}-builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:${CADDY_VERSION}

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

EXPOSE 80 443 2019

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD caddy list-modules | grep -q dns.providers.cloudflare || exit 1

ARG CADDY_VERSION
ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.title="Caddy with Cloudflare DNS" \
    org.opencontainers.image.description="Caddy web server with Cloudflare DNS module for DNS-01 ACME challenge" \
    org.opencontainers.image.version="${CADDY_VERSION}" \
    org.opencontainers.image.created="${BUILD_DATE}" \
    org.opencontainers.image.revision="${VCS_REF}" \
    org.opencontainers.image.source="https://github.com/QuirkQ/caddy-cloudflare" \
    org.opencontainers.image.url="https://github.com/QuirkQ/caddy-cloudflare" \
    org.opencontainers.image.documentation="https://github.com/QuirkQ/caddy-cloudflare/blob/main/README.md" \
    org.opencontainers.image.vendor="QuirkQ" \
    org.opencontainers.image.licenses="Apache-2.0" \
    org.opencontainers.image.base.name="docker.io/library/caddy:${CADDY_VERSION}"

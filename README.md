# Caddy with Cloudflare DNS

Docker image of [Caddy](https://caddyserver.com/) with the [Cloudflare DNS](https://github.com/caddy-dns/cloudflare) module pre-installed for DNS-01 ACME challenges.

## Quick Start

```bash
docker run -d -p 80:80 -p 443:443 \
  -e CLOUDFLARE_API_TOKEN=your_token \
  -v caddy_data:/data \
  -v caddy_config:/config \
  ghcr.io/QuirkQ/caddy-cloudflare:latest
```

## Example Caddyfile

```caddyfile
{
    acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}
}

example.com {
    respond "Hello, world!"
}

# Wildcard certificate
*.example.com {
    tls {
        dns cloudflare {env.CLOUDFLARE_API_TOKEN}
    }
    respond "Hello from {http.request.host}!"
}
```

## Environment Variables

| Variable | Description |
|---|---|
| `CLOUDFLARE_API_TOKEN` | Cloudflare API token with `Zone:DNS:Edit` permission |

## Image Tags

| Tag | Description |
|---|---|
| `latest` | Latest stable Caddy with Cloudflare DNS module |
| `2` | Latest Caddy 2.x |
| `2.10` | Latest Caddy 2.10.x |
| `2.10.2` | Specific Caddy version |

## Docker Compose

```yaml
services:
  caddy:
    image: ghcr.io/QuirkQ/caddy-cloudflare:latest
    ports:
      - "80:80"
      - "443:443"
    environment:
      - CLOUDFLARE_API_TOKEN=${CLOUDFLARE_API_TOKEN}
    volumes:
      - ./Caddyfile:/etc/caddy/Caddyfile
      - caddy_data:/data
      - caddy_config:/config

volumes:
  caddy_data:
  caddy_config:
```

## Verify Module

```bash
docker run --rm ghcr.io/QuirkQ/caddy-cloudflare:latest caddy list-modules | grep cloudflare
```

## Links

- [Caddy Documentation](https://caddyserver.com/docs/)
- [Cloudflare DNS Module](https://github.com/caddy-dns/cloudflare)
- [Cloudflare API Tokens](https://dash.cloudflare.com/profile/api-tokens)

## License

[Apache 2.0](LICENSE)

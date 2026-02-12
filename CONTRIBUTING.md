# Contributing to Caddy with Cloudflare DNS

Thank you for your interest in contributing! This document provides guidelines for contributing to this project.

## Code of Conduct

This project adheres to a Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior by opening an issue.

## How to Contribute

### Reporting Bugs

Before creating bug reports, please check existing issues to avoid duplicates. When creating a bug report, include:

- **Description**: Clear description of the issue
- **Steps to Reproduce**: Detailed steps to reproduce the behavior
- **Expected Behavior**: What you expected to happen
- **Actual Behavior**: What actually happened
- **Environment**:
  - Caddy version (from image tag)
  - Docker version
  - Operating system
  - Architecture (amd64/arm64)
- **Logs**: Relevant error messages or logs

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, include:

- **Clear title**: Use a descriptive title
- **Detailed description**: Explain the enhancement and why it would be useful
- **Use cases**: Provide specific examples of how this would be used
- **Alternatives**: Describe any alternative solutions you've considered

### Pull Requests

1. **Fork the repository** and create your branch from `main`
2. **Make your changes**:
   - Follow existing code style and conventions
   - Update documentation if needed
   - Test your changes locally
3. **Commit your changes**:
   - Use clear, descriptive commit messages
   - Reference relevant issues (e.g., "Fix #123")
4. **Push to your fork** and submit a pull request
5. **Wait for review**: Maintainers will review your PR and may request changes

#### Pull Request Guidelines

- Keep pull requests focused on a single issue or feature
- Update the README.md if you change functionality
- Update the Dockerfile if you add build arguments or change behavior
- Ensure the Docker image builds successfully for both amd64 and arm64
- Test the image works with Cloudflare DNS challenges

#### Testing Your Changes

Before submitting a PR, test your changes:

```bash
# Build the image
docker build -t caddy-cloudflare:test .

# Verify the Cloudflare module is present
docker run --rm caddy-cloudflare:test caddy list-modules | grep cloudflare

# Test with a basic Caddyfile (optional, requires valid Cloudflare token)
docker run -d -p 80:80 -p 443:443 \
  -e CLOUDFLARE_API_TOKEN=your_token \
  -v ./Caddyfile:/etc/caddy/Caddyfile \
  caddy-cloudflare:test
```

## Development Setup

### Prerequisites

- Docker with BuildKit support
- Docker Buildx for multi-platform builds
- Git

### Building Locally

```bash
# Clone the repository
git clone https://github.com/QuirkQ/caddy-cloudflare.git
cd caddy-cloudflare

# Build for current platform
docker build -t caddy-cloudflare:local .

# Build for multiple platforms (requires buildx)
docker buildx build --platform linux/amd64,linux/arm64 -t caddy-cloudflare:local .
```

### Project Structure

```
.
├── .github/
│   └── workflows/          # GitHub Actions workflows
├── Caddyfile.example      # Example configuration
├── Dockerfile             # Multi-stage build configuration
├── README.md              # User documentation
├── CONTRIBUTING.md        # This file
├── CODE_OF_CONDUCT.md     # Code of conduct
└── LICENSE                # Apache 2.0 license
```

## Release Process

Releases are automated through GitHub Actions:

- **Manual releases**: Push a tag matching `v*` (e.g., `v2.10.2`)
- **Scheduled releases**: Automatic builds run twice weekly (Sunday and Wednesday)
- **Push to main**: Triggers a build with the latest Caddy version

Image tags follow this convention:
- `latest`: Latest stable Caddy version
- `2`: Latest Caddy v2.x.x
- `2.10`: Latest Caddy v2.10.x
- `2.10.2`: Specific Caddy version

## Questions?

If you have questions that aren't covered here:

1. Check the [README.md](README.md) for usage documentation
2. Search [existing issues](https://github.com/QuirkQ/caddy-cloudflare/issues)
3. Open a new issue with the "question" label

## License

By contributing, you agree that your contributions will be licensed under the Apache License 2.0.

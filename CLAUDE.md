# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repo builds a custom nginx Docker image (Alpine-based) with the [nginx-module-vts](https://github.com/vozlt/nginx-module-vts) (Virtual Host Traffic Status) compiled as a dynamic module. The image exposes Prometheus-compatible metrics for monitoring nginx traffic.

## Build & Run

```shell
# Build the image (VERSION arg controls nginx version, default 1.28.0)
docker build . -t ghcr.io/akmalovaa/nginx-vts --build-arg VERSION=1.28.0

# Run (port 80: main server, port 9991: metrics/vts dashboard)
docker run -p 80:80 -p 9991:9991 ghcr.io/akmalovaa/nginx-vts

# Pull pre-built image
docker pull ghcr.io/akmalovaa/nginx-vts
```

## Architecture

**Multi-stage Dockerfile**: Stage 1 compiles `ngx_http_vhost_traffic_status_module.so` from source against the matching nginx version. Stage 2 copies the compiled `.so` module into a clean `nginx:alpine` image.

**nginx.conf**: Loads the VTS module dynamically. Two server blocks:
- Port 80: default server returning a plain text response
- Port 9991: metrics endpoint (`/metrics` for Prometheus format, `/vts` for HTML dashboard)

VTS is configured with `vhost_traffic_status_filter_by_set_key` to group metrics by HTTP status code category and URL pattern.

## CI/CD (GitHub Actions)

Two workflows in `.github/workflows/`:
- **docker-publish.yml** ("Release build"): Triggers on semver tags, releases, and weekly cron. Builds multi-arch (amd64/arm64), pushes to GHCR, signs with cosign.
- **manual.yml** ("Trivy scanner"): Manual-dispatch-only Trivy scan against the latest tagged image.

## Version Updates

When updating the nginx version:
1. Change the `ARG VERSION=` default in `Dockerfile` (appears twice, near the top before each `FROM`)
2. Update the version badge and build-arg example in `README.md`
3. Tag the commit with the version number (e.g., `1.31.2`) to trigger the release build

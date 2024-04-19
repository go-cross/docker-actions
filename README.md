# docker-actions

[![Test Actions](https://github.com/go-cross/docker-actions/actions/workflows/test-actions.yml/badge.svg)](https://github.com/go-cross/docker-actions/actions/workflows/test-actions.yml)

Build golang program with CGO_ENABLED=1 for docker Image

### Usage Example

```yml
name: Docker Actions

on:
  pull_request:
    branches:
      - main
  push:
    branches:
      - main

permissions:
  contents: read

jobs:
  test-action:
    name: GitHub Actions Test
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        id: checkout
        uses: actions/checkout@v4

      - name: Setup Go
        uses: actions/setup-go@v5
        with:
          go-version: '1.22'

      - name: Build docker binary
        id: docker-build
        uses: go-cross/docker-actions@v1
        with:
          platforms: linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x

      - name: Docker meta
        id: meta
        uses: docker/metadata-action@v5
        with:
          images: xhofe/test

      - name: Set up QEMU
        uses: docker/setup-qemu-action@v3

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Build and push
        id: docker_build
        uses: docker/build-push-action@v5
        with:
          context: .
          file: ./example/Dockerfile
          push: false
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
          platforms: ${{ steps.docker-build.outputs.platforms }}
```

Sure, here are the inputs and outputs in table format:

## Inputs

| Input     | Description                               | Required | Default Value                                                                                         |
| --------- | ----------------------------------------- | -------- | ----------------------------------------------------------------------------------------------------- |
| platforms | The platforms to build for                | No       | 'linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x' |
| dir       | The directory to work                     | No       | '.'                                                                                                   |
| packages  | The packages to build                     | No       | '.'                                                                                                   |
| flags     | The flags to pass to the go build command | No       | '-ldflags=-w -s'                                                                                      |
| output    | The output binary name                    | No       | '$repo'                                                                                               |

## Outputs

| Output    | Description             |
| --------- | ----------------------- |
| platforms | The platforms built for |

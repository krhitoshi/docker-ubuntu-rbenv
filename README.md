# docker-ubuntu-rbenv

Docker images for Ubuntu with rbenv.

Docker Hub: https://hub.docker.com/repository/docker/krhitoshi/ubuntu-rbenv

## Usage

### irb

```
docker run -it --rm krhitoshi/ubuntu-rbenv:22.04-3.2.2
```

### bash

```
docker run -it --rm krhitoshi/ubuntu-rbenv:22.04-3.2.2 bash
```

## Notes for building multi-platform images (repository owner only)

### Prepare for multi-platform builds

```
docker buildx create --use
```

### Update the Ubuntu 24.04 base image (includes rbenv)

```
docker buildx build 24.04
docker buildx build 24.04 --push --platform linux/amd64,linux/arm64 -t krhitoshi/ubuntu-rbenv:24.04
```

### Build and push the multi-platform image for Ubuntu 24.04 + rbenv + Ruby 3.4.7

```
docker buildx build . --push --platform linux/amd64,linux/arm64 --build-arg UBUNTU_VERSION=24.04 --build-arg RUBY_VERSION=3.4.7 -t krhitoshi/ubuntu-rbenv:24.04-3.4.7
```

### Update the Ubuntu 26.04 base image (includes rbenv)

```
docker buildx build 26.04
docker buildx build 26.04 --push --platform linux/amd64,linux/arm64 -t krhitoshi/ubuntu-rbenv:26.04
```

### Build and push the multi-platform image for Ubuntu 26.04 + rbenv + Ruby 4.0.9

The `linux/amd64` image cannot be built on an Apple Silicon Mac with Docker Desktop's Rosetta emulation.
GNU tar in Ubuntu 26.04 (`1.35+dfsg-4ubuntu0.2` and later) uses the `openat2` syscall, which Rosetta for Linux does not implement,
so `rbenv install` fails with `Cannot mkdir: Function not implemented` while extracting the Ruby tarball.
Build each platform on a native machine and combine them into a single multi-platform tag.

```
# 1. On the Mac (arm64): build and push the arm64 image
docker buildx build . --push --platform linux/arm64 --build-arg UBUNTU_VERSION=26.04 --build-arg RUBY_VERSION=4.0.9 -t krhitoshi/ubuntu-rbenv:26.04-4.0.9-arm64

# 2. On an amd64 machine: build and push the amd64 image
docker buildx build . --push --platform linux/amd64 --build-arg UBUNTU_VERSION=26.04 --build-arg RUBY_VERSION=4.0.9 -t krhitoshi/ubuntu-rbenv:26.04-4.0.9-amd64

# 3. On either machine: combine both images into one multi-platform tag
docker buildx imagetools create -t krhitoshi/ubuntu-rbenv:26.04-4.0.9 krhitoshi/ubuntu-rbenv:26.04-4.0.9-arm64 krhitoshi/ubuntu-rbenv:26.04-4.0.9-amd64

# 4. Verify that both linux/arm64 and linux/amd64 are listed
docker buildx imagetools inspect krhitoshi/ubuntu-rbenv:26.04-4.0.9
```

### Build a single-platform image for local use

With the `docker-container` builder, the result stays in the builder's cache unless `--push` or `--load` is given.
Use `--load` to import it into the local Docker image store (single platform only).

```
docker buildx build . --load --platform linux/arm64 --build-arg UBUNTU_VERSION=26.04 --build-arg RUBY_VERSION=4.0.9 -t krhitoshi/ubuntu-rbenv:26.04-4.0.9
```

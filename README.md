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

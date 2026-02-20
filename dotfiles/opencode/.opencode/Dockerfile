FROM ghcr.io/anomalyco/opencode:latest

USER root

# Install additional tools
RUN apk add --no-cache \
  bash \
  ca-certificates \
  curl \
  git \
  sudo

# Create 'orange' user with UID=1000 to match the host user
RUN addgroup -g 1000 orange && \
  adduser -D -u 1000 -G orange -h /home/orange -s /bin/bash orange

USER orange

WORKDIR /workspace

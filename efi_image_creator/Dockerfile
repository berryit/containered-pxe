FROM ubuntu:24.04

LABEL org.opencontainers.image.authors="Tim Beermann <tibeer@berryit.de>" \
      org.opencontainers.image.description="Build iPXE EFI binary for x86_64 with embedded script" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.title="efi-creator" \
      org.opencontainers.image.url="http://github.com/berryit/containered-pxe" \
      org.opencontainers.image.source="http://github.com/berryit/containered-pxe" \
      org.opencontainers.image.vendor="berryit.de"

# Set noninteractive frontend for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates=20240203 \
        git=1:2.43.0-1ubuntu7.3 \
        build-essential=12.10ubuntu1 \
        binutils-dev=2.42-4ubuntu2.6 \
        mtools=4.0.43-1build1 \
        syslinux=3:6.04~git20190206.bf6db5b4+dfsg1-3ubuntu3 \
        xz-utils=5.6.1+really5.4.5-1ubuntu0.2 \
        wget=1.21.4-1ubuntu4.1 && \
    rm -rf /var/lib/apt/lists/*

# Clone ipxe repo
RUN git clone https://github.com/ipxe/ipxe.git /ipxe

# Switch working directory
WORKDIR /ipxe/src

# Copy your embedded script into the container
COPY embed.ipxe /ipxe/src/embed.ipxe

# Set build output directory
VOLUME ["/ipxe/output"]

# Build targets when container runs
CMD ["bash", "-c", "make bin-x86_64-efi/ipxe.efi EMBED=/ipxe/src/embed.ipxe && cp bin-x86_64-efi/ipxe.efi /ipxe/output/ipxe_x86_64.efi"]

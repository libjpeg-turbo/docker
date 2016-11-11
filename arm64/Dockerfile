FROM multiarch/ubuntu-core:arm64-xenial

RUN apt-get update && apt-get install -y --no-install-recommends \
    autoconf \
    automake \
    ca-certificates \
    cmake \
    cmake-curses-gui \
    gcc \
    git \
    libtool \
    m4 \
    make \
    pkg-config \
&& rm -rf /var/lib/apt/lists/*

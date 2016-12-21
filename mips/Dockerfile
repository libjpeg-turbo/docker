FROM multiarch/debian-debootstrap:mipsel-jessie-slim
# NOTE: Download x86_64_qemu-mipsel-static.tar.gz from
# https://github.com/multiarch/qemu-user-static/releases
# Extract it and rename qemu-mipsel-static to qemu-mipsn32el-static, then
# re-compress the tarball with the same name.  This is apparently necessary to
# work around a QEMU bug.
ADD x86_64_qemu-mipsel-static.tar.gz /usr/bin

# multiarch/qemu-user-static registers mipsn32el
ADD qemu-mipsn32el-static /usr/bin

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
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

# overwrite this with 'CMD []' in a dependent Dockerfile
CMD ["/bin/bash"]

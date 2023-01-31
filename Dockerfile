FROM centos:7

RUN yum -y update \
 && yum -y install epel-release.noarch \
 && yum -y install \
    audit-libs-devel \
    automake \
    binutils-devel \
    bzip2-devel \
    cmake \
    dbus-devel \
    dpkg \
    elfutils-devel \
    elfutils-libelf-devel \
    expect \
    file-devel \
    gcc \
    gettext-devel \
    git \
    glibc-devel \
    glibc-devel.i686 \
    gnupg2 \
    gnupg1 \
    ima-evm-utils-devel \
    java-1.8.0-openjdk-devel \
    java-1.8.0-openjdk-devel.i686 \
    libacl-devel \
    libarchive-devel \
    libcap-devel \
    libselinux-devel \
    libtool \
    libzstd-devel \
    lua-devel \
    make \
    ncurses-devel \
    openssl-devel \
    perl-ExtUtils-MakeMaker \
    popt-devel \
    python2-devel \
    python3-devel \
    readline-devel \
    redhat-rpm-config \
    rpm-build \
    wget \
    xz-devel \
    yasm \
    zip \
    zstd \
 && pushd /opt \
 && wget 'https://developer.arm.com/-/media/Files/downloads/gnu-a/9.2-2019.12/binrel/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz?revision=61c3be5d-5175-4db6-9030-b565aae9f766&hash=CB9A16FCC54DC7D64F8BBE8D740E38A8BF2C8665' \
 && tar xf 'gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz?revision=61c3be5d-5175-4db6-9030-b565aae9f766&hash=CB9A16FCC54DC7D64F8BBE8D740E38A8BF2C8665' \
 && rm 'gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz?revision=61c3be5d-5175-4db6-9030-b565aae9f766&hash=CB9A16FCC54DC7D64F8BBE8D740E38A8BF2C8665' \
 && mv gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu gcc.arm64 \
 && rm -rf /opt/gcc.arm64/aarch64-none-linux-gnu/bin/ld.gold \
           /opt/gcc.arm64/aarch64-none-linux-gnu/include \
           /opt/gcc.arm64/aarch64-none-linux-gnu/lib64 \
           /opt/gcc.arm64/aarch64-none-linux-gnu/libc/usr/bin \
           /opt/gcc.arm64/aarch64-none-linux-gnu/libc/usr/lib64/*atomic* \
           /opt/gcc.arm64/aarch64-none-linux-gnu/libc/usr/lib64/*fortran* \
           /opt/gcc.arm64/aarch64-none-linux-gnu/libc/usr/lib64/*gomp* \
           /opt/gcc.arm64/aarch64-none-linux-gnu/libc/usr/lib64/*san* \
           /opt/gcc.arm64/aarch64-none-linux-gnu/libc/usr/lib64/*stdc++* \
           /opt/gcc.arm64/bin/*++* \
           /opt/gcc.arm64/bin/*fortran* \
           /opt/gcc.arm64/bin/*gcov* \
           /opt/gcc.arm64/bin/*gdb* \
           /opt/gcc.arm64/bin/*ld.gold* \
           /opt/gcc.arm64/lib/gcc/aarch64-none-linux-gnu/9.2.1/*gcov* \
           /opt/gcc.arm64/lib/gcc/aarch64-none-linux-gnu/9.2.1/plugin \
           /opt/gcc.arm64/libexec/gcc/aarch64-none-linux-gnu/9.2.1/cc1plus \
           /opt/gcc.arm64/libexec/gcc/aarch64-none-linux-gnu/9.2.1/f951 \
           /opt/gcc.arm64/libexec/gcc/aarch64-none-linux-gnu/9.2.1/lto* \
           /opt/gcc.arm64/libexec/gcc/aarch64-none-linux-gnu/9.2.1/plugin \
           /opt/gcc.arm64/share \
 && chown -R root:root gcc.arm64 \
 && wget https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u312-b07/OpenJDK8U-jdk_aarch64_linux_hotspot_8u312b07.tar.gz \
 && tar xf OpenJDK8U-jdk_aarch64_linux_hotspot_8u312b07.tar.gz \
 && rm OpenJDK8U-jdk_aarch64_linux_hotspot_8u312b07.tar.gz \
 && mv jdk8u312-b07 openjdk.arm64 \
 && rm -rf /opt/openjdk.arm64/bin \
           /opt/openjdk.arm64/jre/bin \
           /opt/openjdk.arm64/man \
           /opt/openjdk.arm64/sample \
           /opt/openjdk.arm64/src.zip \
 && shopt -s extglob \
 && find /opt/openjdk.arm64/jre/lib/* -maxdepth 0 ! -name aarch64 | xargs rm -rf \
 && find /opt/openjdk.arm64/lib/* -maxdepth 0 ! -name aarch64 | xargs rm -rf \
 && popd \
 && mkdir ~/rpm \
 && pushd ~/rpm \
 && wget https://dl.rockylinux.org/vault/rocky/8.4/BaseOS/source/tree/Packages/rpm-4.14.3-13.el8.src.rpm \
 && rpmbuild --rebuild rpm-4.14.3-13.el8.src.rpm \
 && popd \
 && rm -rf ~/rpm \
 && pushd ~/rpmbuild/RPMS/x86_64 \
 && rpm -Uvh rpm-4* rpm-libs-* rpm-build-* python2-rpm-* rpm-sign-* \
 && popd \
 && rm -rf ~/rpmbuild \
 && git clone --depth=1 https://gitlab.com/debsigs/debsigs.git -b debsigs-0.1.18-debian ~/src/debsigs \
 && pushd ~/src/debsigs \
 && echo -e '--- a/debsigs\n+++ b/debsigs\n@@ -101,7 +101,7 @@ sub cmd_sign($) {\n   #  my $gpgout = forktools::forkboth($arfd, $sigfile, "/usr/bin/gpg",\n   #"--detach-sign");\n \n-  my @cmdline = ("gpg", "--openpgp", "--detach-sign");\n+  my @cmdline = ("gpg1", "--openpgp", "--detach-sign");\n \n   if ($key) {\n     push (@cmdline, "--default-key", $key);' >patch \
 && patch -p1 <patch \
 && perl Makefile.PL \
 && make install \
 && popd \
 && rm -rf ~/src \
 && yum -y autoremove \
    audit-libs-devel \
    automake \
    binutils-devel \
    bzip2-devel \
    db4-cxx \
    dbus-devel \
    elfutils-devel \
    elfutils-libelf-devel \
    file-devel \
    gdbm-devel \
    gettext-devel \
    ima-evm-utils-devel \
    libacl-devel \
    libarchive-devel \
    libcap-devel \
    libselinux-devel \
    libtool \
    libzstd-devel \
    lua-devel \
    ncurses-devel \
    openssl-devel \
    perl-ExtUtils-MakeMaker \
    popt-devel \
    python2-devel \
    python3-devel \
    readline-devel \
    xz-devel \
 && mkdir /usr/java \
 && ln -fs /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.362.b08-1.el7_9.i386 /usr/java/default32 \
 && cd / \
 && yum clean all \
 && find /usr/lib/locale/ -mindepth 1 -maxdepth 1 -type d -not -path '*en_US*' -exec rm -rf {} \; \
 && find /usr/share/locale/ -mindepth 1 -maxdepth 1 -type d -not -path '*en_US*' -exec rm -rf {} \; \
 && localedef --list-archive | grep -v -i ^en | xargs localedef --delete-from-archive \
 && mv /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl \
 && /usr/sbin/build-locale-archive \
 && echo "" >/usr/lib/locale/locale-archive.tmpl \
 && find /usr/share/{man,doc,info} -type f -delete \
 && rm -rf /etc/ld.so.cache \ && rm -rf /var/cache/ldconfig/* \
 && rm -rf /tmp/*

# Set default command
CMD ["/bin/bash"]

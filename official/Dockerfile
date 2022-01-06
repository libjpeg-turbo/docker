FROM centos:6

RUN rpm -Uvh https://vault.centos.org/6.10/updates/x86_64/Packages/openssl-1.0.1e-58.el6_10.x86_64.rpm \
 && cat /etc/yum.repos.d/CentOS-Base.repo | sed s/^mirrorlist=/#mirrorlist=/g | sed 's@^#baseurl=http://mirror\.centos\.org/centos/\$releasever@baseurl=https://vault.centos.org/6.10@g' >/etc/yum.repos.d/CentOS-Base.repo.new \
 && mv -f /etc/yum.repos.d/CentOS-Base.repo.new /etc/yum.repos.d/CentOS-Base.repo \
 && cat /etc/yum.repos.d/CentOS-fasttrack.repo | sed s/^mirrorlist=/#mirrorlist=/g | sed 's@^#baseurl=http://mirror\.centos\.org/centos/\$releasever@baseurl=https://vault.centos.org/6.10@g' >/etc/yum.repos.d/CentOS-fasttrack.repo.new \
 && mv -f /etc/yum.repos.d/CentOS-fasttrack.repo.new /etc/yum.repos.d/CentOS-fasttrack.repo \
 && yum -y update \
 && yum -y install epel-release.noarch \
 && yum -y install \
    dpkg.x86_64 \
    expect.x86_64 \
    gcc.x86_64 \
    gnupg.x86_64 \
    glibc-devel.x86_64 \
    glibc-devel.i686 \
    git.x86_64 \
    java-1.6.0-openjdk.x86_64 \
    java-1.6.0-openjdk-devel.x86_64 \
    https://vault.centos.org/6.10/os/i386/Packages/java-1.6.0-openjdk-1.6.0.41-1.13.13.1.el6_8.i686.rpm \
    libgcc.i686 \
    make.x86_64 \
    rpm-build.x86_64 \
    wget.x86_64 \
    yasm.x86_64 \
    perl-ExtUtils-MakeMaker \
    zip.x86_64 \
    https://www.rpmfind.net/linux/remi/enterprise/6/remi/x86_64/gnupg1-1.4.23-1.el6.remi.x86_64.rpm \
 && pushd /opt \
 && wget https://cmake.org/files/v2.8/cmake-2.8.12.2-Linux-i386.tar.gz \
 && tar xf cmake-2.8.12.2-Linux-i386.tar.gz \
 && rm cmake-2.8.12.2-Linux-i386.tar.gz \
 && mv cmake-2.8.12.2-Linux-i386 cmake \
 && popd \
 && git clone --depth=1 https://gitlab.com/debsigs/debsigs.git -b debsigs-0.1.15%7Eroam1 ~/src/debsigs \
 && pushd ~/src/debsigs \
 && echo -e '--- a/debsigs\n+++ b/debsigs\n@@ -101,7 +101,7 @@ sub cmd_sign($) {\n   #  my $gpgout = forktools::forkboth($arfd, $sigfile, "/usr/bin/gpg",\n   #"--detach-sign");\n \n-  my @cmdline = ("gpg", "--openpgp", "--detach-sign");\n+  my @cmdline = ("gpg1", "--openpgp", "--detach-sign");\n \n   if ($key) {\n     push (@cmdline, "--default-key", $key);' >patch \
 && patch -p1 <patch \
 && perl Makefile.PL \
 && make install \
 && popd \
 && rm -rf ~/src \
 && yum -y remove perl-ExtUtils-MakeMaker gdbm-devel db4-cxx \
 && mkdir /usr/java \
 && rpm -i --force https://vault.centos.org/6.10/os/i386/Packages/java-1.6.0-openjdk-devel-1.6.0.41-1.13.13.1.el6_8.i686.rpm \
 && ln -fs /usr/lib/jvm/java-1.6.0-openjdk /usr/java/default32 \
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

# Set environment
ENV PATH /opt/cmake/bin:${PATH}

# Set default command
CMD ["/bin/bash"]

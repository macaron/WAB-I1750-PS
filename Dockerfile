FROM ubuntu:22.04

WORKDIR /openwrt

RUN apt update && apt install -y \
  bison \
  build-essential \
  clang \
  flex \
  g++ \
  gawk \
  gcc-multilib \
  g++-multilib \
  gettext \
  git \
  libncurses-dev \
  libssl-dev \
  python3-distutils \
  rsync \
  unzip \
  zlib1g-dev \
  file \
  wget \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/

RUN git clone https://github.com/openwrt/openwrt . \
  && git checkout b18edb1bfa34420fde1404d9d1e619c889557154 \
  && ./scripts/feeds update -a \
  && ./scripts/feeds install -a \
  && groupadd -g 1100 elecombuilder \
  && useradd -m -s /bin/bash -u 1100 -g 1100 elecombuilder \
  && chown -R elecombuilder:elecombuilder /openwrt

COPY .config .

USER elecombuilder

CMD make -j$(nproc)

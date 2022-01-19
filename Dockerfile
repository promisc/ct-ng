FROM ubuntu:20.04

# Dependencies from 
# https://github.com/crosstool-ng/crosstool-ng/issues/1344#issue-624115453
# 
# Non-essential:
#  *coreutils - for nproc
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    autoconf \
    automake \
    bison \
    build-essential \
    bzip2 \
    ca-certificates \
    coreutils \
    flex \
    gawk \
    gettext \
    git \
    gperf \
    help2man \
    libncurses-dev \
    libtool-bin \
    patch \
    python3-dev \
    rsync \
    texinfo \
    unzip \
    wget \
    xz-utils \
    && rm -rf /var/lib/apt/lists/* \
    && git clone https://github.com/crosstool-ng/crosstool-ng.git \
    && cd crosstool-ng \
    && ./bootstrap \
    && ./configure --prefix=/usr \
    && make -j $(nproc) \
    && make install \
    && cd .. \
    && rm -rf crosstool-ng \
    && adduser --disabled-password --gecos '' builder

USER builder
WORKDIR /home/builder

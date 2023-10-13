FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    gawk \
    wget \
    git \
    diffstat \
    unzip \
    texinfo \
    gcc \
    build-essential \
    chrpath \
    socat \
    cpio \
    python3 \
    python3-pip \
    python3-pexpect \
    xz-utils \
    debianutils \
    iputils-ping \
    python3-git \
    python3-jinja2 \
    libegl1-mesa \
    libsdl1.2-dev \
    python3-subunit \
    mesa-common-dev \
    zstd \
    liblz4-tool \
    file \
    locales \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get autoremove -y \
  && apt-get clean

RUN locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

RUN python3 -m pip install --no-cache-dir --upgrade pip

RUN useradd -ms /bin/bash user
USER user
WORKDIR /home/user
RUN mkdir -p rdos
WORKDIR /home/user/rdos

RUN echo "c"

RUN git clone --depth 1 -b mickledore git://git.yoctoproject.org/poky.git && \
    cd poky || exit 1 && \
    mkdir sources && \
    cd sources || exit 1 && \
    git clone --depth 1 -b mickledore https://github.com/openembedded/meta-openembedded.git && \
    git clone --depth 1 -b mickledore git://git.yoctoproject.org/meta-raspberrypi.git && \
    git clone --depth 1 -b mickledore git://git.yoctoproject.org/meta-virtualization.git && \
    git clone --depth 1 -b mickledore https://github.com/Robotics-Deployment/meta-robotics-deployment.git

RUN mkdir -p poky/build/conf &&  \
    cp poky/sources/meta-robotics-deployment/build/conf/local.conf.sample poky/build/conf/local.conf && \
    cp poky/sources/meta-robotics-deployment/build/conf/bblayers.conf.sample poky/build/conf/bblayers.conf

WORKDIR /home/user/rdos/poky

RUN echo "source oe-init-build-env" >> ~/.bashrc

CMD ["sleep", "infinity"]

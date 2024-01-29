FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="Deniz Hofmeister"
LABEL description="Robotics Deployment OS compiler"

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

RUN devadd -ms /bin/bash dev
USER dev
WORKDIR /home/dev
RUN mkdir -p rdos
WORKDIR /home/dev/rdos

WORKDIR /home/dev/rdos/poky

RUN echo "source oe-init-build-env" >> ~/.bashrc

CMD ["sleep", "infinity"]

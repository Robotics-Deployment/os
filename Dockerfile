FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    chrpath \
    cpio \
    debianutils \
    diffstat \
    file  \
    gawk \
    gcc \
    git \
    iputils-ping \
    libegl1-mesa \
    liblz4-tool  \
    libsdl1.2-dev \
    locales \
    mesa-common-dev \
    nano \
    pylint \
    python3 \
    python3-git \
    python3-jinja2 \
    python3-pexpect \
    python3-pip \
    python3-subunit \
    socat \
    texinfo \
    unzip \
    wget \
    xterm \
    xz-utils \
    zstd \
    lz4 \
    curl \
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

CMD ["sleep", "infinity"]

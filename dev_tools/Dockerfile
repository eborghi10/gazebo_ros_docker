FROM ubuntu:16.04
LABEL maintainer="Emiliano Borghi"

# Setup environment
RUN apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV \
  LANG=en_US.UTF-8 \
  DEBIAN_FRONTEND=noninteractive \
  TERM=xterm

# Setup keys
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    apt-utils \
    curl \
    wget && \
    apt-get clean && \
    apt-get autoremove && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/doc

# Install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-vcstools

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get update && \
    apt-get install --no-install-recommends -y \
    sudo \
    xvfb \
    python-pip \
    git \
    git-lfs \
    mercurial \
    build-essential \
    software-properties-common \
    bash-completion \
    debian-keyring \
    debian-archive-keyring \
    ssh \
    openssh-server \
    tmux \
    mesa-utils \
    pkg-config \
    libprotobuf-dev \
    protobuf-compiler \
    libprotoc-dev \
    && \
    apt-get clean && \
    apt-get autoremove && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/doc

# Create a user with passwordless sudo
RUN adduser --gecos "Development User" --disabled-password emiliano
RUN adduser emiliano sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER root

CMD tmux
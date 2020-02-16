FROM ubuntu:18.04
LABEL maintainer="Emiliano Borghi"

ARG uid
ENV USER docker_ros

# Setup environment
RUN apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV \
  LANG=en_US.UTF-8 \
  DEBIAN_FRONTEND=noninteractive \
  TERM=xterm

# Tmux
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    git \
    sudo \
    tmux

# Create a user with passwordless sudo
RUN adduser --gecos "Development User" --disabled-password -u ${uid} $USER
RUN adduser $USER sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER root

# nvidia-docker2 for Ubuntu18.04
# FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04 as nvidia
RUN rm -rf /var/lib/apt/lists/*
ENV NVIDIA_VISIBLE_DEVICES=all 
ENV NVIDIA_DRIVER_CAPABILITIES=all

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

# ==================
# below sourced from https://gitlab.com/nvidia/opengl/blob/ubuntu18.04/base/Dockerfile

RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y --no-install-recommends \
        libxau6 libxau6:i386 \
        libxdmcp6 libxdmcp6:i386 \
        libxcb1 libxcb1:i386 \
        libxext6 libxext6:i386 \
        libx11-6 libx11-6:i386 && \
    rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu:/usr/lib/i386-linux-gnu${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# ==================
# below sourced from https://gitlab.com/nvidia/opengl/blob/ubuntu18.04/glvnd/runtime/Dockerfile

RUN apt-get update && apt-get install -y --no-install-recommends \
    	libglvnd0 libglvnd0:i386 \
	libgl1 libgl1:i386 \
	libglx0 libglx0:i386 \
	libegl1 libegl1:i386 \
	libgles2 libgles2:i386 && \
    rm -rf /var/lib/apt/lists/*

COPY 10_nvidia.json /usr/share/glvnd/egl_vendor.d/10_nvidia.json

USER $USER
CMD tmux
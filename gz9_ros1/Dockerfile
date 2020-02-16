FROM ubuntu_18

LABEL maintainer="Emiliano Borghi"

ARG ros1
ENV ROS1_DISTRO ${ros1}
ENV USER docker_ros

USER root

# Setup environment
RUN apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV \
  LANG=en_US.UTF-8 \
  DEBIAN_FRONTEND=noninteractive \
  TERM=xterm

RUN apt-get remove -y --purge xserver-xorg

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    gnupg2 \
    mesa-utils \
    sudo \
    tmux \
    wget \
    xserver-xorg

RUN dpkg-reconfigure xserver-xorg

# Add ROS keys
# https://discourse.ros.org/t/new-gpg-keys-deployed-for-packages-ros-org/9454
RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# Add Gazebo keys
RUN echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" > /etc/apt/sources.list.d/gazebo-stable.list
RUN wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -

# Install ROS packages
RUN apt-get update && \
    apt-get install -y \
    ros-${ROS1_DISTRO}-desktop

RUN apt-get update && \
    apt-get install -y \
    gazebo9 \
    libgazebo9-dev \
    ros-${ROS1_DISTRO}-gazebo-ros-pkgs \
    ros-${ROS1_DISTRO}-gazebo-ros-control

# ==================

# nvidia-docker2 for Ubuntu18.04
# FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04 as nvidia
RUN rm -rf /var/lib/apt/lists/*
ENV NVIDIA_VISIBLE_DEVICES=all 
ENV NVIDIA_DRIVER_CAPABILITIES=all

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-utils

# ==================
# below sourced from https://gitlab.com/nvidia/opengl/blob/ubuntu18.04/base/Dockerfile

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        libxau6 libxau6:i386 \
        libxdmcp6 libxdmcp6:i386 \
        libxcb1 libxcb1:i386 \
        libxext6 libxext6:i386 \
        libx11-6 libx11-6:i386 && \
    rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu:/usr/lib/i386-linux-gnu${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# ==================
# below sourced from https://gitlab.com/nvidia/opengl/blob/ubuntu18.04/glvnd/runtime/Dockerfile

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    	libglvnd0 libglvnd0:i386 \
      libgl1 libgl1:i386 \
      libglx0 libglx0:i386 \
      libegl1 libegl1:i386 \
      libgles2 libgles2:i386 && \
    rm -rf /var/lib/apt/lists/*

COPY 10_nvidia.json /usr/share/glvnd/egl_vendor.d/10_nvidia.json

# ==================

RUN rosdep init
USER $USER
RUN echo ". /opt/ros/${ROS1_DISTRO}/setup.bash" >> /home/${USER}/.bashrc
RUN rosdep update
USER root

# Workspace
RUN mkdir -p /catkin_ws/src/ && \
    chown -R $USER /catkin_ws

WORKDIR /catkin_ws/

RUN usermod -a -G video $USER
RUN usermod -a -G dialout $USER

RUN apt-get update

USER $USER
ENTRYPOINT tmux

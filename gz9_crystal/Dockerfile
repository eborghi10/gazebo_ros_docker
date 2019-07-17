FROM ubuntu_18
LABEL maintainer="Emiliano Borghi"

ENV ROS2_DISTRO crystal
ENV USER packt

USER root

# Tmux
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    curl \
    gnupg2 \
    lsb-release \
    sudo \
    tmux

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN curl http://repo.ros2.org/repos.key | apt-key add -

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list
RUN echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list

# install ros2 packages
RUN apt-get update && \
    apt-get install -y \
    ros-$ROS2_DISTRO-desktop

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    ros-$ROS2_DISTRO-gazebo-*

# install ros2 packages
RUN apt-get update && apt-get install -y \
    ros-$ROS2_DISTRO-ros1-bridge \
    python3-argcomplete \
    python3-colcon-common-extensions

# Source ros2 automatically
RUN echo ". /opt/ros/$ROS2_DISTRO/setup.bash" >> /home/$USER/.bashrc

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

# Workspace
RUN mkdir -p /colcon_ws/src/ && \
    chown -R $USER /colcon_ws
RUN rosdep init
USER $USER
WORKDIR /colcon_ws/
RUN rosdep update
USER root

RUN apt-get update

USER $USER
ENTRYPOINT tmux

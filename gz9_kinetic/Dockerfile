FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 as nvidia
FROM ros:kinetic-ros-base
LABEL maintainer="$USER Borghi"

ENV ROS1_DISTRO kinetic
ENV USER packt

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
    mesa-utils \
    sudo \
    tmux \
    wget \
    xserver-xorg

RUN dpkg-reconfigure xserver-xorg

# Create a user with passwordless sudo
RUN adduser --gecos "Development User" --disabled-password $USER
RUN adduser $USER sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER root

# Setup sources.list
RUN echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list

# Setup keys
RUN wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -

# Install ROS packages
RUN apt-get update && \
    apt-get install -y \
    ros-kinetic-desktop

RUN apt-get update && \
    apt-get install -y \
    gazebo9 \
    libgazebo9-dev \
    ros-$ROS1_DISTRO-gazebo9-ros-pkgs \
    ros-$ROS1_DISTRO-gazebo9-ros-control

# Installing OpenGL for nvidia-docker2
# https://stackoverflow.com/a/53823600

COPY --from=nvidia /usr/local /usr/local
COPY --from=nvidia /etc/ld.so.conf.d/glvnd.conf /etc/ld.so.conf.d/glvnd.conf

ENV NVIDIA_VISIBLE_DEVICES=all NVIDIA_DRIVER_CAPABILITIES=all

# ==================

USER $USER
RUN echo ". /opt/ros/$ROS1_DISTRO/setup.bash" >> /home/$USER/.bashrc
RUN rosdep update
USER root

# Workspace
RUN mkdir -p /catkin_ws/src/ && \
    chown -R $USER /catkin_ws

WORKDIR /catkin_ws/

RUN usermod -a -G video $USER
RUN usermod -a -G dialout $USER

USER $USER
ENTRYPOINT tmux

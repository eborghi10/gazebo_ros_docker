FROM ubuntu_18

LABEL maintainer="Emiliano Borghi"

ARG ros1
ENV ROS1_DISTRO ${ros1}
ARG gz
ENV GZ_VERSION ${gz}
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
    gazebo${GZ_VERSION} \
    libgazebo${GZ_VERSION}-dev

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

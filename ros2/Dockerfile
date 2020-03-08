FROM ubuntu_18
LABEL maintainer="Emiliano Borghi"

ARG ros2
ENV ROS2_DISTRO ${ros2}
ARG gz
ENV GZ_VERSION ${gz}
ENV USER docker_ros

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
RUN echo ". /opt/ros/$ROS2_DISTRO/setup.bash" >> /home/${USER}/.bashrc

# ==================

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

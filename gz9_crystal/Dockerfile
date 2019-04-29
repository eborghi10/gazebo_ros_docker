FROM ros:crystal-ros-base
LABEL maintainer="Emiliano Borghi"

ENV ROS2_DISTRO crystal
ENV USER packt

# Create a user with passwordless sudo
RUN adduser --gecos "Development User" --disabled-password $USER
RUN adduser $USER sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER root

# Tmux
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    tmux

# install ros2 packages
RUN apt-get update && apt-get install -y \
    ros-$ROS2_DISTRO-desktop=0.6.1-0* \
    && rm -rf /var/lib/apt/lists/*

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    ros-$ROS2_DISTRO-gazebo-* \
  && rm -rf /var/lib/apt/lists/*

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list

# install ros2 packages
RUN apt-get update && apt-get install -y \
    ros-$ROS2_DISTRO-ros1-bridge=0.6.2-0* \
    && rm -rf /var/lib/apt/lists/*

# Source ros2 automatically
RUN echo ". /opt/ros/$ROS2_DISTRO/setup.bash" >> /home/$USER/.bashrc

# nvidia-docker hooks
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

# Workspace
RUN mkdir -p /colcon_ws/src/ && \
    chown -R $USER /colcon_ws
USER $USER
WORKDIR /colcon_ws/
RUN rosdep update
USER root

USER $USER
ENTRYPOINT tmux

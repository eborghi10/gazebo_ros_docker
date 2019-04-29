FROM dev_tools
LABEL maintainer="Emiliano Borghi"

# Setup environment
ENV ROS_DISTRO=kinetic

# Setup keys
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

# Setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list

# Install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall

# Install ROS packages
RUN apt-get update && \
    apt-get install -y \
    ros-kinetic-desktop-full

# Initialize rosdep
RUN rosdep init

RUN apt-get update && \
    apt-get install -y \
    ros-kinetic-control-toolbox

RUN apt-get install -y ros-kinetic-hardware-interface \
    ros-kinetic-controller-manager \
    ros-kinetic-joint-limits-interface \
    ros-kinetic-transmission-interface \
    ros-kinetic-kobuki-keyop \
    ros-kinetic-rosbridge-server \
    ros-kinetic-rosserial* \
    && \
    apt-get clean && \
    apt-get autoremove && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/doc

RUN pip install --upgrade pip
RUN pip install matplotlib

USER emiliano
RUN echo ". /opt/ros/kinetic/setup.bash" >> /home/emiliano/.bashrc
USER root

# Workspace
RUN mkdir -p /catkin_ws/src/ && \
    chown -R emiliano /catkin_ws
USER emiliano
WORKDIR /catkin_ws/
RUN rosdep update
USER root

COPY ./fstab /etc/fstab

RUN usermod -a -G video emiliano
RUN usermod -a -G dialout emiliano

USER emiliano
ENTRYPOINT tmux

#!/bin/bash

CONTAINER=""

while [ "$1" != "" ]; do
    case "$1" in
        -d | --docker )  CONTAINER="$2";  shift;;
        --no-nvidia ) NVIDIA="FALSE"; shift;;
    esac
    shift
done

IMAGE_NAME=$CONTAINER

NVIDIA_FLAG="--runtime=nvidia"
if [[ $NVIDIA = "FALSE" ]]; then
  NVIDIA_FLAG=""
fi

DOCKER_MOUNT_ARGS="\
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v /lib/modules:/lib/modules \
    -v /home/$USER/catkin_ws/src:/catkin_ws/src \
    -v /home/$USER/colcon_ws/src:/colcon_ws/src"

DOCKER_CAPABILITIES="--ipc=host \
                     --cap-add=IPC_LOCK \
                     --cap-add=sys_nice"

DOCKER_NETWORK="--network=host"

xhost +
docker run --name $IMAGE_NAME --privileged --rm \
        $DOCKER_CAPABILITIES \
        $DOCKER_MOUNT_ARGS \
        -v /etc/fstab:/etc/fstab:ro \
        --device=/dev/ttyUSB0 \
        -e ROS_HOSTNAME=localhost \
        -e ROS_MASTER_URI=http://localhost:11311 \
        -e DISPLAY=$DISPLAY \
        $DOCKER_NETWORK \
        $NVIDIA_FLAG \
        -it $IMAGE_NAME
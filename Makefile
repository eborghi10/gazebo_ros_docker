# If you want to rebuild all images, set this to --no-cache from the commandline
DOCKER_ARGS?=

# You need to specify a particular target
#--------------------------------------------------------------------------
# Stable and local targets

.PHONY: ros1_nvidia
ros1_nvidia: ros1
	docker build ${DOCKER_ARGS} -t ros1_nvidia ros1_nvidia

.PHONY: ros2_nvidia
ros2_nvidia: ros2
	docker build ${DOCKER_ARGS} -t ros2_nvidia ros2_nvidia

.PHONY: ros1
ros1: ubuntu_18
	docker build ${DOCKER_ARGS} --build-arg ros1=$(ROS_VERSION) --build-arg gz=$(GZ_VERSION) -t ros1 ros1

.PHONY: ros2
ros2: ubuntu_18
	docker build ${DOCKER_ARGS} --build-arg ros2=$(ROS_VERSION) --build-arg gz=$(GZ_VERSION) -t ros2 ros2

.PHONY: ubuntu_18
ubuntu_18:
	docker build ${DOCKER_ARGS} --build-arg uid=$(shell id -u) -t ubuntu_18 ubuntu_18

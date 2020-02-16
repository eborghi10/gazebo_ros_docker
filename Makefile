# If you want to rebuild all images, set this to --no-cache from the commandline
DOCKER_ARGS?=

# You need to specify a particular target
#--------------------------------------------------------------------------
# Stable and local targets

.PHONY: gz9_ros1
gz9_ros1: ubuntu_18
	docker build ${DOCKER_ARGS} --build-arg ros1=$(VERSION) -t gz9_ros1 gz9_ros1

.PHONY: gz9_ros2
gz9_ros2: ubuntu_18
	docker build ${DOCKER_ARGS} --build-arg ros2=$(VERSION) -t gz9_ros2 gz9_ros2

.PHONY: ubuntu_18
ubuntu_18:
	docker build ${DOCKER_ARGS} --build-arg uid=$(shell id -u) -t ubuntu_18 ubuntu_18

# Dockers: ROS + Gazebo

### Available Dockers

- `gz9_kinetic` : ROS Kinetic + Gazebo 9 (Ubuntu 16.04)
- `gz9_crystal` : ROS 2 Crystal + Gazebo 9 (Ubuntu 18.04)

### Generate docker image

```bash
$ make $DOCKER_IMAGE
```

### Run docker image

```bash
./run_docker.sh -d $DOCKER_IMAGE
```

### NOTES

- You need to have installed `nvidia-docker2` in your machine in order to make it work. If you don't have it, disable the `--runtime=nvidia` line in `run_docker.sh`.

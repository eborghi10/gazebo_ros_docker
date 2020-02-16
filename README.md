# Dockers: ROS + Gazebo

### Available Dockers

- `gz9_ros1` : ROS 1 + Gazebo 9 (Ubuntu 16.04)
- `gz9_ros2` : ROS 2 + Gazebo 9 (Ubuntu 18.04)

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

----

# Compile any ROS 2 version

The following example is given with ROS 2 Dashing.

```bash
make VERSION=dashing gz9_ros2
```

Try the image:

```bash
./run_docker.sh -d gz9_ros2
```

```bash
$ echo $ROS_DISTRO
dashing
```

# Compile ROS 1 Melodic with Gazebo

```bash
make VERSION=melodic gz9_ros1
```

Try the image:

```bash
./run_docker.sh -d gz9_ros1
```

```bash
$ echo $ROS_DISTRO
melodic
```

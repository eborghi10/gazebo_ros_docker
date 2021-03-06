# Dockers: ROS + Gazebo

## Available Dockers

- ROS 1 (Melodic release only) + Gazebo 9
- ROS 2 + Gazebo 9

## Generate docker image

```bash
./build
```

### Optional arguments

- [`-r1`|`--ros1`]: select ROS 1 version (`melodic`). Enabled by default.
- [`-r2`|`--ros2`]: select ROS 2 version.
- [`-g`|`--gazebo`]: select Gazebo version. Only Gazebo 9 is supported for ROS 2.

### Examples

ROS 1 Melodic + Gazebo 11

```bash
./build --gazebo 11
```

ROS 2 Eloquent + Gazebo 9

```bash
./build --ros2 eloquent
```

## Run docker image

```bash
./run
```

### Optional arguments

- [`-r1`|`--ros1`]: select ROS 1 version (`melodic`). Enabled by default.
- [`-r2`|`--ros2`]: select ROS 2 version.
- [`-c`|`--cmd`]: run command (default is `bash`). `tmux` can be used too.
- [`-ws`|`--workspace`]: select workspace to be mounted from the host.

**Note:** You don't need to specify the Gazebo version.

### Examples

ROS 1 Melodic + Gazebo 11

```bash
./run --cmd tmux
```

ROS 2 Eloquent + Gazebo 9

```bash
./run --ros2 eloquent -ws "/home/my_user/my_colcon_ws"
```

### IMPORTANT

- You need to have installed `nvidia-docker2` in your machine in order to make it work **ONLY** if you have an Nvidia GPU.

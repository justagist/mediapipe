#!/bin/bash

# Description: starts container and opens an interactive bash shell using image tag passed as parameter
# Usage: ./bash.sh <docker-image-tag>
# Example: ./bash.sh dev:indigo-cuda

DOCKER_IMAGE="mediapipe"

source $HOME/.bashrc

nvidia-docker run -it \
                   --user=$(id -u) \
                   --env="DISPLAY" \
                   --network="host" \
                   --cap-add=sys_nice \
                   --privileged \
                   --env="QT_X11_NO_MITSHM=1" \
                   --workdir="/mediapipe" \
                   --volume="/home/$USER:/home/$USER" \
                   --volume="/etc/group:/etc/group:ro" \
                   --volume="/etc/passwd:/etc/passwd:ro" \
                   --volume="/etc/shadow:/etc/shadow:ro" \
                   --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
                   --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
                   --volume="/io:/mediapipe" --runtime nvidia \
                   $DOCKER_IMAGE \
                   bash 

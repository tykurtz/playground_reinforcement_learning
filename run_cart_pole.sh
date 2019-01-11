#!/usr/bin/env bash
# If you run into "No protocol specified" read here http://wiki.ros.org/docker/Tutorials/GUI#Using_X_server
docker run -it --runtime=nvidia --rm \
               -e DISPLAY=$DISPLAY \
               --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
               playground_reinforcement_learning python3 cart-pole/play_cart_pole.py

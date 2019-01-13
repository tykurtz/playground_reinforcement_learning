#!/usr/bin/env bash
# If you run into "No protocol specified" read here http://wiki.ros.org/docker/Tutorials/GUI#Using_X_server
docker run -it playground_reinforcement_learning python3 frozen-lake/play_frozen_lake.py

#!/usr/bin/env bash
# Raspberry Pi terminal 2, while recording_session is running.
set -euo pipefail
cd "$HOME/ros2_ws/src/so101-ros-physical-ai"
ros2 run episode_recorder teleop_episode_keyboard

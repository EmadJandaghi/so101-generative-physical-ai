#!/usr/bin/env bash
# STATUS: guide-derived command, must match the installed ROS/LeRobot version.
# Raspberry Pi terminal 2, with inference bringup running in terminal 1.
set -euo pipefail
cd "$HOME/ros2_ws/src/so101-ros-physical-ai"
pixi run -e lerobot infer -- --ros-args \
  -p repo_id:="${ACT_MODEL_REPO:-Emadodin/act_so101_manual_v1}" \
  -p task:="pick the green cube and place it in the target zone"

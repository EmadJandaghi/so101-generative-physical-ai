#!/usr/bin/env bash
# Raspberry Pi: discover the actual installed source/config files and report missing items.
set -euo pipefail
SRC="${SO101_SRC:-$HOME/ros2_ws/src/so101-ros-physical-ai}"
printf 'ROS stack source: %s\n' "$SRC"
for item in \
  so101_bringup \
  episode_recorder \
  rosbag_to_lerobot \
  policy_server \
  so101_inference; do
  if test -e "$SRC/$item"; then echo "FOUND  $SRC/$item"; else echo "MISSING $SRC/$item"; fi
done
for item in \
  "$SRC/rosbag_to_lerobot/config/so101_50hz.yaml" \
  "$HOME/ros2_ws/src/so101_pick_place/config/cameras/local_cameras.yaml"; do
  if test -f "$item"; then echo "FOUND  $item"; else echo "CHECK  $item"; fi
done

#!/usr/bin/env bash
# SOURCE: guide-derived, intended for a NEW dataset, not your existing 111-demo repo.
# Run on the Raspberry Pi only after the named recording session is available.
set -euo pipefail
cd "$HOME/ros2_ws/src/so101-ros-physical-ai"
pixi run -e lerobot convert -- \
  --input-dir "$HOME/.ros/so101_episodes/manual_pickplace_new_v1" \
  --config "$HOME/ros2_ws/src/so101-ros-physical-ai/rosbag_to_lerobot/config/so101_50hz.yaml" \
  --repo-id "${HF_DATASET_REPO:?Set HF_DATASET_REPO to a NEW dataset repository ID}" \
  "$@"

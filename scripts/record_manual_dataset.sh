#!/usr/bin/env bash
# SOURCE: adapted from supplied SO-101 reproducibility guides (2026-11-16).
# STATUS: documented course-style commands; NOT independently re-run from this archive.
# RUN ON: Raspberry Pi, in terminal 1. Keep terminal 2 for keyboard recorder.
set -euo pipefail
cd "$HOME/ros2_ws/src/so101-ros-physical-ai"
ros2 launch so101_bringup recording_session.launch.py \
  experiment_name:=manual_pickplace_new_v1 \
  task:="pick the green cube and place it in the target zone" \
  use_rerun:=true

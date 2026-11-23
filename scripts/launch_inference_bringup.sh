#!/usr/bin/env bash
# Raspberry Pi terminal 1: launch camera streams and controller.
# SOURCE: ACT, SmolVLA, π₀.₅ guides; configuration file originates in course package.
set -euo pipefail
CAMERAS="$(ros2 pkg prefix so101_pick_place)/share/so101_pick_place/config/cameras/local_cameras.yaml"
test -f "$CAMERAS" || { echo "Missing cameras YAML: $CAMERAS" >&2; exit 1; }
ros2 launch so101_bringup inference.launch.py cameras_config_file:="$CAMERAS"

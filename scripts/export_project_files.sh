#!/usr/bin/env bash
# RUN ON Raspberry Pi. Make a local staging archive for review before publishing.
# The export MAY contain upstream/licensed course code, user-specific configs or secrets.
# DO NOT upload the resulting archive publicly without first reviewing and separating ownership.
set -euo pipefail
SO101_SRC="${SO101_SRC:-$HOME/ros2_ws/src/so101-ros-physical-ai}"
COURSE_SRC="${COURSE_SRC:-$HOME/ros2_ws/src/so101_pick_place}"
OUT="${1:-$HOME/so101_source_review.tar.gz}"
TEMP="$(mktemp -d)"
trap 'rm -rf "$TEMP"' EXIT
mkdir -p "$TEMP/source_review/upstream" "$TEMP/source_review/course"
for dir in so101_bringup so101_inference episode_recorder rosbag_to_lerobot policy_server; do
 if test -d "$SO101_SRC/$dir"; then cp -a "$SO101_SRC/$dir" "$TEMP/source_review/upstream/"; fi
done
if test -d "$COURSE_SRC/config"; then cp -a "$COURSE_SRC/config" "$TEMP/source_review/course/"; fi
# Only export the camera YAML if found; do not invent its contents.
if test -f "$COURSE_SRC/config/cameras/local_cameras.yaml"; then
 cp -a "$COURSE_SRC/config/cameras/local_cameras.yaml" "$TEMP/source_review/course/"
fi
printf '%s\n' 'REVIEW REQUIRED: contains possible third-party content and machine-specific configuration.' > "$TEMP/source_review/DO_NOT_PUBLISH_UNREVIEWED.txt"
tar -C "$TEMP" -czf "$OUT" source_review
echo "Created $OUT. Review licenses, confidential data and modifications before publishing."

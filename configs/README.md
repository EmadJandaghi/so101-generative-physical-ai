# Where the REAL YAML files are

The uploaded guides reference these actual source-controlled configuration files:

1. Raspberry Pi upstream converter configuration:
   `~/ros2_ws/src/so101-ros-physical-ai/rosbag_to_lerobot/config/so101_50hz.yaml`
2. Course pick-and-place camera configuration:
   `~/ros2_ws/src/so101_pick_place/config/cameras/local_cameras.yaml`
   (The guides also refer to the *installed* share form from `ros2 pkg prefix so101_pick_place`.)
3. Upstream robot bringup, camera publishers, teleoperation, and inference launch files:
   `~/ros2_ws/src/so101-ros-physical-ai/so101_bringup/launch/`
4. Device symlinks observed on the user's Pi:
   `/dev/cam_wrist`, `/dev/cam_overhead`, `/dev/so101_leader`, `/dev/so101_follower`.

**These YAML files cannot be reconstructed faithfully from the PDFs.** They include
camera-specific values and schema established by the installed code. The proper next
step is to retrieve the working files from the Raspberry Pi, inspect licenses and
machine-local settings, and then commit the configurations you own or have permission
to redistribute. Do not substitute made-up YAML with guessed camera parameters.

Use `scripts/check_required_so101_files.sh` on the Pi to locate prerequisites.

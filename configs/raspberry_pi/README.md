# SO-101 Raspberry Pi camera configuration (captured November 2026)

These are exact working-machine configuration snapshots from the owner's Raspberry Pi, not generic defaults. They have not been run from this GitHub export. Preserve the upstream license notices and confirm file provenance before sharing adaptations.

| File | Original installed path |
| --- | --- |
| `local_cameras.yaml` | `so101_pick_place/config/cameras/local_cameras.yaml` |
| `cam_overhead.yaml` | `so101_pick_place/config/cameras/cam_overhead.yaml` |
| `so101_gs_cam.yaml` | `so101-ros-physical-ai/so101_bringup/config/cameras/so101_gs_cam.yaml` |

- Two 640×480 RGB camera feeds, requested 30 FPS.
- `local_cameras.yaml` references calibration via `package://so101_pick_place/config/cameras/cam_overhead.yaml`.
- Device symlinks `/dev/cam_wrist` and `/dev/cam_overhead` must exist on the target Pi.
- Overhead GStreamer controls include fixed autofocus position 20 and `exposure_dynamic_framerate=0`; **this does not establish fixed exposure**.
- The original `so101_gs_cam.yaml` is an upstream configuration with a one-line user modification. See upstream copyright/license when using adapted files.
- The camera calibration is specific to this camera and setup; recalibrate for different mounts or cameras.

### Use with your existing installed ROS 2 workspace

These files are documentation/reference copies. **Do not run or overwrite your working Pi config solely because you downloaded this repository.** To apply intentionally, copy each file into the matching installed path and rebuild/re-source the relevant ROS workspace as needed. The upstream ROS launch files themselves are retained separately as reference snapshots.

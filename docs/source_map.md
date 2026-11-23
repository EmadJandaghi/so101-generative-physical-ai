# Source code inventory and ownership

| Files | Source | Publish here? |
|---|---|---|
| SO-101 ROS 2 packages: bringup, camera, teleop, inference, recorder, converter | [legalaspro/so101-ros-physical-ai](https://github.com/legalaspro/so101-ros-physical-ai) | Treat as dependency. Preserve upstream notices if you include modified licensed code. |
| `so101_pick_place` and `local_cameras.yaml` | The Construct course Bitbucket repo or Pi installation | Review permission and distinguish custom device settings before copying. |
| ACT/SmolVLA/π₀.₅ policy model implementations | [huggingface/lerobot](https://github.com/huggingface/lerobot) | Install version-pinned dependency; do not copy entire framework. |
| Actual training job scripts, original YAML edits | User's Pi and HPC systems | Publish verified user changes after review. |
| Custom π₀.₅ LeRobot 0.7.0 ZMQ server | `so101_pi05_zmq_adapter.zip` saved from deployment | Source now supplied and included under `deployment/pi05_zmq_adapter/` with retained upstream notices; test against an actual GPU is not part of this export. |
| ACT, SmolVLA, π₀.₅ weights | Hugging Face | Link, not commit large model files. |

This package adds adapted shell scripts based on the uploaded guides. They are not copies of historical executed job scripts, and cannot replace missing runtime packages.

## Uploaded Pi archive, November 20, 2026

The user supplied an archive with eight exact source files. Copies are now stored in `configs/`, `upstream_reference/`, and `deployment/raspberry_pi/`. No files were fetched from an unverified external source for this addition. One hardcoded transient Vast.ai address in the Pi's original prediction-only diagnostic was converted to `SO101_ZMQ_SERVER` for safer publication. All three launch files are explicitly labeled upstream reference snapshots. These files are inspected for parse/syntax, but no live Raspberry Pi run or physical tests were performed as part of this export.

## GPU recovery kit, uploaded November 20, 2026

The recovery bundle contained an identical copy of the adapter and the Pi prediction-only client, plus SmolVLA and π₀.₅ new-GPU recovery notes. The adapter source has now been added under `deployment/pi05_zmq_adapter/`. The separate legacy `setup_so101_pi05_vast.sh` requests LeRobot 0.5.1 and was deliberately **not** included as a recommended deployment method. It is an earlier unverified compatibility test.

## Unity shell scripts archive, November 23, 2026

Five actual saved `.sh` source files were supplied in `so101_unity_scripts.tar.gz` and copied byte-for-byte into `training/{act,pi05,diffusion,xvla,flux3}/`. Separately, the SmolVLA Vast.ai training command is reconstructed from a November 9 conversation record and confirmed by the project owner. These scripts were **not executed as part of this repository export**. The historical ACT and π₀.₅ guide reconstructions were removed to avoid confusion with the recovered job scripts; the SmolVLA guide reconstruction remains clearly labeled. See [`unity_script_inventory.md`](unity_script_inventory.md).

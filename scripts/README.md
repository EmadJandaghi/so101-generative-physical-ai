# Working scripts and limitations

Scripts in this folder reproduce **the documented command flow**, but may still require the exact upstream repo versions and installed hardware setup. They have not been executed on the SO-101 from this artifact.

**Use on Raspberry Pi:**
- `check_required_so101_files.sh` locates the expected upstream ROS packages and YAML.
- `record_manual_dataset.sh` launches the recording session.
- `record_keyboard.sh` starts teleoperation episode control.
- `convert_dataset.sh` converts a *new* recording; set `HF_DATASET_REPO` before use.
- `launch_inference_bringup.sh` launches the robot/cameras using the installed course YAML.
- `launch_act_inference.sh` runs ACT with a configurable model repo.
- `export_project_files.sh` creates a **private source review archive** from your Pi; it is NOT safe to publish without reviewing third-party rights and secrets.

**Use on Unity:**
- `training/{act,smolvla,pi05}/train_*_RECONSTRUCTED.sbatch` are sample, guide-derived Slurm job scripts, not guaranteed to run on the current cluster as-is.

**Recovered since guide creation:** actual Pi camera/calibration YAML, dataset conversion YAML, three upstream ROS launch snapshots and a custom prediction-only client. **Still missing:** the historical custom π₀.₅ ZMQ adapter server and the original executed training scripts.

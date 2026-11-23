# Reproducibility record

## Verified project facts

- Dataset: `Emadodin/so101_pickplace_manual_extra_v1`, 111 manual episodes
- Camera keys: `observation.images.top` and `observation.images.wrist`
- Joint order: shoulder_pan, shoulder_lift, elbow_flex, wrist_flex, wrist_roll, gripper
- ACT: 20K and 100K checkpoints reported
- SmolVLA: 20K checkpoint, physically deployed
- π₀.₅: 10K expert-only fine-tuning on Unity A100 with LeRobot 0.7.0, physically deployed through custom ZMQ adapter
- ACT, SmolVLA, and π₀.₅: physically tested under normal and low light

## Before calling an experiment reproducible

- [x] Include recovered ACT/π₀.₅ Unity scripts and the owner-confirmed historical SmolVLA Vast.ai command
- [ ] Recover original training logs and exact environment details (a reconstructed command is not independent execution evidence)
- [ ] Capture LeRobot commit SHA, Python/PyTorch/CUDA/ROS versions
- [ ] Specify exact dataset revision and normalization/preprocessing
- [ ] Specify model initialization and checkpoint revision
- [ ] Specify optimizer, steps, batch size, seeds, GPU hardware, and training logs
- [ ] Document inference input/output transforms and action postprocessing
- [ ] Document versioned camera calibration and robot configuration
- [ ] Provide measured trial counts and protocol

Never publish tokens, credentials, network secrets, fixed transient IPs, or large checkpoint artifacts in normal Git commits.

**Robot safety:** Testing may issue real motor commands. Supervise the robot, verify motion limits, and keep a working emergency power cutoff.

# Training and inference paths

| Policy | Training location | Physical inference location / host | Implementation and verification |
| --- | --- | --- | --- |
| ACT (20K) | Original host not yet verified from surviving executed script | Pi CPU documented by The Construct and the updated guide; optional Vast.ai path described separately | Actual physical experiments confirmed; exact executed runtime variant(s) require source logs |
| ACT (100K) | Unity HPC | Pi CPU or optional remote, depending on the tested run | Saved Unity train script; infer runtime should be verified per video/run |
| SmolVLA (20K) | Vast.ai | Raspberry Pi ROS 2 client, Vast.ai ZMQ server | Model trained and deployed; uses course-style LeRobot 0.5.1 compatibility path |
| π₀.₅ (10K) | Unity A100 | Raspberry Pi ROS 2 client, Vast.ai ZMQ server | Physical run verified by guide; custom LeRobot 0.7.0 adapter and prediction-only client source included |

**Do not confuse training and inference:** a new Vast.ai inference rental loads an already trained checkpoint, rather than retraining it.

**Do not conflate the two servers:** the SmolVLA 0.5.1 course server and the π₀.₅ 0.7.0 custom adapter are distinct compatibility paths. Do not substitute either without checking the checkpoint, preprocessing, and protocol.

**Important:** the original 20K SmolVLA Vast.ai training command is not in the repository. See `training/smolvla/README.md`.

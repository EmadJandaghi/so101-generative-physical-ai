# Generative Physical AI for SO-101 Robotics

**Generative robot policy learning, deployment, and real-world evaluation**

An ongoing independent experimental project investigating generative robot policies, Vision-Language-Action (VLA) models, and emerging world-action models on a physical SO-101 robot arm. The project builds on existing open-source robotics software while documenting original data collection, model training, deployment integration, and real-world testing.

> **Status:** ACT, SmolVLA, and π₀.₅ have been trained and physically tested. New policy families are being investigated. This is not a claim to have invented the existing architectures.

## Project overview

| Aspect | Experiment |
| --- | --- |
| Robot | SO-101 leader and follower |
| Task | Pick a green cube and place it in a target zone |
| Training data | 111 manual demonstrations, including nine initial cube positions |
| Observations | Overhead and wrist camera images and six joint states |
| Software | ROS 2 Jazzy, Hugging Face LeRobot, Python/PyTorch |
| Compute | Raspberry Pi and remote GPUs, including URI Unity and Vast.ai |
| Physical evaluation | Normal and low-light conditions |

## Research questions

1. How do different generative action policies behave on the same physical manipulation task?
2. How does policy behavior change under different lighting conditions?
3. What compatibility, runtime, and execution challenges emerge on real hardware?
4. Can small, reproducible implementation or algorithm changes improve reliability?

## Policy progress

| Policy | Generative approach | Status |
| --- | --- | --- |
| ACT | Conditional VAE and action chunking | Trained; physically tested |
| SmolVLA | Flow matching | Trained; physically tested |
| π₀.₅ | Flow matching | Fine-tuned; physically tested |
| Diffusion Policy | Diffusion | Implementation investigation underway |
| X-VLA | VLA / generalist policy | Investigation underway |
| FLUX 3 Action | World-action modeling | 30 Hz conversion scripts recovered; completion and training not yet verified |
| VQ-BeT | Discrete action tokenization | Planned / studying |
| π₀-FAST | Tokenized actions | Planned / studying |
| NVIDIA GR00T | Robot foundation model / VLA | Planned |

The different policy categories overlap and are not a formal taxonomy. Future work is not described as successfully trained or deployed until independently verified.

## Actual platform workflow

The project began with Raspberry Pi/ROS 2 demonstration collection and **Vast.ai SmolVLA training**. Training later expanded onto **Unity HPC** for ACT 100K, π₀.₅ 10K, and further policy investigations. **Vast.ai was also used later for remote inference**, including SmolVLA and π₀.₅. ACT additionally has a documented Pi-CPU inference path. Training and deployment are separate stages and may use different machines.

The Construct's *PhysicalAI Robot Arm* course was the instructional reference; the recovered source/configurations and physical experiments are documented with provenance. See [experiment history](docs/workflow_history.md) and [policy-specific inference paths](deployment/inference_paths.md).

**SmolVLA command recovered:** The [Vast.ai 20K training command](training/smolvla/train_smolvla_vast.sh), with batch size 8, was recovered from our November 9 discussion and confirmed by the owner as correct. The original instance was destroyed, so this is a user-confirmed reconstruction, not an independently verified original shell script. The proposed Unity retraining example is labeled separately.

## Training dataset and checkpoints

**Dataset:** [SO-101 manual demonstrations, 111 episodes](https://huggingface.co/datasets/Emadodin/so101_pickplace_manual_extra_v1)

| Policy | Checkpoint |
| --- | --- |
| ACT, 20K steps | [Model](https://huggingface.co/Emadodin/act_so101_manual_v1) |
| ACT, 100K steps | [Model](https://huggingface.co/Emadodin/act_so101_manual_100k_unity) |
| SmolVLA, 20K steps | [Model](https://huggingface.co/Emadodin/smolvla_so101_manual_v1) |
| π₀.₅, 10K steps | [Model](https://huggingface.co/Emadodin/pi05_so101_manual_10k_unity) |

Some Hugging Face repositories may be private.

## Real-world robot experiments

All three initially trained policy families were run on the physical SO-101 under **normal light** and **low light**. Recorded videos can be used to illustrate behavior in both conditions.

| Policy | Normal light | Low light |
| --- | --- | --- |
| ACT | [Video to add](evaluation/videos.md) | [Video to add](evaluation/videos.md) |
| SmolVLA | [Video to add](evaluation/videos.md) | [Video to add](evaluation/videos.md) |
| π₀.₅ | [Video to add](evaluation/videos.md) | [Video to add](evaluation/videos.md) |

**Qualitative observations:** SmolVLA appeared to behave better than π₀.₅ in preliminary tests. π₀.₅ showed unnecessary actions and attempts to grasp a cube outside the intended workspace in some tests. These observations are not quantitative evidence of a generalized ranking. See [evaluation protocol](evaluation/README.md).

### Deployment work

The robot ran through a Raspberry Pi, ROS 2, and local or remote inference workflows. A custom ZMQ compatibility adapter allowed a LeRobot 0.7.0 π₀.₅ checkpoint to communicate with the existing physical SO-101 workflow where an older inference-server stack was incompatible. The recovered, adapted server source is included at [`deployment/pi05_zmq_adapter/`](deployment/pi05_zmq_adapter/); its origin and upstream license notices are documented. The export has not been retested on an active GPU.

### FLUX 3 Action dataset preparation

Recovered Unity source code for both [one-episode and full-dataset 50-to-30 Hz conversion](training/flux3/README.md) is now included. The scripts also rename the overhead observation key to `observation.images.scene`. Conversion success and FLUX 3 model training remain unverified.

## Repository organization

| Directory | Purpose |
| --- | --- |
| `configs/` | Actual recovered camera/calibration and dataset conversion YAML files |
| `upstream_reference/` | Original third-party ROS launch snapshots for provenance and compatibility |
| `data_collection/` | Dataset information and collection workflow |
| `training/` | Recovered Unity ACT/π₀.₅ scripts and newer-policy test/conversion scripts, plus the user-confirmed SmolVLA Vast.ai command |
| `deployment/` | Raspberry Pi deployment and π₀.₅ compatibility adapter |
| `evaluation/` | Video index, per-trial data template, protocol |
| `docs/` | Hardware, reproducibility, attribution and source provenance |
| `media/` | Selected original figures or media |
| `.github/` | Static checks for Python, shell, and YAML files |

**This repository includes actual recovered Raspberry Pi camera/calibration YAMLs, the 50 Hz dataset conversion YAML, one custom read-only π₀.₅ prediction client, and upstream ROS 2 launch-file snapshots.** Five actual saved Unity job scripts were recovered: ACT 100K, π₀.₅ 10K, Diffusion 100-step test, X-VLA 100-step test, and FLUX 3 dataset conversion. The user-confirmed SmolVLA 20K Vast.ai training command is included under `training/smolvla/`; a separate *proposed* Unity retraining example remains labeled unverified. The recovered π₀.₅ adapter source is present. Saved scripts alone do not prove job completion. See [camera configuration](configs/raspberry_pi/README.md), [dataset conversion](configs/dataset/README.md), [inference diagnostic](deployment/raspberry_pi/README.md), [Unity script inventory](docs/unity_script_inventory.md), and [upstream code snapshots](upstream_reference/README.md), and [GitHub publishing steps](docs/github_publishing.md).

## Acknowledgments

This project was informed by **The Construct's PhysicalAI Robot Arm course**, using the SO-101 reference ROS 2 framework developed by **Dmitri Manajev** and the **Hugging Face LeRobot** ecosystem.

- [The Construct](https://www.theconstruct.ai/)
- [Original SO-101 ROS Physical AI repository](https://github.com/legalaspro/so101-ros-physical-ai)
- [Hugging Face LeRobot](https://github.com/huggingface/lerobot)

This is an independent project and not an official release by those organizations. More detail and code-redistribution cautions are in [attribution](docs/attribution.md).

## Roadmap

- [x] Collect 111 manual demonstrations
- [x] Train and test ACT, SmolVLA, and π₀.₅ on real hardware
- [x] Test normal and low-light conditions and record videos
- [x] Validate physical π₀.₅ inference using a custom compatibility adapter
- [x] Recover Unity ACT/π₀.₅ scripts, two short test scripts, and FLUX 3 conversion job
- [x] Recover π₀.₅ compatibility adapter and Raspberry Pi configuration files
- [x] Document the owner-confirmed SmolVLA training command and recover FLUX 3 conversion source
- [ ] Recover original GPU job logs, exact software revisions, and training metrics where available
- [ ] Publish representative videos and trial-by-trial evaluations
- [ ] Expand experiments to additional policy families
- [ ] Validate a focused improvement against an unchanged baseline

**License:** A repository-wide license for original contributions has not yet been selected. Existing third-party Apache-2.0 notices are preserved. [Review the license decision](LICENSE-DECISION.md) before publishing.

**Safe publication:** The recovered ZMQ server does not provide authentication or encryption. Do not expose it openly to the internet; use a secured network or tunnel. [Deployment notes](deployment/pi05_zmq_adapter/README.md).

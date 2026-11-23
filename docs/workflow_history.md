# SO-101 experiment history and platform provenance

This document distinguishes the user's completed experiments from procedure guides and subsequent proposals.

## Actual experiment sequence

| Phase | Physical or cloud platform | What is supported | Evidence status |
| --- | --- | --- | --- |
| Hardware and data collection | SO-101 leader/follower, Raspberry Pi, ROS 2 Jazzy | 111 manual green-cube pick-and-place demonstrations with wrist and overhead cameras; nine starting positions | User's collected dataset and Pi configurations |
| Early policy training | Vast.ai | SmolVLA 20K run on the 111-demonstration dataset; ACT 20K model also exists | SmolVLA Vast.ai confirmed by owner; a reconstructed November 9 training command is now owner-confirmed, though original instance logs are unavailable; ACT 20K original GPU host not independently established |
| Extended training | URI Unity HPC | ACT 100K, π₀.₅ expert-only 10K; further Diffusion/X-VLA and FLUX 3 preparation | Saved ACT/π₀.₅ Unity shell scripts recovered; guides report completed runs; newer-policy test scripts do not prove trained models |
| Local and remote inference | SO-101 Raspberry Pi plus Vast.ai where applicable | Physical inference with ACT, SmolVLA and π₀.₅; normal and low-light video recordings | User's observations and demonstrations, actual Pi configuration files, and π₀.₅ adapter source |

## Inference path by model

- **ACT:** The Construct's primary taught path runs the inference policy directly on the Raspberry Pi CPU. The later ACT reproducible guide includes this path, *plus* an optional Vast.ai remote-inference setup, which it labels as not independently verified. Do not assert that all ACT runs used Vast.ai without the original run log.
- **SmolVLA:** Trained on Vast.ai. Its 20K checkpoint was physically deployed using Vast.ai remote inference with the original course-style LeRobot 0.5.1 ZMQ server. Training and inference were distinct GPU sessions; inference does not require retraining.
- **π₀.₅:** Expert-only 10K fine-tune performed on Unity HPC A100, then deployed to the SO-101 via a separate Vast.ai GPU using the recovered custom LeRobot 0.7.0 ZMQ compatibility adapter. The real-observation diagnostic is read-only; the physical deployment uses the normal ROS 2 inference path.

## Guides compared with executed work

Three separately provided *SO-101 complete reproducible guides* (ACT, SmolVLA, π₀.₅) dated November 16, 2026 document how to reproduce/restore workflows. They contain a mixture of confirmed events and **new or reconstructed recipes**. They are supporting references, not automatically evidence that every example command was originally executed.

The owner-confirmed historical Vast.ai command is saved in `training/smolvla/train_smolvla_vast.sh`. Separately, `train_smolvla_UNITY_RETRAIN_PROPOSAL.sbatch` in `training/smolvla/unverified_examples/` is **not** the original Vast.ai training script. Its proposed A100/Unity configuration should not be presented as what produced `Emadodin/smolvla_so101_manual_v1`.

The Construct's Units 1-4 formed the educational reference; its baseline walkthrough is not claimed as a novel policy or original ROS 2 architecture here. The owner's independent contributions include demonstration collection, hardware-specific calibration, execution and training work, compatibility troubleshooting, and physical qualitative evaluation.

## Remaining provenance to gather

1. Independent SmolVLA run metadata (Trackio record, Hugging Face checkpoint metadata, original GPU logs if retained); the historical command itself is now owner-confirmed.
2. Exact LeRobot revision, hardware/software environment, seeds and source dataset commit for the original SmolVLA run.
3. Model-specific inference logs and video links, with date, lighting, and whether the trial was successful.
4. Accurate quantitative trials, if generated later; existing qualitative videos do not supply success rates.

No member-only course PDFs, proprietary content or transient GPU credentials should be committed to a public repository.

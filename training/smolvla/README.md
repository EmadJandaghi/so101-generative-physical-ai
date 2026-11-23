# SmolVLA: Vast.ai training and physical inference

**Completed:** the owner trained a SmolVLA checkpoint for 20,000 steps on 111 manual demonstrations on Vast.ai, uploaded the model to Hugging Face, and tested it on the physical SO-101 using remote inference. Both training and later inference used Vast.ai, in distinct sessions.

## Artifacts

- [Training dataset](https://huggingface.co/datasets/Emadodin/so101_pickplace_manual_extra_v1)
- [20K-step SmolVLA checkpoint](https://huggingface.co/Emadodin/smolvla_so101_manual_v1)
- [User-confirmed Vast.ai training command](train_smolvla_vast.sh)

## Training command record

| Field | Value |
| --- | --- |
| Training provider | Vast.ai |
| Dataset | `Emadodin/so101_pickplace_manual_extra_v1`, 111 episodes |
| Initialization | `lerobot/smolvla_base` |
| Training steps | `20000` |
| Batch size | `8` |
| Output directory | `outputs/train/smolvla_so101_manual_v1` |
| Output model | `Emadodin/smolvla_so101_manual_v1` |
| Image mapping | `top` → `camera1`; `wrist` → `camera2` |
| Training logging | `trackio.enable=true`, `trackio.project=smolvla_so101_manual_v1` |

The `train_smolvla_vast.sh` file preserves the command recorded in our November 9, 2026 conversation and **subsequently confirmed by the project owner as correct**. The original Vast.ai instance has been destroyed, so its shell history, exact package revisions, full run logs, and hardware settings cannot independently be checked. This is a **user-confirmed historical command reconstruction**, not a byte-for-byte copy of an original saved `.sh` file.

### Safe reruns

The reconstructed command contains `--policy.push_to_hub=true` and names the existing Hugging Face checkpoint repository. To avoid accidental overwrites, the script includes a *new* guard that prevents execution unless explicitly approved with `CONFIRM_EXISTING_MODEL_REPO_UPLOAD=YES`. For a new run, use a **different** model repository ID and output directory. Depending on your installed LeRobot revision, some flags may require adaptation.

## Inference provenance

The original SmolVLA checkpoint was deployed with the course-style LeRobot 0.5.1 ZMQ remote inference workflow; this is separate from the custom LeRobot 0.7.0 π₀.₅ adapter. See [inference paths](../../deployment/inference_paths.md).

## Other script

[`unverified_examples/train_smolvla_UNITY_RETRAIN_PROPOSAL.sbatch`](unverified_examples/train_smolvla_UNITY_RETRAIN_PROPOSAL.sbatch) is a later **proposed** Unity retraining recipe. It was not used to produce the original Vast.ai checkpoint.

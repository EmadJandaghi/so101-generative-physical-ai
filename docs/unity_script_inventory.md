# Actual Unity scripts: November 2026 archive

Source: uploaded `so101_unity_scripts.tar.gz` from Unity home. These are **original archived shell script files**, copied byte-for-byte; names in this GitHub project were clarified to show their model and Unity origin. They have passed `bash -n` syntax checks, but no Unity jobs were submitted or run as part of preparing this repository.

| Original path relative to `/work/pi_pstegagno_uri_edu/` | Included location | Key configured settings |
| --- | --- | --- |
| `so101_pi05/train_act.sh` | `training/act/train_act_unity.sh` | L40S, 100K steps, 10K save interval, manual 111-episode dataset |
| `so101_pi05/train_pi05.sh` | `training/pi05/train_pi05_unity.sh` | A100, 10K steps, 2K saves, expert-only, BF16, batch 32, image key mapping |
| `so101_diffusion/lerobot/diffusion_test.sh` | `training/diffusion/diffusion_test_unity.sh` | A100, 100 steps, batch 2, Diffusion Policy test |
| `so101_xvla/lerobot/xvla_test.sh` | `training/xvla/xvla_test_unity.sh` | H100, 100 steps, batch 1, X-VLA base test |
| `so101_flux3/convert_test.sh` | `training/flux3/convert_test_unity.sh` | CPU conversion; its `convert_30hz.py` dependency is now included |

## Important details

- All four model-oriented scripts reference the dataset `Emadodin/so101_pickplace_manual_extra_v1`.
- ACT and π₀.₅ specify Unity's Conda environment under `/work/pi_pstegagno_uri_edu/so101_pi05/env`. Diffusion uses its own environment's `lerobot-train`. X-VLA relies on an already activated environment and PATH.
- ACT and π₀.₅ are separate Slurm job scripts even though their source scripts live in the same `so101_pi05` workspace folder.
- Both of those scripts set `--policy.push_to_hub=false`. Uploading the resulting model to Hugging Face is a separate workflow.
- The π₀.₅ script expects an existing local `pi05_base` model and maps overhead and wrist image keys to the expected pretrained names. Without those prerequisites it is not a portable standalone reproduction.
- The test scripts show experiment *intent and settings*, not outcome. Diffusion and X-VLA each request **100 steps**. The FLUX 3 script runs a **conversion**, not training.
- The FLUX 3 conversion test script references the now-included `training/flux3/convert_30hz.py`; the full conversion uses `convert_all.sh` and `convert_all_30hz.py`.
- Slurm `logs/` directories used by Diffusion and X-VLA must be present under the job's working directory before submission, or the paths should be adapted for that environment. Do not assume they already exist.
- The original SmolVLA run shell file is unavailable after the Vast.ai instance was destroyed. A November 9 historical training command is now owner-confirmed and reconstructed at `training/smolvla/train_smolvla_vast.sh`; the separate guide-derived Unity example remains labeled unverified.

## Missing run evidence

1. Job IDs and job logs, especially for the two 100-step tests, to confirm whether they started and succeeded.
2. Dataset revision SHA, upstream LeRobot commit SHA, and environment freeze for each job.
3. Independent SmolVLA run metadata and run evidence for FLUX 3 conversion completion.
4. Training loss histories and physical benchmark trial records.

**Licensing and privacy:** These scripts are experimental configuration artifacts and reference a shared HPC allocation and user-specific absolute paths; review those before publishing. Do not include tokens, credentials, downloaded private weights, or cluster authentication material.

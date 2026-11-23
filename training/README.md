# Training and experiment scripts

The five Unity scripts in this repository were **recovered directly from a Unity file archive supplied by the project owner**. Their original bytes have been preserved. See [`docs/unity_script_inventory.md`](../docs/unity_script_inventory.md) for the corresponding original Unity paths and detailed notes.

| Model / workflow | Actual recovered script | Status supported by the script |
| --- | --- | --- |
| ACT | [`act/train_act_unity.sh`](act/train_act_unity.sh) | Full training **configuration** for 100K steps on L40S |
| π₀.₅ | [`pi05/train_pi05_unity.sh`](pi05/train_pi05_unity.sh) | Full fine-tuning **configuration** for 10K steps on A100 |
| Diffusion | [`diffusion/diffusion_test_unity.sh`](diffusion/diffusion_test_unity.sh) | 100-step test only |
| X-VLA | [`xvla/xvla_test_unity.sh`](xvla/xvla_test_unity.sh) | 100-step test only |
| FLUX 3 Action | [`flux3/convert_test_unity.sh`](flux3/convert_test_unity.sh) | Dataset conversion job, no policy training |

**Provenance caution:** A saved shell file is not proof of successful execution. Compare Slurm job IDs/logs, output checkpoints, model revisions, and code/environment revisions before labeling any historical job as fully verified. The recovered paths are Unity-specific and not meant to work unchanged on another HPC cluster.

The [SmolVLA Vast.ai command](smolvla/train_smolvla_vast.sh) was recovered from our November 9 conversation and is **owner-confirmed as correct** for the 20K run. It is a reconstructed shell file, not a retrieved original script or independently verified GPU log. The later proposed Unity example is clearly isolated under `smolvla/unverified_examples/`.

Don't commit virtual environments, datasets, caches, or model weights to Git. Link to models and data on Hugging Face.

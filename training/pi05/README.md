# π₀.₅ fine-tuning

`train_pi05_unity.sh` is the recovered Unity Slurm script, requesting A100 GPU and 10K steps with expert-only fine-tuning, BF16, gradient checkpointing, and an explicit image-key rename map. It relies on a local pretrained model directory `pi05_base`, and does not push automatically. See [inventory](../../docs/unity_script_inventory.md).

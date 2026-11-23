# ACT training

`train_act_unity.sh` is the recovered Unity Slurm script, requesting L40S GPU and 100K steps. It sets `--policy.push_to_hub=false`, so publishing to Hugging Face would require a separate action. The uploaded file alone does not establish which completed job produced the checkpoint. See [inventory](../../docs/unity_script_inventory.md).

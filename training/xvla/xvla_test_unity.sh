#!/bin/bash
#SBATCH --job-name=xvla_test
#SBATCH --partition=uri-gpu
#SBATCH --gres=gpu:h100:1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=02:00:00
#SBATCH --output=logs/xvla_%j.out


export HF_HUB_CACHE=/work/pi_pstegagno_uri_edu/so101_pi05/hf_cache

lerobot-train \
  --dataset.repo_id=Emadodin/so101_pickplace_manual_extra_v1 \
  --policy.path=lerobot/xvla-base \
  --policy.dtype=bfloat16 \
  --policy.action_mode=auto \
  --policy.device=cuda \
    --policy.push_to_hub=false \
  --steps=100 \
  --batch_size=1 \
  --num_workers=2 \
  --output_dir=/work/pi_pstegagno_uri_edu/so101_xvla/outputs/test

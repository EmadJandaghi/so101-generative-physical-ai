#!/bin/bash
#SBATCH --job-name=diffusion_test
#SBATCH --partition=uri-gpu
#SBATCH --gres=gpu:a100:1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=02:00:00
#SBATCH --output=logs/diffusion_%j.out

cd /work/pi_pstegagno_uri_edu/so101_diffusion/lerobot

/work/pi_pstegagno_uri_edu/so101_diffusion/env/bin/lerobot-train \
  --dataset.repo_id=Emadodin/so101_pickplace_manual_extra_v1 \
  --policy.type=diffusion \
  --policy.device=cuda \
    --policy.push_to_hub=false \
  --steps=100 \
  --batch_size=2 \
  --num_workers=2 \
  --output_dir=/work/pi_pstegagno_uri_edu/so101_diffusion/outputs/test

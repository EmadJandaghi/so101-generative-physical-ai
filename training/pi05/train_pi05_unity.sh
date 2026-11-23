#!/bin/bash
#SBATCH --job-name=so101_pi05
#SBATCH --account=pi_pstegagno_uri_edu
#SBATCH --partition=uri-gpu
#SBATCH --gres=gpu:a100:1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=24:00:00
#SBATCH --output=/work/pi_pstegagno_uri_edu/so101_pi05/train_%j.log

set -e

module load conda/latest
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate /work/pi_pstegagno_uri_edu/so101_pi05/env

export HF_HUB_CACHE=/work/pi_pstegagno_uri_edu/so101_pi05/hf_cache

cd /work/pi_pstegagno_uri_edu/so101_pi05/lerobot

python -m lerobot.scripts.lerobot_train \
  --dataset.repo_id=Emadodin/so101_pickplace_manual_extra_v1 \
  --dataset.root=/work/pi_pstegagno_uri_edu/so101_pi05/dataset \
  --policy.type=pi05 \
  --policy.push_to_hub=false \
  --policy.pretrained_path=/work/pi_pstegagno_uri_edu/so101_pi05/pi05_base \
  --rename_map='{"observation.images.top":"observation.images.base_0_rgb","observation.images.wrist":"observation.images.left_wrist_0_rgb"}' \
  --policy.train_expert_only=true \
  --policy.gradient_checkpointing=true \
  --policy.dtype=bfloat16 \
  --policy.device=cuda \
  --batch_size=32 \
  --num_workers=4 \
  --steps=10000 \
  --save_freq=2000 \
  --output_dir=/work/pi_pstegagno_uri_edu/so101_pi05/outputs \
  --job_name=so101_pi05

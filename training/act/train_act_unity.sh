#!/bin/bash
#SBATCH --job-name=so101_act
#SBATCH --account=pi_pstegagno_uri_edu
#SBATCH --partition=uri-gpu
#SBATCH --gres=gpu:l40s:1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=12:00:00
#SBATCH --output=/work/pi_pstegagno_uri_edu/so101_pi05/act_%j.log

set -e

module load conda/latest
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate /work/pi_pstegagno_uri_edu/so101_pi05/env

export HF_HUB_CACHE=/work/pi_pstegagno_uri_edu/so101_pi05/hf_cache

cd /work/pi_pstegagno_uri_edu/so101_pi05/lerobot

python -m lerobot.scripts.lerobot_train \
  --policy.type=act \
  --dataset.repo_id=Emadodin/so101_pickplace_manual_extra_v1 \
  --dataset.root=/work/pi_pstegagno_uri_edu/so101_pi05/dataset \
  --policy.device=cuda \
  --policy.repo_id=Emadodin/act_so101_manual_100k_unity \
  --policy.push_to_hub=false \
  --output_dir=/work/pi_pstegagno_uri_edu/so101_pi05/act_outputs \
  --job_name=so101_act_100k \
  --steps=100000 \
  --save_freq=10000 \
  --num_workers=4

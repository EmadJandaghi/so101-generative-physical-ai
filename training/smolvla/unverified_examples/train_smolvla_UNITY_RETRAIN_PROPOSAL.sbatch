#!/bin/bash
# RECONSTRUCTED from SmolVLA guide; NOT the verified original training job.
# Especially verify --policy.path and --rename_map against installed LeRobot revision.
#SBATCH --job-name=so101_smolvla_repro
#SBATCH --account=pi_pstegagno_uri_edu
#SBATCH --partition=uri-gpu
#SBATCH --gres=gpu:a100:1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=24:00:00
#SBATCH --output=smolvla_%j.log
set -euo pipefail
module load conda/latest
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate /work/pi_pstegagno_uri_edu/so101_repro/smolvla/env
cd /work/pi_pstegagno_uri_edu/so101_repro/smolvla/lerobot
python -m lerobot.scripts.lerobot_train \
  --policy.path=lerobot/smolvla_base \
  --dataset.repo_id=Emadodin/so101_pickplace_manual_extra_v1 \
  --dataset.revision=main \
  --rename_map='{"observation.images.top":"observation.images.camera1","observation.images.wrist":"observation.images.camera2"}' \
  --policy.repo_id=Emadodin/smolvla_so101_manual_retrain \
  --output_dir=/work/pi_pstegagno_uri_edu/so101_repro/smolvla/outputs \
  --job_name=so101_smolvla_manual_retrain \
  --policy.device=cuda --batch_size=16 --steps=20000 \
  --save_freq=2000 --num_workers=4

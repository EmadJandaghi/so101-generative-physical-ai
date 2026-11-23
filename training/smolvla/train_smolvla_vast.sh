#!/usr/bin/env bash
# SmolVLA training command recovered from the November 9, 2026 conversation.
# The project owner confirmed this command as the correct historical training recipe.
# The original Vast.ai instance was destroyed; full shell history is unavailable.
# WARNING: this command targets an EXISTING Hugging Face model repo with push enabled.
# This safety check was added for publication; it was not part of the recorded command.
set -euo pipefail

if [[ "${CONFIRM_EXISTING_MODEL_REPO_UPLOAD:-}" != "YES" ]]; then
  echo 'Refusing to run: this command pushes to Emadodin/smolvla_so101_manual_v1.' >&2
  echo 'For a new experiment, change --policy.repo_id and --output_dir first.' >&2
  echo 'To deliberately rerun the historical command, export CONFIRM_EXISTING_MODEL_REPO_UPLOAD=YES.' >&2
  exit 1
fi

if ! command -v lerobot-train >/dev/null 2>&1; then
  echo 'lerobot-train not found. Activate the compatible Vast.ai LeRobot environment.' >&2
  exit 1
fi

lerobot-train \
  --policy.path=lerobot/smolvla_base \
  --dataset.repo_id=Emadodin/so101_pickplace_manual_extra_v1 \
  --dataset.revision=main \
  --rename_map='{"observation.images.top":"observation.images.camera1","observation.images.wrist":"observation.images.camera2"}' \
  --policy.repo_id=Emadodin/smolvla_so101_manual_v1 \
  --policy.push_to_hub=true \
  --output_dir=outputs/train/smolvla_so101_manual_v1 \
  --job_name=smolvla_so101_manual_v1 \
  --policy.device=cuda \
  --batch_size=8 \
  --steps=20000 \
  --trackio.enable=true \
  --trackio.project=smolvla_so101_manual_v1

"""Minimal course wire/data compatibility layer independent of lerobot.async_inference.

API based on the instructor's LeRobot 0.5.1 helper definitions.
The original server and LeRobot installation are not modified.
"""
from __future__ import annotations

import logging
from dataclasses import dataclass, field
from typing import Any

import numpy as np
import torch

SUPPORTED_POLICIES = {"pi05"}
Observation = dict[str, torch.Tensor]


def get_logger(name: str, log_to_file: bool = False) -> logging.Logger:
    logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(name)s: %(message)s")
    return logging.getLogger(name)


def is_image_key(key: str) -> bool:
    return key.startswith("observation.images")


def make_lerobot_observation(robot_obs: dict[str, Any], features: dict[str, dict]) -> dict[str, np.ndarray]:
    """Match the original build_dataset_frame(..., prefix='observation') behavior.

    State features are ordered by feature['names']; images use their raw camera names.
    """
    frame: dict[str, np.ndarray] = {}
    for key, feature in features.items():
        if not key.startswith("observation"):
            continue
        dtype = feature.get("dtype")
        shape = feature.get("shape", [])
        if dtype == "float32" and len(shape) == 1:
            frame[key] = np.asarray([robot_obs[name] for name in feature["names"]], dtype=np.float32)
        elif dtype in ("image", "video"):
            raw_key = key.removeprefix("observation.images.")
            frame[key] = robot_obs[raw_key]
    return frame


def extract_state_from_raw_observation(obs: dict[str, Any]) -> torch.Tensor:
    state = torch.as_tensor(obs["observation.state"])
    return state.unsqueeze(0) if state.ndim == 1 else state


@dataclass
class TimedData:
    timestamp: float
    timestep: int

    def get_timestamp(self):
        return self.timestamp

    def get_timestep(self):
        return self.timestep


@dataclass
class TimedAction(TimedData):
    action: torch.Tensor

    def get_action(self):
        return self.action


@dataclass
class TimedObservation(TimedData):
    observation: dict[str, Any]
    must_go: bool = False

    def get_observation(self):
        return self.observation


@dataclass
class FPSTracker:
    target_fps: float
    first_timestamp: float | None = None
    total_obs_count: int = 0

    def calculate_fps_metrics(self, current_timestamp: float) -> dict[str, float]:
        self.total_obs_count += 1
        if self.first_timestamp is None:
            self.first_timestamp = current_timestamp
        duration = current_timestamp - self.first_timestamp
        average = (self.total_obs_count - 1) / duration if duration > 1e-6 else 0.0
        return {"avg_fps": average, "target_fps": self.target_fps}

    def reset(self):
        self.first_timestamp = None
        self.total_obs_count = 0


@dataclass
class RemotePolicyConfig:
    policy_type: str
    pretrained_name_or_path: str
    lerobot_features: dict[str, dict]
    actions_per_chunk: int
    device: str = "cpu"
    rename_map: dict[str, str] = field(default_factory=dict)

#!/usr/bin/env python3
"""One real-observation SO-101 Pi -> Vast.ai ZMQ inference test.

Read-only ROS subscriptions: never publishes joint commands. Run on Raspberry Pi
from the course project with its ROS setup sourced and Pixi lerobot environment.
"""
import os
import struct
import time

import cv2
import msgpack
import numpy as np
import rclpy
import zmq
from rclpy.node import Node
from sensor_msgs.msg import Image, JointState

SERVER = os.environ.get("SO101_ZMQ_SERVER", "tcp://127.0.0.1:8090")
MODEL = "Emadodin/pi05_so101_manual_10k_unity"
TASK = "put the green cube in the cup"
JOINT_NAMES = [
    "shoulder_pan", "shoulder_lift", "elbow_flex", "wrist_flex",
    "wrist_roll", "gripper",
]


def to_rgb(msg):
    """Decode common uncompressed ROS Image encodings into HWC RGB uint8."""
    enc = msg.encoding.lower()
    if enc in ("rgb8", "bgr8"):
        channels = 3
    elif enc in ("rgba8", "bgra8"):
        channels = 4
    elif enc == "mono8":
        channels = 1
    else:
        raise ValueError(f"Unsupported image encoding: {msg.encoding}")
    row = np.frombuffer(msg.data, dtype=np.uint8).reshape(msg.height, msg.step)
    image = row[:, :msg.width * channels].reshape(msg.height, msg.width, channels)
    if enc == "bgr8":
        image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    elif enc == "bgra8":
        image = cv2.cvtColor(image, cv2.COLOR_BGRA2RGB)
    elif enc == "rgba8":
        image = cv2.cvtColor(image, cv2.COLOR_RGBA2RGB)
    elif enc == "mono8":
        image = cv2.cvtColor(image, cv2.COLOR_GRAY2RGB)
    return np.ascontiguousarray(image)


class Capture(Node):
    def __init__(self):
        super().__init__("so101_prediction_only_capture")
        self.top = None
        self.wrist = None
        self.joints = None
        self.create_subscription(Image, "/static_camera/image_raw", self.on_top, 10)
        self.create_subscription(Image, "/follower/image_raw", self.on_wrist, 10)
        self.create_subscription(JointState, "/follower/joint_states", self.on_joints, 10)

    def on_top(self, msg):
        if self.top is None:
            self.top = to_rgb(msg)

    def on_wrist(self, msg):
        if self.wrist is None:
            self.wrist = to_rgb(msg)

    def on_joints(self, msg):
        if self.joints is None:
            positions = dict(zip(msg.name, msg.position))
            if all(name in positions for name in JOINT_NAMES):
                self.joints = {f"{name}.pos": float(positions[name]) for name in JOINT_NAMES}


def exchange(sock, request):
    sock.send(msgpack.packb(request, use_bin_type=True))
    response = msgpack.unpackb(sock.recv(), raw=False)
    if response.get("status") != "ok":
        raise RuntimeError(f"Server rejected request: {response}")
    return response


def main():
    rclpy.init()
    node = Capture()
    try:
        deadline = time.monotonic() + 15
        while not (node.top is not None and node.wrist is not None and node.joints is not None):
            if time.monotonic() >= deadline:
                raise TimeoutError("Did not receive both cameras and all six joints in 15 seconds")
            rclpy.spin_once(node, timeout_sec=0.25)
        top, wrist, joints = node.top, node.wrist, node.joints
    finally:
        node.destroy_node()
        rclpy.shutdown()

    print("Captured live state:", joints, flush=True)
    print("Camera shapes:", top.shape, wrist.shape, flush=True)
    if top.shape != (480, 640, 3) or wrist.shape != (480, 640, 3):
        raise ValueError("Unexpected camera dimensions. No inference request sent.")

    features = {
        "observation.state": {
            "dtype": "float32", "shape": [6],
            "names": [f"{name}.pos" for name in JOINT_NAMES],
        },
        "observation.images.top": {
            "dtype": "image", "shape": [480, 640, 3],
            "names": ["height", "width", "channels"],
        },
        "observation.images.wrist": {
            "dtype": "image", "shape": [480, 640, 3],
            "names": ["height", "width", "channels"],
        },
    }
    config = {
        "policy_type": "pi05",
        "pretrained_name_or_path": MODEL,
        "lerobot_features": features,
        "actions_per_chunk": 1,
        "device": "cuda",
        "rename_map": {},
    }
    ctx = zmq.Context()
    sock = ctx.socket(zmq.REQ)
    sock.setsockopt(zmq.RCVTIMEO, 600000)  # model loading can be slow
    sock.setsockopt(zmq.LINGER, 0)
    sock.connect(SERVER)
    try:
        print("Configuring model with real SO-101 features...", flush=True)
        exchange(sock, {"type": "policy_config", "data": msgpack.packb(config, use_bin_type=True)})
        print("Model configured. Requesting one prediction...", flush=True)
        arrays = {"top": top, "wrist": wrist}
        header = {
            "timestamp": time.time(),
            "timestep": 1,
            "must_go": True,
            "scalars": {**joints, "task": TASK},
            "arrays": {key: {"shape": list(arr.shape), "dtype": str(arr.dtype)}
                       for key, arr in arrays.items()},
        }
        packed = msgpack.packb(header, use_bin_type=True)
        obs = struct.pack("<I", len(packed)) + packed + b"".join(
            arr.tobytes() for arr in arrays.values()
        )
        response = exchange(sock, {"type": "infer", "data": obs})
        payload = response["actions"]
        header_len = struct.unpack("<I", payload[:4])[0]
        action_header = msgpack.unpackb(payload[4:4 + header_len], raw=False)
        action_spec = action_header["actions"][0]
        array = np.frombuffer(payload[4 + header_len:], dtype=np.dtype(action_spec["dtype"]))
        array = array[:int(np.prod(action_spec["shape"]))].reshape(action_spec["shape"])
        print("SUCCESS: predicted action shape:", array.shape)
        print("Predicted values (not executed):", array.tolist())
        if not np.isfinite(array).all():
            print("WARNING: prediction contains non-finite values")
        print("No robot commands were published.")
    finally:
        sock.close()
        ctx.term()


if __name__ == "__main__":
    main()

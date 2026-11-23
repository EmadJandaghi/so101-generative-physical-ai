# π₀.₅ LeRobot 0.7.0 ZMQ compatibility adapter

## Purpose

This is the **actual source archive provided for the SO-101 project**. It implements a compatibility layer for a π₀.₅ checkpoint trained with LeRobot 0.7.0 while retaining the remote ZMQ protocol used by the course's ROS 2 client. It is **not** the complete ROS 2 robot runtime.

## Evidence and testing status

The original adapter README was written **before** testing and is preserved as [`README_initial_adapter_notes.md`](README_initial_adapter_notes.md). A separate recovery guide written after the experiment records that, on **November 15, 2026**, the adapter loaded the checkpoint on a Vast.ai RTX 5090, returned six-dimensional action predictions for synthetic and real camera/joint observations, and was used in a physical SO-101 deployment that produced robot movement.

This repository export has **not** rerun that experiment or verified the adapter against a fresh GPU template. Treat historical success and present-day reproducibility as different claims. Pin the LeRobot version, checkpoint revision, and dependencies before re-running.

## Files

- `policy_server/compat.py`: substitute for selected older `lerobot.async_inference` helpers
- `policy_server/inference_engine.py`: adapted inference engine (retains original author license header)
- `policy_server/zmq_server.py`: adapted server and wire protocol (retains original author license header)
- `policy_server/__init__.py`: module marker

## Provenance and licensing

The server and inference engine are **adaptations of Dmitri Manajev's Apache-2.0-licensed SO-101 ROS code**, not entirely original software. Preserve the source copyright banners and the Apache 2.0 license in this directory when sharing or modifying these files. The compatibility additions were made for the user's LeRobot 0.7.0 deployment. Refer to the [upstream repository](https://github.com/legalaspro/so101-ros-physical-ai) for the original framework. The exact upstream commit for the adapted snapshot remains to be identified.

## Operating and security cautions

- By default, the server CLI binds to `0.0.0.0` (all network interfaces). The message protocol does **not** implement an authentication or encryption layer. **Never expose it on an untrusted public network**. Use an access-controlled private tunnel or other properly secured connection.
- The server can deliver action commands to a real robot. Verify model output shapes, joint units, command limits, supervision and an emergency stop before motion testing.
- Start with an import test and an isolated prediction-only client. The test client under `../raspberry_pi/` subscribes to camera and joint topics but does not publish commands.
- Do not run the older `setup_so101_pi05_vast.sh` LeRobot 0.5.1 compatibility experiment as a substitute for the tested 0.7.0 deployment.

## Minimal non-robot validation

On a machine with the correct dependencies installed:

```bash
cd deployment/pi05_zmq_adapter
python -c 'from policy_server.zmq_server import ZmqPolicyServer; print("Adapter import OK")'
```

This only tests imports. It does **not** load the checkpoint or execute robot actions.

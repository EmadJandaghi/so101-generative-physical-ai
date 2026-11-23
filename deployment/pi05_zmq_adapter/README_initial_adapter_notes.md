# SO-101 π₀.₅ LeRobot 0.7.0 ZMQ adapter

This is an isolated **candidate adapter**, not a validated working deployment.
It is adapted from the three source files shared in this conversation.
Original instructor files and trained checkpoint remain unchanged.

## Current scope
- Retains instructor ZMQ wire protocol and inference engine code.
- Replaces missing LeRobot 0.5.1 async_inference helper imports with compat.py.
- Reimplements joint and image data mapping from the original build_dataset_frame.
- Uses LeRobot 0.7.0's policy factory and pre/postprocessing. These APIs are **not yet verified** against your Vast.ai environment.

## Safe first test on Vast.ai
1. Upload the ZIP to `/workspace` using VS Code Remote SSH Explorer.
2. `cd /workspace && unzip -o so101_pi05_zmq_adapter.zip`
3. `cd /workspace/so101_pi05_zmq_adapter && /venv/main/bin/python -c "from policy_server.zmq_server import ZmqPolicyServer; print('Adapter import OK')"`

This test does not open port 8090, load the model, download weights, or move the robot.
If it fails, provide the **first exception**. Do not install packages without checking whether the required interface actually exists.

## Not yet verified
- LeRobot 0.7.0 factory API (`get_policy_class`, `make_pre_post_processors`)
- Exact checkpoint preprocessor/rename mappings and tokenizer
- Actual policy weights, GPU inference, and response-action compatibility
- Physical robot safety checks and action validation

## After import succeeds
Test local model load and a synthetic observation first. The instructor server on 8090 must be stopped before any alternate server binds that port.

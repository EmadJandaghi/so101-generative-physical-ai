# Raspberry Pi inference diagnostics

`so101_prediction_only.py` was recovered from the original Pi installation. It is a **read-only diagnostic**: subscribes to ROS camera and joint-state topics, packages real observations over MessagePack/ZMQ, requests a single π₀.₅ prediction, and prints its action values without publishing robot joint commands.

For public safety/privacy, the original hardcoded historical Vast.ai address was replaced by an environment variable; otherwise the supplied script was preserved.

```bash
export SO101_ZMQ_SERVER='tcp://YOUR_ACTIVE_SERVER:PORT'
python so101_prediction_only.py
```

This requires compatible ROS 2 Python dependencies, an available remote ZMQ server with the exact protocol used by the custom adapter, and working camera/joint publishers. **Not an independent deployable inference server.** The historical adapter source is still missing.

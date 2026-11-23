# Deployment

ACT, SmolVLA, and π₀.₅ were tested on the physical SO-101. ROS 2 and a Raspberry Pi were used with local or remote inference depending on the model.

For π₀.₅, a custom LeRobot 0.7.0 ZMQ compatibility adapter was tested because an older inference-server stack expected removed `async_inference` helpers. Original tested source must be recovered and reviewed before publication.

Do not commit ephemeral remote-GPU IP addresses or secrets. Physical testing requires human supervision and verified motion limits.

# LeRobot dataset conversion YAML

`so101_50hz.yaml` is the actual uploaded conversion configuration. Its `fps: 50` and reference topic `/follower/forward_controller/commands` mean action commands define the output frame timeline. The two video observation sources are compressed overhead and wrist ROS image topics at nominal camera capture rate 30 FPS; the converter uses its configured freshness policies to align features to command frames. Do not claim that cameras captured 50 unique images each second.

The YAML has a task field `Pick and Place`. If the dataset's per-episode natural-language task was recorded separately, confirm it from the dataset itself instead of assuming this YAML field was the final label.

from copy import deepcopy
from lerobot.datasets.lerobot_dataset import LeRobotDataset

src = LeRobotDataset("Emadodin/so101_pickplace_manual_extra_v1")

features = {}
for key in ["observation.images.wrist", "observation.images.top",
            "observation.state", "action"]:
    new_key = key.replace("images.top", "images.scene")
    features[new_key] = deepcopy(src.features[key])

    if features[new_key]["dtype"] == "video":
        features[new_key]["info"]["video.fps"] = 30

dst = LeRobotDataset.create(
    repo_id="local/so101_flux3_30hz_test",
    root="/work/pi_pstegagno_uri_edu/so101_flux3/dataset_30hz_full",
    fps=30,
    features=features,
    robot_type="so101",
    use_videos=True,
)


for ep in src.meta.episodes:
    start = ep["dataset_from_index"]
    length = ep["length"]

    for j in range(round(length * 30 / 50)):
        i = min(round(j * 50 / 30), length - 1)
        sample = src[start + i]

        dst.add_frame({
            "observation.images.wrist": sample["observation.images.wrist"].permute(1, 2, 0),
            "observation.images.scene": sample["observation.images.top"].permute(1, 2, 0),
            "observation.state": sample["observation.state"],
            "action": sample["action"],
            "task": ep["tasks"][0],
        })

    dst.save_episode()
    print("Saved episode:", ep["episode_index"], flush=True)

dst.finalize()

print("Original frames:", length)
print("Converted frames:", dst.num_frames)
print("Conversion completed")

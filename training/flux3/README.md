# FLUX 3 Action dataset conversion: recovered Unity code

These three files were supplied from the project's Unity workspace. They are actual code artifacts, not synthetic examples.

| File | Role |
| --- | --- |
| `convert_30hz.py` | Converts **only the first episode** of the original 50 Hz dataset to a 30 Hz test dataset (`dataset_30hz_test_v3`). |
| `convert_all_30hz.py` | Iterates through the **entire source dataset** and writes 30 Hz episodes (`dataset_30hz_full`). |
| `convert_all.sh` | Slurm CPU submission script that runs `convert_all_30hz.py` using the existing FLUX 3 Python environment. |
| `convert_test_unity.sh` | Previously recovered short-run conversion job referencing `convert_30hz.py`. |

## What the converter does

- Reads Hugging Face dataset `Emadodin/so101_pickplace_manual_extra_v1`.
- Renames `observation.images.top` to `observation.images.scene` for the target schema, leaving `observation.images.wrist` unchanged.
- Creates a new dataset with `fps=30`, `robot_type=so101` and video encoding enabled.
- Selects source frames using the `round(j * 50 / 30)` index mapping, with output length approximately 30/50 of the original. **No interpolated observations or actions are generated.**
- Copies `observation.state`, `action`, and episode task text to each selected target frame.

## Known limits and checks before publication

1. The scripts were reviewed for syntax only; the conversion **completion** is not proven by these files. Review the original job logs and output dataset before saying all 111 episodes converted.
2. The full converter's final `print("Original frames:", length)` reports **only the final episode's length**, not the original dataset total. The destination frame count uses `dst.num_frames`.
3. The scripts hard-code institution-specific workspace directories and assume existing LeRobot software and data access. Paths and package versions must be parameterized or documented for portability.
4. Nearest-index frame selection changes the data frequency without action interpolation; confirm that this is compatible with the actual FLUX 3 training pipeline and any action horizon/temporal semantics.
5. The converter source is not evidence of completed FLUX 3 **model training** or real-robot inference.

See `docs/unity_script_inventory.md` for experiment provenance.

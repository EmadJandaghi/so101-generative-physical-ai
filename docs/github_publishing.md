# Publishing this project to GitHub

The supplied ZIP is a **source tree**, not an existing remote GitHub repository. The working directory intentionally contains no `.git/` folder.

## Before making the repository public

1. Review the repo's [license decision](../LICENSE-DECISION.md) and choose a license for your own contributions. Keep all upstream copyright and Apache-2.0 notices.
2. Review recovered scripts for private paths, usernames, remote endpoints and SSH details. No credentials should be included. The saved HPC paths are examples of the original environment.
3. Confirm no raw large datasets, models or course PDFs are included. Keep model/dataset artifacts on Hugging Face.
4. Remember the π₀.₅ ZMQ server has no built-in network authentication: only operate it over an access-controlled network.
5. Add six representative **user-owned** normal-light / low-light videos as links in [`evaluation/videos.md`](../evaluation/videos.md); do not needlessly commit large MP4 files.
6. Make sure no benchmark success rates are claimed until trial-by-trial measurements exist.

## Create a new repository on GitHub

Suggested name: **`so101-generative-physical-ai`**.

Create an **empty** repository on GitHub, without choosing GitHub's initial README, `.gitignore`, or LICENSE option (these would create a separate commit). Extract the ZIP locally, open a terminal in the folder, then run:

```bash
git init
git branch -M main
git add .
git status --short
git commit -m "Initial release: SO-101 generative Physical AI experiments"
git remote add origin https://github.com/YOUR_GITHUB_USERNAME/so101-generative-physical-ai.git
git push -u origin main
```

Replace `YOUR_GITHUB_USERNAME` with your real GitHub account. GitHub will prompt for an appropriate login/credential method if needed. If you use GitHub Desktop, you can instead add the extracted folder as a local repository and publish it through the GUI.

**Do not run** these commands in your original Pi workspace or Unity LeRobot checkout. Use the downloaded independent repository folder.

## What is included and what is not

- Included: original Pi configuration snapshots, recorded Slurm scripts, user-confirmed historical SmolVLA command, π₀.₅ adapter and documented licensing, FLUX 3 conversion scripts, evaluation templates.
- External dependencies: upstream SO-101 ROS stack and Hugging Face LeRobot. Install the appropriate revisions instead of copying their full source trees.
- Not yet included: your real videos, training logs, a fully pinned environment lockfile, and new-policy full-training results.

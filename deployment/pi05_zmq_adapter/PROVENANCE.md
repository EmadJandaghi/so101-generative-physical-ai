# Source provenance for the adapter

- Source input: user-supplied `so101_pi05_zmq_adapter(1).zip` uploaded November 20, 2026.
- Duplicate: `SO101_GPU_Recovery_Kit(1).zip` contains the same adapter bytes, confirmed by SHA-256 comparison of the archives.
- `policy_server/inference_engine.py` and `policy_server/zmq_server.py` contain `Copyright 2026 Dmitri Manajev` and Apache-2.0 headers.
- `policy_server/compat.py` is described in its module docstring as a compatibility layer based on the instructor's LeRobot 0.5.1 helper definitions.
- Original course server remains external and is not bundled wholesale.
- Exactly what lines were introduced or changed relative to the original server should be confirmed by a versioned diff against the appropriate upstream revision before describing any individual code lines as new.
- The recovery guide reports successful physical usage November 15, 2026. The adapter README from before that test stated that deployment had not yet been validated; it is archived as historical context.

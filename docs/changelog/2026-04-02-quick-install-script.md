# 2026-04-02 Quick Install Script

## Summary
- Added `scripts/quick-install.sh` as an optional convenience installer for macOS and Debian/Ubuntu.
- Kept the explicit copy/paste quick start as the primary README path and documented the script as convenience-only.
- Added `DRY_RUN=1` and `CLONE_DIR=...` support so the script is reviewable and does not force a single local path during testing.

## Why
- A single curl-friendly installer can be useful for repeat setup or for users who prefer one command.
- The repo still benefits from keeping the primary quick start explicit and auditable instead of replacing it with a repo-specific curl pipe.

## Verification
- Ran `bash -n scripts/quick-install.sh`.
- Ran dry-run simulations for both the macOS and Debian/Ubuntu branches and confirmed the script printed the expected prerequisite install, clone, and `make install` steps without performing them.

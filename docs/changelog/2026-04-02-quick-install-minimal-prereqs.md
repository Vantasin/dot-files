# 2026-04-02 Quick Install Minimal Prereqs

## Summary
- Simplified `scripts/quick-install.sh` so it only bootstraps the minimum needed to fetch the repo and run `make install` instead of also installing `stow` and `rsync` itself.
- Left the repo-managed toolchain bootstrap to `make install`, which already knows how to recover missing prerequisites after the repo is cloned.
- Updated the README, manual install guide, and scripts docs to describe the slimmer responsibility clearly.

## Why
- The script still needs `git` before it can clone the repo, Debian/Ubuntu still needs `make` available to invoke `make install`, and macOS still needs Homebrew available for later package bootstrap.
- `stow` and `rsync` were duplicated responsibility because `make install` already bootstraps them when the repo is present.

## Verification
- Ran `bash -n scripts/quick-install.sh`.
- Ran dry-run simulations for both the macOS and Debian/Ubuntu branches and confirmed the script now prints only the minimum bootstrap steps before clone and `make install`.

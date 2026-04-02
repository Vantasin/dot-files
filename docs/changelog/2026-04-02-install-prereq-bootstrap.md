# 2026-04-02 Install Prerequisite Bootstrap

## Summary
- Made `make install` recover when `git`, `stow`, or `rsync` are missing by running the OS bootstrap install before the normal Stow dry-run flow.
- Added `rsync` to the Debian/Ubuntu bootstrap core package list so the apt bootstrap can satisfy the same install prerequisites as the macOS bootstrap.
- Split the Makefile checks so `make stow`, `make unstow`, `make restow`, `make status`, and `make force-install` only require `stow` plus the package list.
- Updated the install and bootstrap docs to describe the conditional early-bootstrap behavior accurately.

## Why
- `make uninstall` removes the repo-managed Homebrew or apt packages, including `stow`, so a later `make install` could strand itself before it had any chance to restore the missing toolchain.
- The Debian bootstrap path also needs to install `rsync`, otherwise `make install` can bootstrap and still fail the next prerequisite check on Linux.
- Stow-only targets should not fail just because `git` or `rsync` are absent when they do not use those tools.
- The docs needed to stop claiming that install always reaches conflict detection before any bootstrap work.

## Verification
- Ran a temporary-`HOME`, temporary-`PATH` simulated `make install` where `git`, `stow`, and `rsync` started absent; verified the early bootstrap path ran first and the install completed.
- Ran a temporary-`PATH` simulated `make status` with only `stow` available and verified it no longer depended on `git` or `rsync`.
- Confirmed the Debian bootstrap package list now includes `rsync`.

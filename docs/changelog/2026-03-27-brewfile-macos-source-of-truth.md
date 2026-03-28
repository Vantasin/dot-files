# 2026-03-27 Brewfile macOS Source Of Truth

## Summary
- Added a repo-root `Brewfile` for the macOS package set.
- Refactored `bootstrap/macos.sh` to install from `Brewfile` via `brew bundle`.
- Updated the macOS quick start and bootstrap docs to treat `Brewfile` as the authoritative macOS package manifest.

## Why
- The macOS package list should live in one declarative source of truth instead of being duplicated in shell scripts and docs.
- This matches the intended Homebrew Bundle workflow for restoring packages and apps on macOS.

## Verification
- Ran `bash -n` on the bootstrap scripts.
- Ran `brew bundle check --file=Brewfile`.
- Verified `make status` still passes after the bootstrap-doc changes.

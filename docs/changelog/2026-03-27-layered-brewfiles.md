# 2026-03-27 Layered Brewfiles

## Summary
- Kept `Brewfile` as the repo-focused baseline macOS manifest.
- Added `Brewfile.complete` as a full-machine Homebrew Bundle snapshot generated from the current Mac.
- Updated bootstrap and agent docs to distinguish the default bootstrap manifest from the broader restore snapshot.

## Why
- The repo's default macOS bootstrap should stay focused on stable tooling that supports the dotfiles workflow.
- A broader machine restore snapshot is still useful, but it should be applied intentionally rather than silently becoming the default package set.

## Verification
- Generated `Brewfile.complete` with `brew bundle dump --file=Brewfile.complete --force`.
- Ran `brew bundle check --file=Brewfile`.
- Ran `brew bundle check --no-upgrade --file=Brewfile.complete`.
- Confirmed docs describe `Brewfile` as the default manifest and `Brewfile.complete` as the optional complete snapshot.

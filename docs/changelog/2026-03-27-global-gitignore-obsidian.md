# 2026-03-27 Global Gitignore For Obsidian

## Summary
- Added `.obsidian/` to the repo-managed global Git ignore file at `git/dot-config/git/ignore`.
- Clarified in the Git docs that `core.excludesFile` already points at the stowed global ignore file.

## Why
- The repo already manages global Git config, so editor workspace metadata should be handled there instead of through a separate ad hoc local setup.
- Obsidian workspace files are machine-local editor state, not content that should be tracked across repos by default.

## Verification
- Confirmed `git/dot-gitconfig` points `core.excludesFile` at `~/.config/git/ignore`.
- Confirmed `.obsidian/` is listed in `git/dot-config/git/ignore`.

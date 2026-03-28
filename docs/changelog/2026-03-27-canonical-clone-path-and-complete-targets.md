# 2026-03-27 Canonical Clone Path And Complete Targets

## Summary
- Standardized the documented clone path as `~/Git/dot-files`.
- Added `make macos-complete` and `make install-complete` as cleaner wrappers for `Brewfile.complete`.
- Ignored `.obsidian/` so local Obsidian workspace metadata stays out of git.

## Why
- The quick start should use one canonical path instead of mixing `~/Git/dot-files`, `~/git/dot-files`, and `~/dot-files`.
- The complete Homebrew snapshot is easier to use and remember through explicit make targets than through a manual `BREWFILE=...` override.
- Obsidian workspace state is local editor metadata, not repo content.

## Verification
- Ran `make status`.
- Ran `make help` and confirmed the new targets are listed.
- Confirmed `.obsidian/` is ignored by git.

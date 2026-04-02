# 2026-04-02 Restore Shortcuts

## Summary
- Added `make list-backups` to show the timestamped backup directories under `~/.dotfiles_backup`.
- Added `make restore-latest` as a non-interactive shortcut for restoring from the most recent backup.
- Updated the restore docs to keep `make restore BACKUP=...` as the explicit choose-a-specific-backup path.

## Why
- The restore flow already exposed the available backups when `BACKUP` was missing, but it was awkward for quick recovery and repeated use.
- A deterministic latest-backup shortcut improves ergonomics without turning the Makefile into an interactive prompt.
- Keeping the primary restore path explicit preserves scriptability and the repo's non-interactive workflow bias.

## Verification
- Ran temporary-`HOME` tests for `make list-backups`, `make restore`, and `make restore-latest` with a fake `rsync`; confirmed `list-backups` sorts the timestamped directories and `restore-latest` targets the newest one.

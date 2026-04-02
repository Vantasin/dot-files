# 2026-04-02 Restore Prompt

## Summary
- Added `make restore-prompt` as an opt-in interactive restore target.
- The new target lists backups with numbers, validates the user's selection, runs `make restore BACKUP=...` for the chosen entry, and exits cleanly on Enter-to-cancel.
- Updated the restore docs to keep `make restore` as the explicit/scriptable path and `restore-prompt` as a terminal convenience layer.

## Why
- `make list-backups` plus `make restore BACKUP=...` is clear and scriptable, but it is slower than necessary for manual terminal use.
- An explicit interactive target improves the manual recovery UX without changing the semantics of the existing restore commands.

## Verification
- Ran temporary-`HOME` tests where `restore-prompt` rejected an invalid number, accepted a later valid selection, and restored the selected backup.
- Confirmed `restore-prompt` fails cleanly when no backups exist and exits cleanly when canceled.

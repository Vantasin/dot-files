# 2026-08-30 Zsh History Synchronization

## Summary
- Removed the manual `fc -AI` prompt, directory-change, and exit hooks.
- Kept native `SHARE_HISTORY` as the single owner of incremental cross-shell history.
- Returned to Zsh's default history locking and removed the redundant `INC_APPEND_HISTORY` option.

## Why
- Concurrent manual history saves could race while replacing `history.new`, producing intermittent rename failures.
- `SHARE_HISTORY` already persists typed commands promptly and imports commands from other shells.

## Verification
- Ran `make status` and Zsh syntax checks successfully.
- Started an isolated interactive shell and confirmed the intended options and absence of the removed function and hooks.
- Exercised concurrent native history writes against a disposable history file without rename failures or leftover temporary files.
- Confirmed two simultaneous shells imported each other's commands and persisted them after exit.

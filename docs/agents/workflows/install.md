# Install Workflow

## Normal Install
1. Run `make status` first to confirm whether Stow sees conflicts.
2. If `make status` is clean, run `make install`.
3. `make install` performs: `check` -> `status` -> `backup` -> OS bootstrap install -> `antidote` -> `stow`.
4. If the dry-run reports conflicts, `make install` now stops immediately before backup or bootstrap work.

## Force Install
1. Use `make force-install` when the user wants existing target files renamed aside automatically.
2. `make force-install` dry-runs Stow, parses conflict paths, renames each conflicting target to `<path>.bak-<timestamp>`, then reruns `stow`.
3. Moves are logged to `~/.dotfiles_install.log` unless `LOG_FILE=` is passed.

## Backup And Restore
- `make backup` creates `~/.dotfiles_backup/<timestamp>` and skips symlinks that already point into this repo.
- `make restore BACKUP=...` restores only missing files and does not overwrite current ones.
- `scripts/rollback-force-install.sh` replays the logged `force-install` moves to restore backups after a force install.

## Verification
- Run `make status` after the change.
- Open a new shell if zsh or shell entry files changed.
- Note any user-visible changes in aliases, paths, prompts, or startup behavior.

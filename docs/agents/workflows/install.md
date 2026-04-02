# Install Workflow

## Normal Install
1. If `stow` is already installed, run `make status` first to confirm whether Stow sees conflicts.
2. If `make status` is clean, run `make install`.
3. `make install` validates the package list, bootstraps missing `git`/`stow`/`rsync` if needed, then performs: `check` -> `status` -> `backup` -> OS bootstrap install if it did not already run -> `antidote` -> `stow`.
4. If the dry-run reports conflicts, `make install` stops before backup and refuses to overwrite anything.

## Force Install
1. Use `make force-install` when the user wants existing target files renamed aside automatically.
2. `make force-install` dry-runs Stow, parses conflict paths, renames each conflicting target to `<path>.bak-<timestamp>`, then reruns `stow`.
3. Moves are logged to `~/.dotfiles_install.log` unless `LOG_FILE=` is passed.

## Backup And Restore
- `make backup` creates `~/.dotfiles_backup/<timestamp>` and skips symlinks that already point into this repo.
- `make list-backups` shows the available timestamped backup directories.
- `make restore BACKUP=...` restores only missing files and does not overwrite current ones; it uses `rsync` when present and otherwise falls back to `cp`.
- `make restore-latest` resolves the newest timestamped backup and then runs `make restore`.
- `make restore-prompt` offers an interactive numbered picker, runs `make restore` for the selected backup, and exits cleanly when canceled.
- `scripts/rollback-force-install.sh` replays the logged `force-install` moves to restore backups after a force install.

## Verification
- Run `make status` after the change.
- Open a new shell if zsh or shell entry files changed.
- Note any user-visible changes in aliases, paths, prompts, or startup behavior.

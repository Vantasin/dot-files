# Makefile Notes

## Purpose
- Orchestrates installs, backups, restores, and stow/unstow using `packages.stow` as the single source of truth.
- No custom linker logic; all linking is via GNU Stow with `--dotfiles --target="$HOME"`.

## Key Variables
- `PACKAGES_FILE=packages.stow` — authoritative list of packages to stow/unstow.
- `STOW_FLAGS=--dotfiles --ignore='(\.DS_Store|README\.md)$$' --target="$(HOME)"` — applied to all stow commands so Finder metadata and package README files are never stowed.
- `BACKUP_ROOT=$HOME/.dotfiles_backup` — where backups are stored.
- `BREWFILE` — optional override for `make macos`; defaults to the repo root `Brewfile`.

## Core Targets (order of operations)
- `make install` — validate the package list, bootstrap missing `git`/`stow`/`rsync` if needed, then run `check` → `status` (dry-run) → `backup` → `bootstrap (macos|debian) install` if it did not already run → `antidote` → `stow`. If `status` reports conflicts, install stops before backup and refuses to overwrite anything.
- `make uninstall` — `unstow` → `bootstrap (macos|debian) uninstall` (does not touch backups or `~/.antidote`).
- `make stow|unstow|restow|status` — link management for all packages in `packages.stow`; these targets require `stow`, but do not require `git` or `rsync`.
- `make force-install` — dry-run stow, move conflicting paths to `<name>.bak-<timestamp>`, then re-run stow (logs to `LOG_FILE`).
- `make backup` — rsyncs existing files in scope to `~/.dotfiles_backup/<timestamp>`, skipping symlinks into the repo.
- `make list-backups` — lists the available backup directories under `~/.dotfiles_backup`.
- `make restore BACKUP=…` — restores missing files back without overwriting anything that exists, using `rsync` when available and a `cp` fallback otherwise.
- `make restore-latest` — resolves the most recent backup directory under `~/.dotfiles_backup` and then runs `make restore BACKUP=…`.
- `make restore-prompt` — shows a numbered interactive picker for the available backups, runs `make restore BACKUP=…` for the selected entry, and exits cleanly when canceled.
- `make antidote` — installs Antidote to `~/.antidote` if missing.
- `make macos|debian ACTION=install|uninstall` — run OS package installs/removals only. On macOS, `make macos ACTION=install` applies the repo root `Brewfile`, and `BREWFILE=...` can point at an alternate manifest such as `Brewfile.complete`.
- `make macos-complete` — macOS bootstrap only, but with `Brewfile.complete`.
- `make verify-brewfile-complete` — macOS-only verification target that compares `Brewfile.complete` to a fresh temporary `brew bundle dump` without overwriting the tracked file.
- `make refresh-brewfile-complete` — macOS-only update target that rewrites `Brewfile.complete` from the current machine state and reminds you to review the diff before committing.
- `make install-complete` — full install flow using `Brewfile.complete` for the macOS bootstrap step.

## Backup/Restore Scope
- Backs up active Stow-managed targets such as `~/.zshenv`, `~/.zshrc`, `~/.zsh_plugins.txt`, `~/.tmux.conf`, `~/.gitconfig`, `~/.config/shell`, `~/.config/git`, and the managed `~/.config/*` tool directories.
- Skips any symlink already pointing into this repo to avoid backing up the repo itself. Symlink target resolution is implemented in a macOS- and Linux-compatible way instead of relying on `readlink -f`.
- Restore only copies files that do not already exist; it uses `rsync --ignore-existing` when available and otherwise falls back to a `cp`-based missing-path copy loop, so it will not overwrite current files.
- `make restore` remains the explicit path when you want to choose a specific backup; `make list-backups` and `make restore-latest` are non-interactive convenience wrappers around that flow, while `make restore-prompt` is the opt-in interactive picker that can be canceled cleanly.

## Safety and Idempotency
- Stow refuses conflicts; use `make force-install` to rename them aside automatically or move/backup conflicting files yourself. Use `stow --adopt` manually if you really intend to absorb them.
- Install/uninstall is safe to rerun; uninstall may remove `git`, `stow`, and `rsync`, and a later `make install` will bootstrap them again before continuing.
- No system services are touched; everything is user-space.

## Recovery Paths
- For a normal `make install`, undo links with `make uninstall` or `make unstow`, then restore backed-up files with `make restore BACKUP=…` if needed.
- `scripts/rollback-force-install.sh` is only for files renamed aside by `make force-install`; it does not restore from `make backup`.
- A typical force-install rollback sequence is `make uninstall` (or `make unstow`) followed by `DRY_RUN=0 scripts/rollback-force-install.sh`.

## Logging
- `LOG_FILE` controls where `make install` and `make force-install` append logs (default: `~/.dotfiles_install.log`). Disable logging with `LOG_FILE=` when invoking make.
- `scripts/rollback-force-install.sh` replays the most recent (or Nth most recent) `make force-install` moves from the log to restore backups. Use `DRY_RUN=1` to preview and `RUN_INDEX=2` to target the second-most-recent run.

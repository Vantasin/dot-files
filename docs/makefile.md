# Makefile Notes

## Purpose
- Orchestrates installs, backups, restores, and stow/unstow using `packages.stow` as the single source of truth.
- No custom linker logic; all linking is via GNU Stow with `--dotfiles --target="$HOME"`.

## Key Variables
- `PACKAGES_FILE=packages.stow` — authoritative list of packages to stow/unstow.
- `STOW_FLAGS=--dotfiles --target="$(HOME)"` — applied to all stow commands.
- `BACKUP_ROOT=$HOME/.dotfiles_backup` — where backups are stored.

## Core Targets (order of operations)
- `make install` — `check` → `status` (dry-run) → `backup` → `bootstrap (macos|debian) install` → `antidote` → `stow`.
- `make uninstall` — `unstow` → `bootstrap (macos|debian) uninstall` (does not touch backups or `~/.antidote`).
- `make stow|unstow|restow|status` — link management for all packages in `packages.stow`.
- `make backup` — rsyncs existing files in scope to `~/.dotfiles_backup/<timestamp>`, skipping symlinks into the repo.
- `make restore BACKUP=…` — rsyncs missing files back without overwriting anything that exists.
- `make antidote` — installs Antidote to `~/.antidote` if missing.
- `make macos|debian ACTION=install|uninstall` — run OS package installs/removals only.

## Backup/Restore Scope
- Backs up: `~/.profile`, zsh files (`.zsh*`), git, tmux, nano, btop, bat, ncdu, fastfetch configs under `~/.config`.
- Skips any symlink already pointing into this repo to avoid backing up the repo itself.
- Restore only copies files that do not already exist (`rsync --ignore-existing`); will not overwrite current files.

## Safety and Idempotency
- Stow refuses conflicts; move/backup conflicting files or use `stow --adopt` manually if you really intend to absorb them.
- Install/uninstall is safe to rerun; bootstrap scripts attempt packages individually and log skips/failures.
- No system services are touched; everything is user-space.

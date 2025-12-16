# dot-files — Stow-managed, Antidote-powered dotfiles

## Executive Summary
- Minimal, auditable dotfiles using GNU Stow for symlinks and pure Zsh with Antidote for plugins.
- For users who want explicit, reversible, XDG-friendly configs on macOS or Debian-based Linux.
- Manages user-space configs only: zsh, git, tmux, ranger, neofetch, btop, bat, ncdu, nano. No system services.
- Stow handles placement; Antidote handles plugins; package managers (or bootstrap scripts) handle binaries.
- Reference content in `reference/` is kept for posterity and not stowed.

## Quick Start
Prereqs: `zsh`, `git`, `stow` (optional tools listed in `bootstrap/macos.sh` / `bootstrap/debian.sh`).

One-shot (full lifecycle, more intrusive):
```sh
cd ~/dot-files
make install
```
> Runs: check → status (dry-run) → backup → bootstrap install → antidote → stow.

Install Antidote:
```sh
git clone --depth=1 https://github.com/mattmc3/antidote ~/.antidote
```

Dry-run (recommended):
```sh
cd ~/dot-files
make status    # or: stow -nv --dotfiles --target="$HOME" zsh git tmux btop neofetch ranger bat nano ncdu
```

Apply:
```sh
make stow      # or: stow --dotfiles --target="$HOME" zsh git tmux btop neofetch ranger bat nano ncdu
```

Verify:
- `exec zsh`, ensure prompt/plugins load; `ls -l ~/.zshrc` points into `~/dot-files`.

Rollback:
```sh
make unstow    # or: stow -D --dotfiles --target="$HOME" zsh git tmux btop neofetch ranger bat nano ncdu
```

Back up / Restore (optional):
```sh
make backup
make restore BACKUP=~/.dotfiles_backup/<timestamp>
```

## How it Works
- Stow: packages mirror target paths; `--dotfiles` converts `dot-*` to dotted targets (e.g., `zsh/dot-zshrc` → `~/.zshrc`, `bat/dot-config/bat/config` → `~/.config/bat/config`). No custom linker scripts.
- Antidote: plugins declared in `~/.zsh_plugins.txt` (zsh package) load via `antidote load` in `.zshrc`; defaults include `zsh-users/zsh-autosuggestions` and `zsh-users/zsh-syntax-highlighting` (last).
- Separation: Stow places files; Antidote fetches plugins; package managers install binaries (bootstrap scripts are optional wrappers).
- XDG: configs prefer `~/.config/<tool>/` for portability.

## Repository Layout
- Packages: `zsh/`, `git/`, `tmux/`, `ranger/`, `neofetch/`, `btop/`, `bat/`, `ncdu/`, `nano/` (all use `dot-*` paths that stow to `$HOME`).  
- Metadata: `packages.stow` (authoritative list), `Makefile` (stow/install/backup/restore), `bootstrap/` (optional installers).  
- Reference only: `reference/oh-my-zsh/`, `reference/nano-syntax/`, `reference/nanorc`, `reference/config-legacy/` (not stowed).  

## Notes / FAQ
- Are dotfiles hidden in the repo? No—files use `dot-` prefixes; `--dotfiles` makes dotted symlinks.  
- How to change plugins? Edit `~/.zsh_plugins.txt`, then open a new shell (or `antidote load < ~/.zsh_plugins.txt`).  
- Why XDG paths? Keeps configs tidy under `~/.config` and consistent across OSes.  

## License
See `LICENSE`.

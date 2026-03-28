# dot-files — Stow-managed, Antidote-powered dotfiles

- Minimal, auditable dotfiles using GNU Stow for symlinks and pure Zsh with Antidote for plugins.
- For users who want explicit, reversible, XDG-friendly configs on macOS, Debian, or Ubuntu.
- Manages user-space configs only: zsh, git, tmux, ranger, fastfetch, btop, bat, ncdu, nano. No system services.
- Stow handles placement; Antidote handles plugins; package managers (or bootstrap scripts) handle binaries.

## Quick Start (copy/paste)

macOS:
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi
brew install git stow rsync
git clone https://github.com/Vantasin/dot-files.git ~/Git/dot-files
cd ~/Git/dot-files && make install
```

Debian/Ubuntu:
```sh
sudo apt-get update && sudo apt-get install -y git stow rsync
git clone https://github.com/Vantasin/dot-files.git ~/Git/dot-files
cd ~/Git/dot-files && make install
```
> Use sudo only if required for package installs

> What `make install` does: check → status (dry-run) → backup → bootstrap (packages) → antidote → stow.
> If the dry-run reports conflicts, install stops immediately before backup/bootstrap and refuses to overwrite anything.
> On macOS, the bootstrap package set comes from the repo root [Brewfile](Brewfile) via `brew bundle`.
> For a broader machine restore snapshot, use [Brewfile.complete](Brewfile.complete) intentionally instead of making it the default bootstrap manifest.
> The repo does not install `~/.profile` or `~/.zprofile` by default.
> Keep login-shell files local to each machine; see [shell/README.md](shell/README.md) for optional examples.
> The canonical clone path in these docs is `~/Git/dot-files`.

If `make install` reports conflicts you want renamed aside automatically, run:
```sh
cd ~/Git/dot-files
make force-install
```
> `make force-install` is the only flow that works with `scripts/rollback-force-install.sh`.

Start zsh now:
```sh
zsh
```
> Verify: `ls -l ~/.zshrc` points into `~/Git/dot-files`
> Verify with the canonical path here: `ls -l ~/.zshrc ~/.zshenv ~/.zsh_plugins.txt ~/.config/shell`
> Local login-shell setup such as Homebrew `brew shellenv` belongs in a machine-local profile file, not in the active Stow package set.

## Common Tasks

- Preview links and conflicts: `make status`
- Rename conflicting targets aside and stow: `make force-install`
- Remove links: `make unstow`
- Back up existing files: `make backup`
- Restore missing files from a backup: `make restore BACKUP=~/.dotfiles_backup/<timestamp>`
- Apply the baseline macOS bundle: `make macos ACTION=install`
- Apply the complete macOS bundle snapshot: `make macos-complete`
- Run the full install flow with the complete macOS bundle snapshot: `make install-complete`

Undo a normal install:
```sh
cd ~/Git/dot-files
make uninstall
make restore BACKUP=~/.dotfiles_backup/<timestamp>
```
> Use `make uninstall` to remove the managed links and run the OS bootstrap uninstall path.
> If you only want to remove the links and keep packages installed, use `make unstow` instead of `make uninstall`.
> Use `make restore` for backups created by `make install` or `make backup`.

Undo a force-install:
```sh
cd ~/Git/dot-files
make uninstall
DRY_RUN=1 scripts/rollback-force-install.sh   # preview
DRY_RUN=0 scripts/rollback-force-install.sh   # apply (default)
```
> This only restores files that were renamed aside by `make force-install`.
> Use `make unstow` instead of `make uninstall` if you want to keep packages installed while removing the links before restoring the moved files.
> Uses `~/.dotfiles_install.log`; pick an older run with `RUN_INDEX=2` (3=third-latest, etc).

How restore works:
```sh
ls -1 ~/.dotfiles_backup
make restore BACKUP=~/.dotfiles_backup/<timestamp>
```
> `make install` runs `make backup` first, so normal installs usually create a new timestamped backup under `~/.dotfiles_backup/`.
> Choose the backup timestamp you want from `ls -1 ~/.dotfiles_backup`.
> `make restore` only restores files that do not currently exist; move or remove a current file first if you want the backup copy restored in its place.
> `make restore` is for backup directories. `scripts/rollback-force-install.sh` is only for files moved aside by `make force-install`.

## Repo Guide

- Docs hub: [docs/README.md](docs/README.md)
- Stow, install, backup, and restore behavior: [docs/makefile.md](docs/makefile.md)
- macOS package manifests and bootstrap notes: [Brewfile](Brewfile), [Brewfile.complete](Brewfile.complete), [docs/bootstrap.md](docs/bootstrap.md)
- Package index and per-package links: [docs/packages.md](docs/packages.md)
- Git config and repo-local hooks: [docs/git.md](docs/git.md), [.githooks/README.md](.githooks/README.md)
- Zsh and local shell notes: [docs/zsh.md](docs/zsh.md), [docs/shell.md](docs/shell.md)
- Agent and maintenance guidance: [AGENTS.md](AGENTS.md), [docs/agents/README.md](docs/agents/README.md)
- Human-readable audit trail: [docs/changelog/README.md](docs/changelog/README.md)

## License
[LICENSE](LICENSE)

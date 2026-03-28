# dot-files — Stow-managed, Antidote-powered dotfiles

- Minimal, auditable dotfiles using GNU Stow for symlinks and pure Zsh with Antidote for plugins.
- For users who want explicit, reversible, XDG-friendly configs on macOS, Debian, or Ubuntu.
- Manages user-space configs only: zsh, git, tmux, ranger, fastfetch, btop, bat, ncdu, nano. No system services.
- Stow handles placement; Antidote handles plugins; package managers (or bootstrap scripts) handle binaries.

## Quick Start (copy/paste)

macOS:
```sh
brew install git stow rsync
git clone https://github.com/Vantasin/dot-files.git ~/dot-files
cd ~/dot-files && make install
```

Debian/Ubuntu:
```sh
sudo apt-get update && sudo apt-get install -y git stow rsync
git clone https://github.com/Vantasin/dot-files.git ~/dot-files
cd ~/dot-files && make install
```
> Use sudo only if required for package installs

> What `make install` does: check → status (dry-run) → backup → bootstrap (packages) → antidote → stow.
> If the dry-run reports conflicts, install stops immediately before backup/bootstrap and refuses to overwrite anything.
> The repo does not install `~/.profile` or `~/.zprofile` by default.
> Keep login-shell files local to each machine; see [shell/README.md](shell/README.md) for optional examples.

If `make install` reports conflicts you want renamed aside automatically, run:
```sh
cd ~/dot-files
make force-install
```

Start zsh now:
```sh
zsh
```
> Verify: `ls -l ~/.zshrc` points into `~/dot-files`
> Local login-shell setup such as Homebrew `brew shellenv` belongs in a machine-local profile file, not in the active Stow package set.

## Common Tasks

- Preview links and conflicts: `make status`
- Rename conflicting targets aside and stow: `make force-install`
- Remove links: `make unstow`
- Back up existing files: `make backup`
- Restore missing files from a backup: `make restore BACKUP=~/.dotfiles_backup/<timestamp>`

Rollback force-install moves:
```sh
cd ~/dot-files
DRY_RUN=1 scripts/rollback-force-install.sh   # preview
DRY_RUN=0 scripts/rollback-force-install.sh   # apply (default)
```
> Uses `~/.dotfiles_install.log`; pick an older run with `RUN_INDEX=2` (3=third-latest, etc).

Rollback:
```sh
cd ~/dot-files
make unstow
```
> Or: `stow -D --dotfiles --target="$HOME" zsh git tmux btop fastfetch ranger bat nano ncdu`

## Repo Guide

- Docs hub: [docs/README.md](docs/README.md)
- Stow, install, backup, and restore behavior: [docs/makefile.md](docs/makefile.md)
- Package index and per-package links: [docs/packages.md](docs/packages.md)
- Git config and repo-local hooks: [docs/git.md](docs/git.md), [.githooks/README.md](.githooks/README.md)
- Zsh and local shell notes: [docs/zsh.md](docs/zsh.md), [docs/shell.md](docs/shell.md)
- Bootstrap scripts: [docs/bootstrap.md](docs/bootstrap.md)
- Agent and maintenance guidance: [AGENTS.md](AGENTS.md), [docs/agents/README.md](docs/agents/README.md)
- Human-readable audit trail: [docs/changelog/README.md](docs/changelog/README.md)

## License
[LICENSE](LICENSE)

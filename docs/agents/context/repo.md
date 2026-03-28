# Repo Context

## Purpose
- This is a Stow-managed dotfiles repo for personal shell and CLI tooling on macOS, Debian, and Ubuntu.
- The repo manages user-space config only. System package installation is optional and handled separately by the bootstrap scripts.

## Active Packages
- `zsh/` — `.zshenv`, `.zshrc`, plugin list, and shared shell config under `dot-config/shell/`.
- `tmux/` — `.tmux.conf`.
- `git/` — `.gitconfig` and `~/.config/git`.
- `ranger/` — ranger config.
- `fastfetch/` — fastfetch config.
- `btop/` — btop config.
- `bat/` — bat config.
- `ncdu/` — ncdu config.
- `nano/` — nano config and syntax includes.
- `shell/` — `.profile` and example shell entry files.

## Source Of Truth
- `packages.stow` defines what packages are installed or removed by Stow.
- `Makefile` wraps the common install, backup, restore, stow, and rollback flows.
- Package-specific behavior lives in `docs/*.md`.

## Important Directories
- `bootstrap/` — optional package install and uninstall scripts for supported operating systems.
- `docs/` — user and maintainer documentation for packages and workflows.
- `docs/agents/` — agent-oriented context, rules, and workflows.
- `reference/` — legacy or upstream material that should not be treated as active config.

## Useful References
- Install and stow behavior: [docs/makefile.md](../../makefile.md)
- Package map: [docs/packages.md](../../packages.md)
- Zsh flow: [docs/zsh.md](../../zsh.md)
- Shell shim details: [docs/shell.md](../../shell.md)
- Bootstrap scripts: [docs/bootstrap.md](../../bootstrap.md)

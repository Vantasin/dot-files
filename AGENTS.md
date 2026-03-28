# Repository Guidelines

`AGENTS.md` is the entrypoint for repo-specific guidance. Keep it short and stable; put deeper instructions under `docs/agents/` and package-specific details under `docs/`.

## Start Here
- This repo is a GNU Stow-managed dotfiles repo for user-space config only.
- This repo targets macOS, Debian, and Ubuntu systems.
- Root packages are listed in `packages.stow`: `zsh`, `tmux`, `git`, `ranger`, `fastfetch`, `btop`, `bat`, `ncdu`, `nano`.
- `packages.stow` is the single source of truth for what is stowed.
- `Brewfile` is the default repo-focused macOS Homebrew package manifest used by `bootstrap/macos.sh`.
- `Brewfile.complete` is an optional full-machine Homebrew Bundle snapshot and is not the default bootstrap manifest.
- `shell/` holds optional local login-shell examples and is not part of the active Stow package set.
- `reference/` contains legacy or upstream copies and is not part of the active install flow.
- `bootstrap/` contains optional OS package installers (`macos.sh`, `debian.sh`).

## Read Next
- Repo context: [docs/agents/context/repo.md](docs/agents/context/repo.md)
- Stable repo rules: [docs/agents/rules/repo.md](docs/agents/rules/repo.md)
- Docs rules: [docs/agents/rules/docs.md](docs/agents/rules/docs.md)
- Install and rollback flow: [docs/agents/workflows/install.md](docs/agents/workflows/install.md)
- Docs maintenance flow: [docs/agents/workflows/maintain-docs.md](docs/agents/workflows/maintain-docs.md)
- Commit preparation flow: [docs/agents/workflows/prepare-commit.md](docs/agents/workflows/prepare-commit.md)
- Verification matrix: [docs/agents/workflows/verify-by-change-type.md](docs/agents/workflows/verify-by-change-type.md)
- Package lifecycle flow: [docs/agents/workflows/manage-packages.md](docs/agents/workflows/manage-packages.md)
- Agent-config review flow: [docs/agents/workflows/review-agent-config.md](docs/agents/workflows/review-agent-config.md)
- Repo review flow: [docs/agents/workflows/review-repo.md](docs/agents/workflows/review-repo.md)
- Stow conflict handling: [docs/agents/workflows/stow-conflicts.md](docs/agents/workflows/stow-conflicts.md)
- Changelog policy: [docs/agents/rules/changelog.md](docs/agents/rules/changelog.md)
- Docs index: [docs/README.md](docs/README.md)
- Make targets and behavior: [docs/makefile.md](docs/makefile.md)
- Package map: [docs/packages.md](docs/packages.md)
- Zsh details and local shell notes: [docs/zsh.md](docs/zsh.md) and [docs/shell.md](docs/shell.md)
- Bootstrap package scripts: [docs/bootstrap.md](docs/bootstrap.md)
- Human-readable audit trail: [docs/changelog/README.md](docs/changelog/README.md)

## Non-Negotiables
- Do not edit `reference/` for active behavior changes.
- Do not commit secrets, machine-specific paths, or other host-local state.
- Prefer `make` targets over ad hoc commands when the target already exists.
- Validate relevant changes with `make status`; for shell changes also sanity-check with `bash -n` or `shellcheck` if available, then open a new shell.
- Use the commit workflow and repo-local hooks to prepare coherent commits, but do not auto-commit after every edit.
- Use relative Markdown links for internal docs and README cross-references.
- Run the fuller review and changelog flow for meaningful change sets, typically before commit or handoff, not after every small edit.
- Record significant behavioral or workflow changes in `docs/changelog/`; do not use it for trivial formatting-only edits.

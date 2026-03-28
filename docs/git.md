# Git Notes

## Location
- Stowed from `git/dot-gitconfig` to `~/.gitconfig`.

## Content
- Global git settings and aliases only (no repo-specific config).
- Uses user-space paths; does not touch system git config.

## Usage
- Apply via Stow: `stow --dotfiles --target="$HOME" git`.
- Edit `git/dot-gitconfig` to change settings; restow to apply.

## Repo-Local Hooks
- This repo can use a local hooks directory at `.githooks/`.
- Enable it with:
  `git config core.hooksPath .githooks`
- The included `pre-commit` hook is intentionally lightweight:
  rejects staged `.DS_Store`, runs `bash -n` on changed shell entry files and scripts, runs optional `shellcheck` on changed `*.sh` files if available, and runs `make status` against a temporary `HOME` when staged changes affect Stow-relevant files.
- Hooks should stay fast, deterministic, and local-only.

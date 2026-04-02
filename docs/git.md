# Git Notes

## Location
- Stowed from `git/dot-gitconfig` to `~/.gitconfig`.

## Content
- Global git settings and aliases only (no repo-specific config).
- Uses user-space paths; does not touch system git config.
- Sets `core.excludesFile` to `~/.config/git/ignore` for global ignore patterns managed by this repo.
- The managed global ignore file is the right place for editor/workspace metadata such as `.obsidian/`.
- Includes `~/.gitconfig.local` if present so personal `user.name` and `user.email` can stay machine-local and out of the repo.

## Usage
- Preferred: `make stow`.
- One-package raw Stow: `stow --dotfiles --ignore='(\.DS_Store|README\.md)$' --target="$HOME" git`.
- Edit `git/dot-gitconfig` to change settings; rerun `make restow` to apply.
- Edit `git/dot-config/git/ignore` to change global ignore patterns; rerun `make restow` to apply.
- Put personal identity in `~/.gitconfig.local`, for example:
  ```ini
  [user]
    name = Vantasin
    email = 76798329+Vantasin@users.noreply.github.com
  ```

## Repo-Local Hooks
- This repo can use a local hooks directory at `.githooks/`.
- Enable it with:
  `git config core.hooksPath .githooks`
- The included `pre-commit` hook is intentionally lightweight:
  rejects staged `.DS_Store`, runs `bash -n` on changed shell scripts and local shell example files, runs optional `shellcheck` on changed `*.sh` files if available, and runs `make status` against a temporary `HOME` when staged changes affect Stow-relevant files.
- Hooks should stay fast, deterministic, and local-only.

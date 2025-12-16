# Git Notes

## Location
- Stowed from `git/dot-gitconfig` to `~/.gitconfig`.

## Content
- Global git settings and aliases only (no repo-specific config).
- Uses user-space paths; does not touch system git config.

## Usage
- Apply via Stow: `stow --dotfiles --target="$HOME" git`.
- Edit `git/dot-gitconfig` to change settings; restow to apply.

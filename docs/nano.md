# Nano Notes

## Location
- Stowed from `nano/dot-config/nano/` to `~/.config/nano/`.

## Content
- `nanorc` and syntax/includes as provided.
- XDG layout; no `~/.nanorc` duplication.

## Usage
- Apply via Stow: `stow --dotfiles --target="$HOME" nano`.
- Ensure include paths in `nanorc` point to stowed syntax files.

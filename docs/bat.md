# Bat Notes

## Location
- Stowed from `bat/dot-config/bat/` to `~/.config/bat/`.

## Content
- `config` file for bat (batcat on Debian).

## Usage
- Preferred: `make stow`.
- One-package raw Stow: `stow --dotfiles --ignore='(\.DS_Store|README\.md)$' --target="$HOME" bat`.
- Uses user-space config only. After edits, rerun `make restow` to apply.

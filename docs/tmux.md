# Tmux Notes

## Location
- Stowed from `tmux/dot-tmux.conf` to `~/.tmux.conf`.

## Content
- User-space tmux settings only; no system services.

## Usage
- Preferred: `make stow`.
- One-package raw Stow: `stow --dotfiles --ignore='(\.DS_Store|README\.md)$' --target="$HOME" tmux`.
- After edits, rerun `make restow` or reload tmux config with `tmux source-file ~/.tmux.conf`.

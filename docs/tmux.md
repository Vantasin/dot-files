# Tmux Notes

## Location
- Stowed from `tmux/dot-tmux.conf` to `~/.tmux.conf`.

## Content
- User-space tmux settings only; no system services.

## Usage
- Apply via Stow: `stow --dotfiles --target="$HOME" tmux`.
- After edits, restow or reload tmux config with `tmux source-file ~/.tmux.conf`.

# tmux Package

This package stows tmux config into `~/.tmux.conf`.

## Main Content
- `dot-tmux.conf`

## Apply
- Preferred: `make stow`
- One-package raw Stow: `stow --dotfiles --ignore='(\.DS_Store|README\.md)$' --target="$HOME" tmux`

## Related Docs
- [../docs/tmux.md](../docs/tmux.md)
- [../docs/packages.md](../docs/packages.md)

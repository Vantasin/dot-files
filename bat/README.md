# bat Package

This package stows bat config into `~/.config/bat/`.

## Main Content
- `dot-config/bat/config`

## Apply
- Preferred: `make stow`
- One-package raw Stow: `stow --dotfiles --ignore='(\.DS_Store|README\.md)$' --target="$HOME" bat`

## Related Docs
- [../docs/bat.md](../docs/bat.md)
- [../docs/packages.md](../docs/packages.md)

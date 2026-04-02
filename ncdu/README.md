# ncdu Package

This package stows ncdu config into `~/.config/ncdu/`.

## Main Content
- `dot-config/ncdu/config`

## Apply
- Preferred: `make stow`
- One-package raw Stow: `stow --dotfiles --ignore='(\.DS_Store|README\.md)$' --target="$HOME" ncdu`

## Related Docs
- [../docs/ncdu.md](../docs/ncdu.md)
- [../docs/packages.md](../docs/packages.md)

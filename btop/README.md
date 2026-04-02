# btop Package

This package stows btop config into `~/.config/btop/`.

## Main Content
- `dot-config/btop/btop.conf`

## Apply
- Preferred: `make stow`
- One-package raw Stow: `stow --dotfiles --ignore='(\.DS_Store|README\.md)$' --target="$HOME" btop`

## Related Docs
- [../docs/btop.md](../docs/btop.md)
- [../docs/packages.md](../docs/packages.md)

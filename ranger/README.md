# ranger Package

This package stows ranger config into `~/.config/ranger/`.

## Main Content
- `dot-config/ranger/rc.conf`
- `dot-config/ranger/rifle.conf`

## Apply
- Preferred: `make stow`
- One-package raw Stow: `stow --dotfiles --ignore='(\.DS_Store|README\.md)$' --target="$HOME" ranger`

## Related Docs
- [../docs/ranger.md](../docs/ranger.md)
- [../docs/packages.md](../docs/packages.md)

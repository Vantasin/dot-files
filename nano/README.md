# nano Package

This package stows nano config and syntax files into `~/.config/nano/`.

## Main Content
- `dot-config/nano/nanorc`
- `dot-config/nano/syntax/`

## Apply
- Preferred: `make stow`
- One-package raw Stow: `stow --dotfiles --ignore='(\.DS_Store|README\.md)$' --target="$HOME" nano`

## Related Docs
- [../docs/nano.md](../docs/nano.md)
- [../docs/packages.md](../docs/packages.md)

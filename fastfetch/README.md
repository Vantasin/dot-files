# fastfetch Package

This package stows fastfetch config into `~/.config/fastfetch/`.

## Main Content
- `dot-config/fastfetch/config.jsonc`

## Notes
- The config is tuned for specific disk mounts. Review `folders` entries before relying on the disk modules everywhere.

## Apply
- Preferred: `make stow`
- One-package raw Stow: `stow --dotfiles --ignore='(\.DS_Store|README\.md)$' --target="$HOME" fastfetch`

## Related Docs
- [../docs/fastfetch.md](../docs/fastfetch.md)
- [../docs/packages.md](../docs/packages.md)

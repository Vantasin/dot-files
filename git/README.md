# git Package

This package stows global Git config into `~/.gitconfig` and `~/.config/git/`.

## Main Content
- `dot-gitconfig`
- `dot-config/git/`
  Contains the global excludes file used by `core.excludesFile`.
  `dot-gitconfig` also includes `~/.gitconfig.local` for machine-local identity settings.

## Apply
- Preferred: `make stow`
- One-package raw Stow: `stow --dotfiles --ignore='(\.DS_Store|README\.md)$' --target="$HOME" git`

## Related Docs
- [../docs/git.md](../docs/git.md)
- [../.githooks/README.md](../.githooks/README.md)
- [../docs/packages.md](../docs/packages.md)

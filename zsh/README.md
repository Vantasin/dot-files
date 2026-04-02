# zsh Package

This package stows the interactive zsh environment, plugin list, and shared shell modules.

## Main Content
- `dot-zshenv` -> `~/.zshenv`
- `dot-zshrc` -> `~/.zshrc`
- `dot-zsh_plugins.txt` -> `~/.zsh_plugins.txt`
- `dot-config/shell/` -> `~/.config/shell/`

## Notes
- Plugins are managed with Antidote.
- Shared shell config lives under `dot-config/shell/`.
- Login-shell files such as `~/.zprofile` remain local to each machine.
- After behavioral changes, open a new shell to verify startup is clean and fast.

## Apply
- Preferred: `make stow`
- One-package raw Stow: `stow --dotfiles --ignore='(\.DS_Store|README\.md)$' --target="$HOME" zsh`

## Related Docs
- [../docs/zsh.md](../docs/zsh.md)
- [../docs/shell.md](../docs/shell.md)
- [../docs/packages.md](../docs/packages.md)

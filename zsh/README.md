# zsh Package

This package stows the main zsh environment, interactive config, plugin list, and shared shell modules.

## Main Content
- `dot-zshenv` -> `~/.zshenv`
- `dot-zshrc` -> `~/.zshrc`
- `dot-zprofile` -> `~/.zprofile`
- `dot-zsh_plugins.txt` -> `~/.zsh_plugins.txt`
- `dot-config/shell/` -> `~/.config/shell/`

## Notes
- Plugins are managed with Antidote.
- Shared shell config lives under `dot-config/shell/`.
- After behavioral changes, open a new shell to verify startup is clean and fast.

## Apply
- `make stow`
- `stow --dotfiles --target="$HOME" zsh`

## Related Docs
- [../docs/zsh.md](../docs/zsh.md)
- [../docs/shell.md](../docs/shell.md)
- [../docs/packages.md](../docs/packages.md)

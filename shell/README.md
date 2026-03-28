# shell Package

This package stows the login-shell shim and example shell entry files.

## Main Content
- `dot-profile` -> `~/.profile`
- `dot-profile.example`
- `dot-bashrc.example`

## Notes
- `dot-profile` is POSIX-safe login environment setup only. It does not switch shells.
- If you want zsh as your default shell on macOS, Debian, or Ubuntu, change it explicitly with `chsh` instead of `exec zsh` from `.profile` or `.bashrc`.
- `dot-profile.example` and `dot-bashrc.example` are reference examples only; they should not trampoline into zsh.
- If a real `~/.profile` already exists, move it aside first or use `make force-install`.

## Apply
- `make stow`
- `stow --dotfiles --target="$HOME" shell`

## Related Docs
- [../docs/shell.md](../docs/shell.md)
- [../docs/packages.md](../docs/packages.md)
- [../docs/makefile.md](../docs/makefile.md)

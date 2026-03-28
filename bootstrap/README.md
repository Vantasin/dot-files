# Bootstrap Scripts

This directory contains optional OS package installation and uninstall scripts. It does not manage dotfiles directly or mutate local login-shell files such as `~/.profile` or `~/.zprofile`.

## Files
- `macos.sh`
- `debian.sh`
- [../Brewfile](../Brewfile) — the default repo-focused macOS Homebrew package manifest used by `macos.sh`
- [../Brewfile.complete](../Brewfile.complete) — an optional full-machine Homebrew Bundle snapshot for intentional restore use

## Usage
- `make macos ACTION=install`
- `make macos ACTION=install BREWFILE=Brewfile.complete`
- `make macos ACTION=uninstall`
- `make debian ACTION=install`
- `make debian ACTION=uninstall`

## Related Docs
- [../docs/bootstrap.md](../docs/bootstrap.md)
- [../docs/makefile.md](../docs/makefile.md)

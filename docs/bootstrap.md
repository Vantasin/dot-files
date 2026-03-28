# Bootstrap Scripts Notes

## Location
- `bootstrap/macos.sh` and `bootstrap/debian.sh`.

## Purpose
- Install/remove user-space binaries only (zsh, stow, tmux, ranger, fastfetch, etc.).
- No dotfile management; that is handled by Stow/Makefile.

## Usage
- Called via Makefile: `make macos ACTION=install|uninstall` or `make debian ACTION=install|uninstall`.
- Install action attempts core packages individually; logs and continues on failures or missing packages. Optional packages are attempted if available.
- Uninstall action removes the same package sets; does not touch backups or `~/.antidote`.
- The bootstrap scripts install `zsh` but do not change the user's login shell. Use `chsh -s "$(command -v zsh)"` explicitly if you want zsh as the default shell.

## Safety
- `set -euo pipefail`; uses sudo explicitly where needed.
- Skips packages not available in current apt/brew sources; leaves state untouched on failure.

## Package Sets (summary)
- macOS (brew): git, zsh, stow, tmux, ranger, btop, bat, ncdu, fzf, zoxide, lsd, tree, tldr, fastfetch.
- Debian (apt): git, zsh, stow, tmux, ranger, fastfetch, btop, bat, ncdu, fzf; optional: zoxide, lsd, tree, tldr.

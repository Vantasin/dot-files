# Bootstrap Scripts Notes

## Location
- `bootstrap/macos.sh`, `bootstrap/debian.sh`, and the repo root `Brewfile`.

## Purpose
- Install/remove user-space packages only; on macOS, the Brewfile may also include GUI apps via casks.
- No dotfile management; that is handled by Stow/Makefile.

## Usage
- Called via Makefile: `make macos ACTION=install|uninstall` or `make debian ACTION=install|uninstall`.
- macOS install applies the repo root `Brewfile` with `brew bundle --file=Brewfile`.
- macOS uninstall removes Brewfile-declared formulae, casks, and taps; it does not use `brew bundle cleanup`, which would target undeclared packages instead.
- Debian install attempts core packages individually; optional packages are attempted if available.
- Debian uninstall removes the same apt package sets; neither uninstall path touches backups or `~/.antidote`.
- The bootstrap scripts install `zsh` and related tools but do not change the user's login shell or mutate local profile files such as `~/.profile` or `~/.zprofile`.

## Safety
- `set -euo pipefail`; uses sudo explicitly where needed.
- Brewfile-driven macOS installs keep package declarations in one place instead of duplicating them in shell scripts.
- Debian install skips packages not available in current apt sources; leaves state untouched on failure.

## Package Sources
- macOS (Homebrew): declared in the repo root [../Brewfile](../Brewfile).
- Debian/Ubuntu (apt): declared in `bootstrap/debian.sh`, with a separate optional package list.

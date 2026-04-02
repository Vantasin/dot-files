# Bootstrap Scripts Notes

## Location
- `bootstrap/macos.sh`, `bootstrap/debian.sh`, the repo root `Brewfile`, and the optional `Brewfile.complete`.

## Purpose
- Install/remove user-space packages only; on macOS, the Brewfile may also include GUI apps via casks.
- No dotfile management; that is handled by Stow/Makefile.

## Usage
- Called via Makefile: `make macos ACTION=install|uninstall` or `make debian ACTION=install|uninstall`.
- macOS install applies the repo root `Brewfile` with `brew bundle --file=Brewfile`.
- Full `make install` may invoke the OS bootstrap earlier when `git`, `stow`, or `rsync` are missing, so reinstall after `make uninstall` can recover without a separate manual bootstrap step as long as `brew` or `apt` is still available.
- To apply a broader machine snapshot intentionally, use `make macos-complete` or override the manifest directly with `make macos ACTION=install BREWFILE=Brewfile.complete`.
- To run the full dotfiles install flow with the broader snapshot, use `make install-complete`.
- macOS uninstall removes Brewfile-declared formulae, casks, and taps; it does not use `brew bundle cleanup`, which would target undeclared packages instead.
- Debian install attempts core packages individually; optional packages are attempted if available.
- Debian uninstall removes the same apt package sets; neither uninstall path touches backups or `~/.antidote`.
- The bootstrap scripts install `zsh` and related tools but do not change the user's login shell or mutate local profile files such as `~/.profile` or `~/.zprofile`.

## Safety
- `set -euo pipefail`; uses sudo explicitly where needed.
- Brewfile-driven macOS installs keep package declarations in one place instead of duplicating them in shell scripts.
- Keep `Brewfile` focused on the repo's stable baseline; use `Brewfile.complete` for complete local restore snapshots instead of expanding the default bootstrap set indiscriminately.
- Debian install skips packages not available in current apt sources; leaves state untouched on failure.

## Package Sources
- macOS baseline (Homebrew): declared in the repo root [../Brewfile](../Brewfile).
- macOS complete snapshot (Homebrew): declared in [../Brewfile.complete](../Brewfile.complete), generated from the current machine with `brew bundle dump --file=Brewfile.complete --force`.
- When validating `Brewfile.complete`, use `brew bundle check --no-upgrade --file=Brewfile.complete` so the snapshot is checked for presence without failing on merely outdated packages.
- Debian/Ubuntu (apt): declared in `bootstrap/debian.sh`, with a separate optional package list.

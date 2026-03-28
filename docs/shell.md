# Shell Profile Notes

## Location
- Stowed from `shell/dot-profile` to `~/.profile`.

## Content
- POSIX-safe login environment setup only.
- Adds common user bin paths and, for interactive bash login shells, sources `~/.bashrc`.
- Does not `exec zsh` or switch shells.

## Shell Selection Policy
- Choose zsh as the default shell explicitly with `chsh -s "$(command -v zsh)"` if you want it as your real login shell.
- Do not use `.profile` or `.bashrc` to trampoline from bash into zsh. That can interfere with Debian and Ubuntu login-shell expectations and is harder to reason about.
- Shared login environment stays in `~/.profile`; zsh login shells pick that up via `~/.zprofile`.

## Usage
- Apply via Stow: `stow --dotfiles --target="$HOME" shell`.
- If you have an existing `~/.profile`, back it up or move it aside before stowing (e.g., `mv ~/.profile ~/.profile.bak-$(date +%m%d%y)`); Stow will refuse to overwrite a real file. `stow --adopt` is more intrusive—use only if you intend to absorb the file into the repo.

# Shell Profile Notes

## Location
- Stowed from `shell/dot-profile` to `~/.profile`.

## Content
- Minimal shim: if `zsh` exists, `exec zsh`; otherwise continue with the login shell (bash).

## Usage
- Apply via Stow: `stow --dotfiles --target="$HOME" shell`.
- If you have an existing `~/.profile`, back it up before stowing or use `stow --adopt` with care.

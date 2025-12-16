# Shell Profile Notes

## Location
- Stowed from `shell/dot-profile` to `~/.profile`.

## Content
- Minimal shim: if `zsh` exists, `exec zsh`; otherwise continue with the login shell (bash).

## Usage
- Apply via Stow: `stow --dotfiles --target="$HOME" shell`.
- If you have an existing `~/.profile`, back it up or move it aside before stowing (e.g., `mv ~/.profile ~/.profile.bak-$(date +%m%d%y)`); Stow will refuse to overwrite a real file. `stow --adopt` is more intrusive—use only if you intend to absorb the file into the repo.

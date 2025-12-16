# Package Notes

## Stow Packages (from `packages.stow`)
- `zsh/` — shell config (.zshenv, .zshrc, `~/.config/shell/*`, Antidote).
- `git/` — global Git config.
- `tmux/` — tmux settings.
- `ranger/` — ranger rc/rifle config.
- `fastfetch/` — system info config.
- `btop/` — btop config.
- `bat/` — bat (batcat) config.
- `ncdu/` — ncdu config.
- `nano/` — nano config/syntax includes.
- `shell/` — `.profile` shim to exec zsh if present.

## Usage
- Apply all: `stow --dotfiles --target="$HOME" $(cat packages.stow)`.
- Remove all: `stow -D --dotfiles --target="$HOME" $(cat packages.stow)`.

## Notes
- repo paths use `dot-*` names; Stow creates dotfiles in `$HOME`.
- Conflicts: Stow will refuse to overwrite; move/backup existing files before stowing or use `stow --adopt` with care.


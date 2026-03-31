# Ranger Notes

## Location
- Stowed from `ranger/dot-config/ranger/` to `~/.config/ranger/`.

## Content
- `rc.conf` for core ranger UI settings.
- `rifle.conf` for file opener rules.
- User-space only; no system-wide changes.

## Usage
- Apply via Stow: `stow --dotfiles --target="$HOME" ranger`.
- Reload ranger configs by restarting ranger.

## Notes
- The repo now ships a full `rifle.conf` override because rifle does not merge user rules with the packaged defaults.
- YAML files (`.yml`, `.yaml`) are treated like editable text so `ranger` opens them with `${VISUAL:-$EDITOR}` instead of delegating to the macOS `open` association.

# Local Shell Profile Notes

## Location
- Optional local shell examples live under `shell/`.
- `shell/` is not part of the active Stow package set in `packages.stow`.

## Files
- `shell/profile.example` — optional local `~/.profile` example for shared login-shell environment.
- `shell/bashrc.example` — optional local `~/.bashrc` example for bash-specific interactive settings.
- `shell/zprofile.macos.example` — optional local `~/.zprofile` example for macOS Homebrew login-shell setup.

## Scope
- This repo focuses on portable interactive zsh config and CLI tool config.
- The active install does not create or replace `~/.profile`, `~/.bashrc`, or `~/.zprofile`.
- Use the examples only when you intentionally want machine-local login-shell setup.

## Rules Of Thumb
- Do not use `.profile` or `.bashrc` to trampoline from bash into zsh.
- If you want zsh as the default shell, prefer `chsh -s "$(command -v zsh)"` over startup-file trampolining.
- Keep local login-shell setup minimal, quiet, and machine-specific.
- On macOS, keep local Homebrew login-shell setup in a local `~/.zprofile` if you need it.

# 2026-03-27 Shell Selection Policy

## Summary
- Clarified that the repo does not switch from bash into zsh via `.profile` or `.bashrc`.
- Updated shell examples and docs to recommend `chsh` when zsh should be the real login shell.
- Documented that `~/.profile` remains POSIX-safe shared login environment and `~/.zprofile` imports it for zsh login shells.

## Why
- Trampolining from bash into zsh in `.profile` or `.bashrc` is fragile and can interfere with Debian and Ubuntu login-shell behavior.
- The cleaner model is to make zsh the actual login shell when desired, and keep shell startup files scoped to their native roles.

## Verification
- Confirmed `shell/dot-profile` is already environment-only and does not exec another shell.
- Updated `shell/dot-profile.example`, `shell/dot-bashrc.example`, `docs/shell.md`, `docs/zsh.md`, `shell/README.md`, `README.md`, and `docs/bootstrap.md` to match that policy.

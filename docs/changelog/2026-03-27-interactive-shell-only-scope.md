# 2026-03-27 Interactive Shell Only Scope

## Summary
- Removed `shell` from the active Stow package set.
- Stopped stowing `~/.zprofile` from the `zsh` package.
- Converted `shell/` into a support directory for optional local login-shell examples.
- Updated install, backup, hook, and agent docs to match an interactive-shell-focused scope.

## Why
- The repo is intended to provide portable interactive shell configuration, not to own machine-local login-shell files.
- Managing `.profile` and `.zprofile` was creating avoidable conflicts and platform-specific friction.

## Verification
- Confirmed `packages.stow` no longer includes `shell`.
- Confirmed the active `zsh` package no longer contains `dot-zprofile`.
- Confirmed the pre-commit hook no longer treats `shell/` as a Stow-managed path.

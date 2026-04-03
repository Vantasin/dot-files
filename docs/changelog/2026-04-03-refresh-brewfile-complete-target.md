# 2026-04-03 Refresh Brewfile Complete Target

## Summary
- Added `make refresh-brewfile-complete` as a macOS-only update target that rewrites the tracked `Brewfile.complete` from the current machine state.
- Updated the README, Makefile docs, bootstrap docs, and verification matrix to document the paired `verify` and `refresh` workflows for the complete Homebrew snapshot.

## Why
- The repo now has a clear verification path for `Brewfile.complete`, so it should also have a named update path instead of relying on maintainers to remember the raw `brew bundle dump` command.
- Keeping both workflows behind Make targets makes the complete-snapshot maintenance flow easier to discover and less error-prone.

## Verification
- Ran `make status`.
- Ran `make help` and confirmed both `verify-brewfile-complete` and `refresh-brewfile-complete` appear.
- Ran `make -n refresh-brewfile-complete` to confirm the target prints the expected update command without rewriting the tracked file during verification.

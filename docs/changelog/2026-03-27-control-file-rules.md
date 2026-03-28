# 2026-03-27 Control File Rules

## Summary
- Added explicit repo rules for `Makefile`, `scripts/`, `bootstrap/`, `shell/dot-profile`, and `packages.stow`.
- Updated the repo review workflow to check those dedicated rules during meaningful review passes.

## Why
- These files and directories define the repo's operational behavior and are easy to break with otherwise reasonable changes.
- Making their invariants explicit gives agents a clearer maintenance contract and reduces accidental drift.

## Verification
- Confirmed the new rule sections align with the current repo behavior documented in `docs/makefile.md`, `docs/bootstrap.md`, `docs/shell.md`, and `docs/packages.md`.
- Confirmed the repo review workflow now explicitly checks those control-file rules.

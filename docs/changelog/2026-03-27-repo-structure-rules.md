# 2026-03-27 Repo Structure Rules

## Summary
- Added an explicit `Structure Rules` section to `docs/agents/rules/repo.md`.
- Updated the repo review workflow to check those structure invariants during meaningful review passes.

## Why
- The repo already had structure context, but the stable invariants were implied rather than stated as rules.
- Future maintenance is easier when agents can distinguish between descriptive context and required structure.

## Verification
- Confirmed the new rules align with the current repo layout: `packages.stow`, package directory READMEs, `docs/`, `bootstrap/`, `scripts/`, and `reference/`.
- Confirmed the review workflow now explicitly points back to the structure rules.

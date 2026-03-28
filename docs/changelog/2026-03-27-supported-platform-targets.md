# 2026-03-27 Supported Platform Targets

## Summary
- Added explicit supported-platform wording for macOS, Debian, and Ubuntu to the agent entrypoint and repo context.
- Added a repo rule requiring maintenance changes to preserve behavior across those three platforms unless documented otherwise.

## Why
- Debian and Ubuntu are both active targets for this repo and should be named explicitly instead of relying on inference from "Debian-based Linux".
- Platform support is part of the repo's maintenance contract, so it belongs in both context and rules.

## Verification
- Confirmed `AGENTS.md`, `docs/agents/context/repo.md`, and `docs/agents/rules/repo.md` now all reflect macOS, Debian, and Ubuntu as supported targets.

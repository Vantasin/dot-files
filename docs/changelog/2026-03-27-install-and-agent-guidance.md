# 2026-03-27 Install And Agent Guidance

## Summary
- Made `make force-install` parse Stow conflict output with macOS-compatible `awk`.
- Updated Stow flags to ignore `.DS_Store` so Finder metadata is not treated as a package file.
- Changed `make install` to stop immediately when the dry-run reports conflicts.
- Split `AGENTS.md` into a short entrypoint plus focused docs under `docs/agents/`.
- Added review and changelog guidance for future maintenance.

## Why
- `force-install` was failing on macOS because the conflict parser depended on GNU `awk` capture behavior.
- `.DS_Store` files were creating bogus Stow conflicts and should not participate in install state.
- `make install` was continuing into backup and bootstrap steps even after the dry-run had already shown it would fail.
- Agent guidance had started to mix stable rules with workflow detail and needed a cleaner structure.

## Verification
- Verified the conflict parser against real `stow -nv` output on macOS.
- Ran `make status` and confirmed the `.DS_Store` conflict disappeared while the real `~/.zprofile` conflict remained.
- Ran `make force-install` against a temporary `HOME` and confirmed conflicts were renamed aside and Stow completed.
- Confirmed the new agent docs exist and are referenced from `AGENTS.md`.

## Follow-up
- Future meaningful behavior or workflow changes should add an entry in this directory instead of relying on commit history alone for maintenance context.

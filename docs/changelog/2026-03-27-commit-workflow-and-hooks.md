# 2026-03-27 Commit Workflow And Hooks

## Summary
- Added a commit-preparation workflow for coherent staged commits.
- Added a repo-local `.githooks/pre-commit` hook and setup docs.
- Added commit rules to the stable repo rules and linked the new workflow from the agent indexes.

## Why
- Commit quality should be guided explicitly, but commits should not be forced after every edit.
- Lightweight local hooks provide a consistent baseline for staged checks even if the commit workflow is skipped.
- The hook uses a temporary `HOME` for `make status` so normal user-home conflicts do not block commits.

## Verification
- Confirmed the new workflow is linked from `AGENTS.md` and `docs/agents/README.md`.
- Confirmed the hook design stays local, fast, and scoped to staged changes.
- Confirmed the git docs and repo guide now explain how to enable the repo-local hooks.

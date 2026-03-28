# Repo Review Workflow

## Goal
- Review the repo for consistency, correctness, and maintainability without turning the process into a full release checklist.
- Use this workflow for meaningful change sets or before commit/handoff, not after every small edit while work is still in progress.

## When To Run It
- Run a lightweight check during development when the change is relevant, for example `make status`, `bash -n`, or opening a new shell.
- Run the full review pass for coherent changes that affect behavior, package layout, install flow, shell startup, docs structure, or maintenance workflow.
- Treat this as a pre-commit or pre-handoff workflow, not a per-save workflow.

## Review Pass
1. Run `make status` to catch active Stow conflicts or package-layout problems.
2. Compare `packages.stow` against the actual top-level package directories and `docs/packages.md`.
3. Check `Makefile`, `README.md`, and `docs/` for stale package names, old commands, or mismatched install behavior.
4. Look for repo-side junk that should not be stowed, such as metadata files or accidental host-local artifacts.
5. For shell or bootstrap changes, run `bash -n` and `shellcheck` if available.
6. If zsh startup behavior changed, open a new shell and confirm it starts cleanly and quickly.
7. Use the verification matrix in `docs/agents/workflows/verify-by-change-type.md` when the change crosses multiple areas.

## Consistency Checks
- Active packages should exist in `packages.stow`, have matching directories, and be described consistently in docs.
- Top-level directories should still match the structure rules in `docs/agents/rules/repo.md`.
- `Makefile`, `scripts/`, `bootstrap/`, `shell/dot-profile`, and `packages.stow` should still satisfy the dedicated rules in `docs/agents/rules/repo.md`.
- `Makefile` behavior, `README.md`, and `docs/makefile.md` should agree on install, backup, restore, and force-install semantics.
- Source-of-truth and drift-resolution rules should still hold: no known mismatch should be left split across code and docs.
- Agent docs should point to real files and reflect the current repo structure.

## Finish
- Fix repo-side issues directly when they are clearly wrong.
- If the change alters install behavior, shell startup, package layout, or agent workflow, add a short entry under `docs/changelog/`.

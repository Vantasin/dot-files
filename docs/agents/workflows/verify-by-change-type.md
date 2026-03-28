# Verification Matrix

Use this as a quick selector for the smallest verification set that matches the change.

## Makefile Or Stow Flow Changes
- Run `make status`.
- If install, force-install, backup, or restore semantics changed, validate the affected path directly, preferably against a temporary `HOME` when practical.
- Update `docs/makefile.md` and the root `README.md` if user-facing behavior changed.

## Package Add, Remove, Or Rename
- Run `make status`.
- Confirm `packages.stow`, the top-level package directories, `docs/packages.md`, and the package `README.md` files stay in sync.
- If a package README was added, confirm the Stow ignore pattern still excludes it.

## Shell Profile Or Zsh Startup Changes
- Run `bash -n` on POSIX shell files and `shellcheck` if available.
- Open a new shell and confirm startup is clean and fast.
- If the change touches `shell/`, confirm it remains example-only and is still not part of the active Stow package set.
- Review login-shell behavior on macOS, Debian, and Ubuntu assumptions before merging.

## Bootstrap Changes
- Run `bash -n` on the bootstrap scripts and `shellcheck` if available.
- Review package handling separately for macOS and Debian/Ubuntu.
- Confirm docs still match in `docs/bootstrap.md` and the root `README.md` if onboarding changed.

## Script Changes
- Run `bash -n` on the changed scripts and `shellcheck` if available.
- Exercise the documented mode of the script when practical, or at least verify argument and environment expectations against the docs.
- Confirm the nearest README or doc still describes the script correctly.

## Docs And README Changes
- Open the changed Markdown and check relative links and file references.
- Confirm commands still match current repo behavior.
- If the docs describe behavior, verify the actual repo files instead of trusting older prose.

## Agent Config Changes
- Run [review-agent-config.md](review-agent-config.md).
- Confirm `AGENTS.md`, `docs/agents/README.md`, and `docs/README.md` still point to the right entrypoints.

## Commit Preparation
- Run [prepare-commit.md](prepare-commit.md) when the change set is ready to stage and commit.
- If repo-local hooks are enabled, expect the staged checks to re-run in `.githooks/pre-commit`.

## Broad Or Cross-Cutting Changes
- Run the relevant checks from each affected category rather than relying on a single generic review step.
- If the change set is meaningful, update or add a changelog entry near commit or handoff time.

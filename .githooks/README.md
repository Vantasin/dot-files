# Repo-Local Git Hooks

This repo includes lightweight local hooks under `.githooks/`.

## Enable
```sh
git config core.hooksPath .githooks
```

## Current Hook
- `pre-commit`

## What `pre-commit` Checks
- rejects staged `.DS_Store`
- runs `bash -n` on changed shell scripts and local shell example files
- runs `shellcheck` on changed `*.sh` files if `shellcheck` is installed
- runs `make status` against a temporary `HOME` when staged changes affect Stow-relevant files

## Design Constraints
- fast
- deterministic
- local-only
- scoped to staged changes

## Related Docs
- [../docs/git.md](../docs/git.md)
- [../docs/agents/workflows/prepare-commit.md](../docs/agents/workflows/prepare-commit.md)
- [../docs/agents/workflows/verify-by-change-type.md](../docs/agents/workflows/verify-by-change-type.md)

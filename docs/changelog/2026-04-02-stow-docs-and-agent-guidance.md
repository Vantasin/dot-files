# 2026-04-02 Stow Docs And Agent Guidance

## Summary
- Updated the package READMEs and package docs so raw Stow examples now use the repo's canonical ignore flags instead of omitting them.
- Updated the agent guidance to reflect the current repo structure by replacing the stale `reference/` mentions with the actual support directories and review expectations.

## Why
- Raw `stow --dotfiles --target="$HOME"` examples drifted away from the repo's real `STOW_FLAGS`, which include the ignore rules for `.DS_Store` and package `README.md` files.
- The agent docs should describe the repo that exists now, not an older layout that included a `reference/` directory.

## Verification
- Ran `make status`.
- Grepped the package docs to confirm the raw Stow examples now include the canonical ignore flags.
- Reviewed the updated agent docs to confirm they point to real directories in the current repo.

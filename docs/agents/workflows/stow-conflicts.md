# Stow Conflict Workflow

## Diagnose
1. Run `make status` to see the exact conflict paths.
2. Separate user-home conflicts from repo-side problems such as stray files inside package trees.
3. If the conflict is unexpected, inspect `packages.stow`, the package directory, and `docs/makefile.md` before changing behavior.

## Resolve User-Home Conflicts
- If the user wants to preserve existing files automatically, use `make force-install`.
- If the user wants to review or keep a file in place, move it manually and rerun `make status`.
- Avoid `stow --adopt` unless the user explicitly wants repo contents replaced by the current home-directory files.

## Resolve Repo-Side Conflicts
- If a file should not be stowed, fix the repo rather than telling the user to work around it.
- Common examples are metadata files, stale package entries, or layout drift between package paths and docs.
- Keep ignore behavior conservative; avoid broad ignore patterns that could hide real config files.

## Finish
- Rerun `make status` until the dry-run is clean.
- If using `make force-install`, mention the backup suffix format and log file location in the handoff.

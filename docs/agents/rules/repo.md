# Repo Rules

## Structure Rules
- Top-level Stow packages must be listed in `packages.stow`, and entries in `packages.stow` must correspond to real top-level package directories.
- Package directories are Stow roots. Keep package content stowable, except for explicitly ignored documentation files such as `README.md`.
- The repo root `README.md` is a quick-start and navigation document, not the full source of truth for package behavior.
- Top-level package and support-directory `README.md` files are concise entrypoints that should link to deeper docs instead of duplicating them.
- Detailed operational and package-specific behavior belongs in `docs/*.md`.
- `docs/packages.md` is the package index and should stay aligned with `packages.stow` and the package directory READMEs.
- `bootstrap/` is for OS package installation helpers, not for stowed dotfile content.
- `scripts/` is for maintenance helpers tied to documented workflows.
- `reference/` is archival or upstream material and should not drive active behavior changes.

## Platform Rules
- Changes to shell config, `Makefile` logic, Stow workflows, and bootstrap behavior should preserve behavior across macOS, Debian, and Ubuntu unless explicitly documented otherwise.
- When platform-specific behavior is necessary, keep it isolated, prefer existing OS checks or bootstrap entrypoints, and document the difference in the relevant docs.

## Source Of Truth Rules
- Actual repo files and executable behavior are authoritative over summaries. Validate against `Makefile`, `packages.stow`, package contents, and runnable commands before trusting higher-level docs.
- `packages.stow` is authoritative for the active package set.
- `Makefile` and the files it drives are authoritative for install, stow, backup, restore, and rollback behavior.
- `docs/*.md` explain detailed behavior and should stay aligned with the code.
- Root and package `README.md` files are onboarding and navigation aids, not the final source of truth for implementation details.

## Drift Resolution Rules
- If behavior and docs disagree, do not leave the mismatch unresolved. Either change behavior to match the intended docs or update the docs to match actual behavior in the same change set.
- If two docs disagree, resolve them in favor of the lower-level or more specific source, then align the rest.
- When unsure, inspect the actual repo files and run the smallest relevant verification step before deciding which side is stale.
- Meaningful drift fixes should usually get a changelog entry because they affect maintenance trust.

## Makefile Rules
- Preserve the documented semantics of `make status`, `make install`, `make force-install`, `make backup`, `make restore`, `make stow`, and `make unstow`.
- Prefer extending existing Make targets and variables over introducing parallel ad hoc shell flows.
- Keep `STOW_FLAGS` aligned with the repo structure and docs, including ignore behavior for documentation-only files.
- If `Makefile` behavior changes, update `docs/makefile.md`, the root `README.md` when user-facing flow changes, and any affected workflow docs.

## Script Rules
- Keep files in `scripts/` tied to documented workflows rather than creating separate undocumented entrypoints.
- Scripts should stay non-interactive unless the workflow explicitly requires otherwise.
- Shell scripts should remain portable across macOS, Debian, and Ubuntu, and use explicit, reviewable behavior.
- When adding or changing a script, document its purpose and usage in the nearest relevant README or doc.

## Bootstrap Rules
- `bootstrap/` installs or removes user-space tools only; it must not manage dotfiles directly.
- Bootstrap behavior must not silently change the user's login shell or mutate unrelated shell startup files.
- Keep platform-specific package handling isolated inside the bootstrap scripts or their documented Make entrypoints.
- If bootstrap package sets or behavior change, update `docs/bootstrap.md`.

## Profile Rules
- `shell/dot-profile` must remain POSIX-safe, quiet, and environment-focused.
- Do not use `.profile` or `.bashrc` to `exec` zsh or any other shell.
- Shared login environment belongs in `~/.profile`; zsh login shells should inherit it via `~/.zprofile`.
- Profile changes should be reviewed for login-shell side effects on macOS, Debian, and Ubuntu.

## Package List Rules
- `packages.stow` is the authoritative list of active Stow packages.
- Adding, removing, or renaming a package requires keeping `packages.stow`, the top-level directory layout, `docs/packages.md`, and package `README.md` files in sync.
- Do not leave stale package directories undocumented or package list entries pointing at missing directories.
- Review Stow-facing package changes with `make status`.

## Commit Rules
- Commits should stage one coherent change set and leave unrelated work unstaged.
- Run the smallest relevant verification from the verification matrix before committing.
- Review the staged diff, not just the working tree, before creating a commit.
- Use concise imperative commit subjects.
- Do not auto-commit after every edit; commits should happen when requested or when deliberately wrapping up a coherent change set.

## Layout And Ownership
- Treat `packages.stow` as authoritative for active packages.
- Keep active changes inside the package directories, `Makefile`, `bootstrap/`, and `docs/`.
- Do not edit `reference/` unless the task is explicitly about archived or upstream material.

## Stow And Install Rules
- Prefer `make status`, `make stow`, `make unstow`, `make restow`, `make install`, and `make force-install` over raw Stow commands.
- Do not use `stow --adopt` unless the user explicitly asks to adopt existing files into the repo.
- Do not intentionally add Finder metadata or other host-local junk to packages. The repo ignores `.DS_Store`, but those files should still be avoided.

## Editing Conventions
- Shell scripts should use bash with `set -euo pipefail` and stay explicit and portable.
- Zsh config should remain pure zsh with Antidote; keep plugins in `.zsh_plugins.txt` and avoid Oh-My-Zsh patterns.
- Follow the existing XDG layout: tool config under `.config/<tool>/`, root dotfiles at package root.
- When behavior changes, update the relevant docs in `docs/`.

## Validation
- Default validation is `make status`.
- For shell script changes, also run `bash -n` and `shellcheck` if available.
- For zsh changes, open a new shell to confirm startup is fast and error-free.

## Safety
- Do not commit secrets, tokens, or machine-specific absolute paths.
- Be careful with conflict resolution and backup flows because the target is the user's home directory.

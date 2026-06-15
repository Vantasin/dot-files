# 2026-06-14 Preserve Brewfile Complete Heading

## Summary
- Updated `make refresh-brewfile-complete` to prepend the repo-specific snapshot heading after generating Homebrew entries.
- Updated `make verify-brewfile-complete` to compare against a generated snapshot with the same heading.
- Restored the heading in `Brewfile.complete` and documented the behavior.

## Why
- `brew bundle dump --force` rewrites the target file and drops hand-maintained comments.
- The complete snapshot should keep its local context because it is intentionally not the default bootstrap manifest.

## Verification
- Ran `make -n refresh-brewfile-complete`.
- Ran `make -n verify-brewfile-complete`.
- Ran `make refresh-brewfile-complete`.
- Ran `make verify-brewfile-complete`.
- Ran `brew bundle check --no-upgrade --file=Brewfile.complete`.
- Ran `make status`.

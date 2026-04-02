# 2026-04-02 Restore cp Fallback

## Summary
- Changed `make restore` to use `rsync` when available and fall back to a `cp`-based missing-path copy loop when `rsync` is missing.
- Updated the restore docs to describe the fallback explicitly.

## Why
- The normal recovery flow is documented as `make uninstall` followed by `make restore`, but the macOS uninstall path can remove repo-managed `rsync`.
- Restore should be able to put user config files back without requiring a package reinstall or network access first.

## Verification
- Ran temporary-`HOME` restores through both paths: once with a fake `rsync` present and once with `rsync` absent so the real `cp` fallback ran.
- Confirmed both paths restored missing files, preserved symlinks, and left existing files untouched.

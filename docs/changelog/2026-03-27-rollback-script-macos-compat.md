# 2026-03-27 Rollback Script macOS Compatibility

## Summary
- Replaced Bash 4-only `mapfile` usage in `scripts/rollback-force-install.sh` with logic that works on macOS's default Bash 3.2.
- Avoided array slicing with negative offsets so the selected force-install run is resolved portably.

## Why
- The rollback helper was failing on macOS after `make force-install` because `/bin/bash` there does not provide `mapfile`.
- The script needs to work on the same systems the install and force-install flow supports.

## Verification
- Ran `bash -n scripts/rollback-force-install.sh`.
- Ran a temporary-home cycle of `make force-install`, `make uninstall`, and `scripts/rollback-force-install.sh`.
- Confirmed the original conflicting file content was restored after rollback.

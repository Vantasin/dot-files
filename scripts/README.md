# Scripts

This directory contains maintenance scripts that support install and rollback workflows.

## Current Scripts
- `quick-install.sh` — optional convenience wrapper for the README quick start; installs prerequisites, clones the repo to the canonical path, and runs `make install`
- `rollback-force-install.sh` — replays logged `make force-install` moves to restore backups

## Usage
- Local dry-run preview: `DRY_RUN=1 scripts/quick-install.sh`
- Local install: `scripts/quick-install.sh`
- Curl-based convenience entrypoint: documented in [../README.md](../README.md)

## Related Docs
- [../README.md](../README.md)
- [../docs/makefile.md](../docs/makefile.md)
- [../docs/changelog/README.md](../docs/changelog/README.md)

# 2026-04-03 Verify Brewfile Complete Target

## Summary
- Added `make verify-brewfile-complete` as a macOS-only verification target that compares the tracked `Brewfile.complete` to a fresh temporary `brew bundle dump`.
- Updated the Makefile docs, bootstrap docs, and README task list to point at the new verification path.

## Why
- Checking whether `Brewfile.complete` still matches the current machine state should not require overwriting the tracked snapshot first.
- A named Make target keeps the verification workflow discoverable and consistent with the rest of the repo.

## Verification
- Ran `make status`.
- Ran `make help` and confirmed the new target appears.
- Ran `make verify-brewfile-complete`; in this environment it failed due the current Homebrew/cache permission issue rather than Makefile syntax, which is the expected underlying blocker.

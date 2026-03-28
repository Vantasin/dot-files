# 2026-03-27 Local Git Identity Include

## Summary
- Switched the tracked Git config to include `~/.gitconfig.local` for personal identity instead of storing `user.name` and `user.email` directly in the repo.
- Documented the local-include pattern in the Git package docs.

## Why
- The repo should manage the Git config structure without publishing personal identity values.
- Because `~/.gitconfig` is stowed from this repo, running `git config --global user.name ...` would otherwise edit the tracked repo file directly.

## Verification
- Confirmed Git reads `include.path = ~/.gitconfig.local` without requiring the file to exist.
- Updated the local include path documentation with an example `user` block.

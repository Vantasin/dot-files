# Git Auto Setup Remote

## Summary
- Enabled `push.autoSetupRemote` in the stowed global Git config.
- Documented that first pushes from new branches now create upstream tracking branches automatically.

## Why
- This removes the repeated manual `git push --set-upstream <remote> <branch>` step for new local branches.

## Verification
- Parsed `git/dot-gitconfig` with `git config --file`.
- Ran `make status`.

# Bitwarden Git SSH Signing

## Summary
- Added quiet cross-platform Bitwarden SSH Agent socket resolution to the stowed zsh environment.
- Added shared Git SSH-signing defaults and a public-only local allowed-signers policy while keeping automatic signing a workstation-local opt-in.

## Why
- Git's SSH signing subprocess needs `SSH_AUTH_SOCK`, while remote authentication and commit signing intentionally use separate keys.
- Linux hosts without a Bitwarden socket or signing key must continue to work without being forced to sign commits.

## Verification
- Syntax-checked the zsh environment, opened a clean new shell, and ran the repository Stow dry-run.
- Exercised both socket selection and preservation of an inherited agent when no Bitwarden socket exists.
- Compared the configured public key fingerprint, agent identities, and Git configuration origins.

## Follow-up
- Enable `commit.gpgsign` only in each provisioned workstation's untracked `~/.gitconfig.local` and register the signing public key with the Git forge.

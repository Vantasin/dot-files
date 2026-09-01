# Git Notes

## Location
- Stowed from `git/dot-gitconfig` to `~/.gitconfig`.

## Content
- Global git settings and aliases only (no repo-specific config).
- Uses user-space paths; does not touch system git config.
- Sets `core.excludesFile` to `~/.config/git/ignore` for global ignore patterns managed by this repo.
- The managed global ignore file is the right place for editor/workspace metadata such as `.obsidian/`.
- Sets `push.autoSetupRemote = true` so the first `git push` from a new branch creates the upstream tracking branch.
- Uses SSH-format signatures and points `user.signingkey` at `~/.ssh/git_signing_key.pub`.
- Uses the public-only `~/.config/git/allowed_signers` file to verify signatures made by the configured Git identity. This local verification policy is separate from any repository-owned signer allowlist.
- Includes `~/.gitconfig.local` last, if present, so personal identity and workstation-specific overrides stay machine-local and out of the repo.

## Bitwarden SSH Signing
- The authentication key used to connect to a Git remote and the signing key used to attest commits are separate keys. Do not replace an SSH host's transport `IdentityFile` or `IdentityAgent` entry with the signing key.
- `.zshenv` quietly selects the first Bitwarden path for the current platform that exists and is a Unix socket:
  - macOS App Store: `~/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock`
  - macOS DMG or native Linux: `~/.bitwarden-ssh-agent.sock`
  - Linux Snap: `~/snap/bitwarden/current/.bitwarden-ssh-agent.sock`
  - Linux Flatpak: `~/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock`
- If none exists, `.zshenv` leaves the inherited `SSH_AUTH_SOCK` unchanged. Linux hosts without Bitwarden therefore keep their existing agent and do not opt in to automatic signing.
- Git invokes `ssh-keygen` for SSH signatures, so it needs `SSH_AUTH_SOCK`; SSH `IdentityAgent` entries alone do not select the signing agent.

Enable automatic commit signing only on a provisioned workstation by adding this to its existing `~/.gitconfig.local`, alongside (not instead of) `user.name` and `user.email`:

```ini
[commit]
  gpgsign = true
```

Because the local include loads last, it can also override `user.signingkey` during a staged key rotation. Do not enable `commit.gpgsign` on a host until `~/.ssh/git_signing_key.pub` exists and `ssh-add -l` against the selected agent shows the same fingerprint as `ssh-keygen -lf ~/.ssh/git_signing_key.pub`.

## Rotation And Removal
- To rotate the signing key, add the new private key to Bitwarden, replace `~/.ssh/git_signing_key.pub`, update the public key in `allowed_signers`, and register the new public key with each forge. Keep an old allowed-signers entry only while signatures from that key should remain locally trusted.
- To stop signing on one workstation, remove `commit.gpgsign` from `~/.gitconfig.local`. To retire the key everywhere, also remove its public entry from `allowed_signers` and from each forge; no private key is stored here.

## Troubleshooting
- Run `printf '%s\n' "$SSH_AUTH_SOCK"` and confirm it is one of the supported socket paths.
- Run `test -S "$SSH_AUTH_SOCK"` to confirm the selected path is still a Unix socket.
- Run `ssh-add -l` and compare its fingerprints with `ssh-keygen -lf ~/.ssh/git_signing_key.pub`.
- If the vault is locked or the signing identity is absent, unlock Bitwarden, confirm its SSH Agent is enabled and the key item permits agent use, then open a new shell. Git signing will fail while the agent exposes no matching identity; removing the workstation-local `commit.gpgsign` setting temporarily restores unsigned commits.
- Use `git config --show-origin --get-regexp '^(gpg\.format|gpg\.ssh\.allowedsignersfile|user\.signingkey|commit\.gpgsign)$'` to find the file supplying each signing setting.

## Usage
- Preferred: `make stow`.
- One-package raw Stow: `stow --dotfiles --ignore='(\.DS_Store|README\.md)$' --target="$HOME" git`.
- Edit `git/dot-gitconfig` to change settings; rerun `make restow` to apply.
- Edit `git/dot-config/git/ignore` to change global ignore patterns; rerun `make restow` to apply.
- Put personal identity and any workstation-only signing opt-in in `~/.gitconfig.local`, for example:
  ```ini
  [user]
    name = Vantasin
    email = 76798329+Vantasin@users.noreply.github.com

  # Add only after this workstation has the public key and agent identity.
  [commit]
    gpgsign = true
  ```

## Repo-Local Hooks
- This repo can use a local hooks directory at `.githooks/`.
- Enable it with:
  `git config core.hooksPath .githooks`
- The included `pre-commit` hook is intentionally lightweight:
  rejects staged `.DS_Store`, runs `bash -n` on changed shell scripts and local shell example files, runs optional `shellcheck` on changed `*.sh` files if available, and runs `make status` against a temporary `HOME` when staged changes affect Stow-relevant files.
- Hooks should stay fast, deterministic, and local-only.

#!/usr/bin/env bash
set -euo pipefail

ACTION="${1:-install}"
packages=(
  git
  zsh
  stow
  tmux
  ranger
  neofetch
  btop
  bat
  ncdu
  fzf
  zoxide
  lsd
  tree
  tldr
  fastfetch
)

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required: install from https://brew.sh first." >&2
  exit 1
fi

case "$ACTION" in
  install)
    brew update
    brew install "${packages[@]}"
    cat <<'EOS'
Reminder:
- Add Homebrew's zsh to /etc/shells and run: chsh -s "$(command -v zsh)"
- fzf key-bindings/completion: "$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-update-rc
EOS
    ;;
  uninstall)
    # Safe, idempotent removal; ignores missing formulas.
    brew uninstall --ignore-dependencies "${packages[@]}" || true
    ;;
  *)
    echo "Unknown action: $ACTION (expected install|uninstall)"
    exit 1
    ;;
esac

#!/usr/bin/env bash
set -euo pipefail

ACTION="${1:-install}"

packages=(
  git
  zsh
  stow
  nano
  tmux
  ranger
  fastfetch
  btop
  bat
  ncdu
  fzf
)

optional_packages=(zoxide lsd tree tealdeer)

case "$ACTION" in
  install)
    sudo apt-get update
    # Install core packages individually; continue on failures.
    for pkg in "${packages[@]}"; do
      sudo apt-get install -y "$pkg" || echo "Skipping $pkg (install failed or unavailable)"
    done
    for pkg in "${optional_packages[@]}"; do
      sudo apt-get install -y "$pkg" || echo "Skipping $pkg (install failed or unavailable)"
    done
    cat <<'EOS'
Reminder:
- Debian/Ubuntu package 'bat' installs the 'batcat' binary; aliases handle this.
- To make zsh your login shell: chsh -s "$(command -v zsh)"
EOS
    ;;
  uninstall)
    sudo apt-get remove -y "${packages[@]}" || true
    for pkg in "${optional_packages[@]}"; do
      if apt-cache policy "$pkg" 2>/dev/null | grep -qv 'Candidate: (none)'; then
        sudo apt-get remove -y "$pkg" || true
      fi
    done
    ;;
  *)
    echo "Unknown action: $ACTION (expected install|uninstall)"
    exit 1
    ;;
esac

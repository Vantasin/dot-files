#!/usr/bin/env bash
set -euo pipefail

ACTION="${1:-install}"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BREWFILE="${BREWFILE:-$REPO_ROOT/Brewfile}"

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required: install from https://brew.sh first." >&2
  exit 1
fi

if [[ ! -f "$BREWFILE" ]]; then
  echo "Brewfile not found: $BREWFILE" >&2
  exit 1
fi

brewfile_entries() {
  local kind="$1"
  awk -v kind="$kind" '
    $0 ~ "^[[:space:]]*" kind "[[:space:]]+\"" {
      line = $0
      sub(/^[[:space:]]*[[:alpha:]_]+[[:space:]]+"/, "", line)
      sub(/".*$/, "", line)
      print line
    }
  ' "$BREWFILE"
}

case "$ACTION" in
  install)
    brew bundle --file="$BREWFILE"
    cat <<'EOS'
Reminder:
- fzf key-bindings/completion: "$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-update-rc
EOS
    ;;
  uninstall)
    mapfile -t formulae < <(brewfile_entries brew)
    if [[ ${#formulae[@]} -gt 0 ]]; then
      brew uninstall --ignore-dependencies "${formulae[@]}" || true
    fi

    mapfile -t casks < <(brewfile_entries cask)
    if [[ ${#casks[@]} -gt 0 ]]; then
      brew uninstall --cask "${casks[@]}" || true
    fi

    mapfile -t taps < <(brewfile_entries tap)
    for tap in "${taps[@]}"; do
      brew untap "$tap" || true
    done
    ;;
  *)
    echo "Unknown action: $ACTION (expected install|uninstall)"
    exit 1
    ;;
esac

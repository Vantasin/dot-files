# Lightweight helpers and optional tool integration.

mkcd() {
  [[ -n $1 ]] || return 1
  mkdir -p -- "$1" && cd -- "$1"
}

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

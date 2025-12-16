# Lightweight helpers and optional tool integration.

mkcd() {
  [[ -n $1 ]] || return 1
  mkdir -p -- "$1" && cd -- "$1"
}

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# Flush history to disk when leaving a shell or after each prompt.
autoload -Uz add-zsh-hook
_sync_history() { fc -AI }
add-zsh-hook precmd _sync_history
add-zsh-hook zshexit _sync_history

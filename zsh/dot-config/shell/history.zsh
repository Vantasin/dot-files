# Shared history for autosuggestions across sessions (XDG state).
export HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
mkdir -p "${HISTFILE:h}"

HISTSIZE=10000
SAVEHIST=10000

setopt \
  append_history \
  inc_append_history \
  share_history \
  hist_fcntl_lock \
  hist_ignore_dups \
  hist_ignore_all_dups \
  hist_reduce_blanks

# Keep autosuggestions reading from history.
export ZSH_AUTOSUGGEST_STRATEGY=(history)

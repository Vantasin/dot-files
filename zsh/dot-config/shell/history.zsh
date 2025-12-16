# History behavior tuned for autosuggestions and shared history.
setopt append_history
setopt share_history
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks

# Ensure autosuggestions pull from history file.
export ZSH_AUTOSUGGEST_STRATEGY=(history)

# Keybindings tuned for an Emacs-like experience.

bindkey -e
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
# bindkey '^R' history-incremental-search-backward
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

autoload -Uz edit-command-line
bindkey '^X^E' edit-command-line

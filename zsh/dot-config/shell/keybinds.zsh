# Keybindings tuned for an Emacs-like experience.

bindkey -e
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
# bindkey '^R' history-incremental-search-backward
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

autoload -Uz edit-command-line
bindkey '^X^E' edit-command-line

# fzf keybindings (Ctrl-R history search)
if [[ -o interactive ]] && command -v fzf >/dev/null 2>&1; then
  # macOS (Homebrew)
  if command -v brew >/dev/null 2>&1; then
    FZF_BREW_BINDINGS="$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
    [[ -r "$FZF_BREW_BINDINGS" ]] && source "$FZF_BREW_BINDINGS"
  fi

  # Debian / Ubuntu
  for f in \
    /usr/share/doc/fzf/examples/key-bindings.zsh \
    /usr/share/fzf/key-bindings.zsh \
    /etc/profile.d/fzf.zsh
  do
    [[ -r "$f" ]] && source "$f" && break
  done
fi

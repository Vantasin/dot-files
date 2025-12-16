# Environment and PATH helpers for interactive shells.
typeset -U path fpath

path=(
  "$HOME/.local/bin"
  "$HOME/bin"
  $path
)
if [[ -d /opt/homebrew/bin ]]; then
  path=(/opt/homebrew/bin /opt/homebrew/sbin $path)
fi
if [[ -d /usr/local/bin ]]; then
  path=(/usr/local/bin /usr/local/sbin $path)
fi
export PATH

if [[ -d /opt/homebrew/share/zsh/site-functions ]]; then
  fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
fi
if [[ -d /usr/local/share/zsh/site-functions ]]; then
  fpath=(/usr/local/share/zsh/site-functions $fpath)
fi

export LANG="${LANG:-en_US.UTF-8}"
export LESS="${LESS:--R -F -X}"
export LESSHISTFILE="${LESSHISTFILE:-${XDG_CACHE_HOME:-$HOME/.cache}/lesshst}"
export MANPAGER="${MANPAGER:-less -R}"

# Toggle prompt VCS info globally: set to 1/true/yes/on to hide, 0/empty to show.
export SKIP_VCS_INFO=1

# Common aliases with guards for optional tools.

alias ..='cd ..'
alias ...='cd ../..'

if command -v lsd >/dev/null 2>&1; then
  alias l='lsd -A'
#  alias ls='lsd'
  alias ll='lsd -lh'
  alias la='lsd -lha'
  alias lt='lsd --tree'
else
  alias ls='ls -F'
  alias ll='ls -alF'
  alias la='ls -A'
fi

alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'

command -v batcat >/dev/null 2>&1 && alias bat='batcat'

alias gs='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'

alias v='${EDITOR:-vi}'
alias tldr='tldr --color=always'

alias rangerz='ranger --choosedir=$HOME/.rangerdir; LASTDIR=$(cat $HOME/.rangerdir); z "$LASTDIR"'

# Minimal prompt with git branch awareness.

setopt prompt_subst

autoload -Uz add-zsh-hook colors vcs_info
colors

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%F{yellow}(%b%u%f%F{red}%m%f)%f'
zstyle ':vcs_info:git:*' actionformats '%F{yellow}(%b|%a%u%f%F{red}%m%f)%f'

_prompt_vcs_info() { vcs_info }
add-zsh-hook precmd _prompt_vcs_info

# Use prompt_subst so ${vcs_info_msg_0_} expands.
PROMPT="%F{cyan}%T%f %F{white}%n%f%F{magenta}@%f%F{white}%m%f %F{green}%~%f ${vcs_info_msg_0_} %F{yellow}%#%f "
RPROMPT=""

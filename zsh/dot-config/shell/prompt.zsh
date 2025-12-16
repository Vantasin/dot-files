# Minimal prompt with git branch awareness.

autoload -Uz add-zsh-hook colors vcs_info
colors

zstyle ':vcs_info:git:*' formats '%F{yellow}(%b)%f'
zstyle ':vcs_info:git:*' actionformats '%F{yellow}(%b|%a)%f'

_prompt_vcs_info() { vcs_info }
add-zsh-hook precmd _prompt_vcs_info

# Use prompt_subst so ${vcs_info_msg_0_} expands.
PROMPT="%F{cyan}%T%f %F{white}%n%f%F{magenta}@%f%F{white}%m%f %F{green}%~%f ${vcs_info_msg_0_}
%F{yellow}%#%f "
RPROMPT=""

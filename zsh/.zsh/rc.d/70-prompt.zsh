# zshrc - prompt
#
# note: prompt_subst and colors are loaded elsewhere

# colors
rs="%{%k%f%}"
safe_username="mel"      # this username will not appear in prompts
pathcolor="%{%F{024}%}"  # color of the path
usercolor="%{%F{160}%}"  # if a username is displayed, it is this color
sepcolor="%{%F{235}%}"   # color of '@' in 'user@host'
exitcolor="%{%F{196}%}"  # fg color for exit code if non-zero

case `hostname` in
    # workstations
    winterfell|anvil)
        hostcolor="%{%F{116}%}";;

    # hosts with public ips
    *ftp0?lx|*-bastion)
        hostcolor="%{%K{088}%F{231}%}";;

    *)
        hostcolor="%{%F{208}%}";;
esac


# ps1
userprompt=""
[[ `whoami` != $safe_username ]] && userprompt="${usercolor}%n${rs}${sepcolor}@${rs}"
hostprompt="${hostcolor}%m${rs}"
pathprompt="${pathcolor}%5(c:...:)%4c${rs}"

# vcs
# XXX make this cheaper
autoload -Uz vcs_info
autoload -U add-zsh-hook

prompt_precmd() { vcs_info }
add-zsh-hook precmd prompt_precmd

prompt_chpwd() { FORCE_RUN_VCS_INFO=1 }
add-zsh-hook chpwd prompt_chpwd

branchcolor="%{%F{030}%}"
sepcolor="%{%F{058}%}"
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%{%K{236}%}%{%F{046}%}┄%{%k%f%}'
zstyle ':vcs_info:*' unstagedstr '%{%K{236}%}%{%F{196}%}┄%{%k%f%}'
zstyle ':vcs_info:git*' formats "${branchcolor}%b${rs} %c%u"

PS1='${userprompt}${hostprompt} ${pathprompt} ${vcs_info_msg_0_} '


# ps2
PS2="%{%F{190}%}%_${rs} %{%F{004}%}>%{%F{025}%}>%{%F{033}%}>${rs} "


# rprompt
exitprompt="%(?..${exitcolor}%?)"

RPROMPT="${exitprompt}"

# zshrc - prompt

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

PS1="${userprompt}${hostprompt} ${pathprompt} "


# ps2
PS2="%{%F{190}%}%_${rs} %{%F{004}%}>%{%F{025}%}>%{%F{033}%}>${rs} "


# rprompt
exitprompt="%(?..${exitcolor}%?)"

RPROMPT="${exitprompt}"

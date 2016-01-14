# zshrc - prompt
#
# mel@thestack.co

# colors
rs="%{%k%f%}"
safe_username="mel"      # this username will not appear in prompts
pathcolor="%{%F{024}%}"  # color of the path
usercolor="%{%F{160}%}"  # if a username is displayed, it is this color
sepcolor="%{%F{235}%}"   # color of '@' in 'user@host'
exitcolor="%{%F{196}%}"  # fg color for exit code if non-zero

case `hostname` in
    # good/safe hosts
    eden|winterfell|jen)
        hostcolor="%{%K{000}%F{116}%}";;

    # hosts with public ips
    *ftp0?lx|*-bastion)
        hostcolor="%{%K{088}%F{231}%}";;

    # application nodes
    *web??lx|skulls|chuckles|flattop|hotshot|hiccup|blindspot)
        hostcolor="%{%K{018}%F{178}%}";;

    # topologically brittle hosts (spf etc)
    *hlb??lx|gumball|headcase|snaps|snitch|kingston|chopper)
        hostcolor="%{%K{196}%F{000}%}";;

    *)
        hostcolor="%{%K{130}%F{215}%}";;
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

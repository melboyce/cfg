# zshrc - prompt
#
# note: prompt_subst and colors are loaded elsewhere

# colors
rs="%{%k%f%}"
safe_username="mel"         # this username will not appear in prompts
pathcolor="%{%F{024}%}"     # color of the path
usercolor="%{%F{160}%}"     # if a username is displayed, it is this color
sepcolor="%{%F{235}%}"      # color of '@' in 'user@host'
exitcolor="%{%F{196}%}"     # fg color for exit code if non-zero
vcsiconcolor="%{%F{250}%}"  # vcs icon
branchcolor="%{%F{070}%}"   # vcs branch
stagedcolor="%{%F{023}%}"   # staged change icon
unstagedcolor="%{%F{023}%}" # unstaged change icon
repocolor="%{%F{025}%}"     # repo name
repopathcolor="%{%F{037}%}" # repo path

case $HOST in
    anvil)
        hostcolor="%{%F{116}%}";;

    rivet)
        hostcolor="%{%F{226}%}";;

    hammer)
        hostcolor="%{%F{201}%}";;

    *)
        hostcolor="%{%F{226}%}";;
esac


# user/host/path
userprompt=""
[[ `whoami` != $safe_username ]] && userprompt="${usercolor}%n${rs}${sepcolor}@${rs}"
hostprompt="${hostcolor}%m${rs}"
pathprompt="${pathcolor}%5(c:...:)%4c${rs}"


# vcs bits
stagedstr="${stagedcolor}  ${rs}"
unstagedstr="${unstagedcolor}  ${rs}"
zstyle ':vcs_info:*' disable bzr cdv darcs mtn p4 svk tla
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' stagedstr $stagedstr
zstyle ':vcs_info:*' unstagedstr $unstagedstr
zstyle ':vcs_info:git*' formats "${vcsiconcolor}  ${repocolor}%r${repopathcolor}/%S ${branchcolor}%b${rs}%c%u"


# precmd - only do vcs prompt work when needed
precmd() {
    vcs_info
    if [[ ! -n ${vcs_info_msg_0_} ]]; then
        PS1='${userprompt}${hostprompt} ${pathprompt} '
    else
        PS1='${vcs_info_msg_0_} '
    fi
}


# ps2
PS2="%{%F{190}%}%_${rs} %{%F{004}%}>%{%F{025}%}>%{%F{033}%}>${rs} "


# rprompt
exitprompt="%(?..${exitcolor}%?)"
RPROMPT="${exitprompt}"

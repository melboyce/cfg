# zshrc - prompt
#
# note: prompt_subst and colors are loaded elsewhere

prompt_icon_path="$HOME/.zsh/prompt-icon"

# colors
rs="%{%k%f%}"
safe_username="mel"              # does not appear in prompt
hostcolor="%{%F{167}%}"          # the color of the prompt-icon
pathcolor="%{%F{066}%}"          # color of the path
usercolor="%{%F{160}%}"          # color of username if displayed
sepcolor="%{%F{235}%}"           # color of '@' in 'user@host'
exitcolor="%{%K{232}%F{197}%}"   # color for exit code if non-zero
vcsiconcolor="%{%F{175}%}"       # vcs icon color
branchcolor="%{%K{237}%F{214}%}" # vcs branch color
stagedcolor="%{%F{142}%}"        # vcs staged change icon
unstagedcolor="%{%F{166}%}"      # vcs unstaged change icon
repocolor="%{%F{108}%}"          # vcs repo name
repopathcolor="%{%F{072}%}"      # vcs repo path

# "icons"
stagedicon=" "   # ready to commit
unstagedicon=" " # ready to add
vcsicon=" "      # in vcs directory
exiticon=" "     # for non-zero exit code RPROMPT


# user/host/path
userprompt=""
[[ $(whoami) != "$safe_username" ]] && userprompt="${usercolor}%n${rs}${sepcolor}@${rs}"
pathprompt="${pathcolor}%4(c:...:)%3c${rs}"


# vcs bits
stagedstr="$stagedcolor $stagedicon"
unstagedstr="$unstagedcolor $unstagedicon"
zstyle ':vcs_info:*' disable bzr cdv darcs mtn p4 svk tla
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' stagedstr "$stagedstr"
zstyle ':vcs_info:*' unstagedstr "$unstagedstr"
zstyle ':vcs_info:git*' formats "${vcsiconcolor}${vcsicon} ${repocolor}%r${repopathcolor}/%S ${branchcolor}%b%c%u${rs}"


# precmd - vcs replaces normal prompt
precmd() {
    vcs_info
    if [[ -n ${vcs_info_msg_0_} ]]; then
        PS1="${vcs_info_msg_0_} "
        return
    fi
    hostprompt="$hostcolor$(<"$prompt_icon_path")$rs"
    PS1="${userprompt}${hostprompt} ${pathprompt} "
}


# ps2 (here-doc)
PS2="%{%F{066}%}%_${rs} %{%F{106}%}>%{%F{112}%}>%{%F{118}%}>${rs} "


# rprompt
exitprompt="%(?..${exitcolor}${exiticon}%?)"
RPROMPT="${exitprompt}"

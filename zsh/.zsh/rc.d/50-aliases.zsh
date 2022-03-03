# zshrc - aliases

# TOP TEN
# print -l -- ${(o)history%% *} | uniq -c | sort -nr | head -n10
alias d=darcs
alias g=git
alias k=kak

# tree - http://mama.indstate.edu/users/ice/tree/
alias ldt="tree -pughCFd -L 1"
alias ldtr="tree -pughCFd"
alias lst="tree"

# regulars
alias dfl="df -hl --exclude tmpfs --exclude devtmpfs --total"
alias grep="grep -nH --color=auto"
alias h="history"
alias http="http --style monokai"
alias j="jobs"
alias killall="pkill"  # some killall implementations are violent
alias ls="ls -G"
alias ll="ls -lah"
alias psa="ps --forest -e --sort uid"
alias psc="ps xawf -eo pid,user,cgroup,args"
alias pse="ps -ef"
alias pt="pstree -lnG"
alias pta="pstree -lapG"
alias s="ssh -4"
alias watch="watch --color"

# void
alias xi="sudo xbps-install"
alias xq="sudo xbps-query"
alias svst="sudo sv status /var/service/*"

# aws
alias aws="aws --no-paginate"

# optionals
[[ -x /usr/bin/xstow ]] && alias stow="xstow"


# MISC
alias dr="docker"
alias hc="herbstclient"
alias fz="feh -Zd."

# zshrc - aliases

# SYSTEM ADMINISTRATION
# coreutils
alias cp="cp --strip-trailing-slashes"
alias mv="mv --strip-trailing-slashes"
alias tf="tail -f"

# tree - http://mama.indstate.edu/users/ice/tree/
alias ldt="tree -pughCFd -L 1"
alias ldtr="tree -pughCFd"
alias lst="tree"

alias dfl="df -hl --exclude tmpfs --exclude devtmpfs --total"
alias grep="grep -nH --color=auto"
alias h="history"
alias http="http --style monokai"
alias j="jobs"
alias killall="pkill"
alias ls="ls --color=auto --group-directories-first --classify --time-style='+%Y-%m-%d %H:%M' --human-readable -X"
alias ll="ls -la"
alias mt="multitail --follow-all"
alias psa="ps --forest -e --sort uid"
alias psc="ps xawf -eo pid,user,cgroup,args"
alias pse="ps -ef"
alias pt="pstree -lnG"
alias pta="pstree -lapG"
alias s="ssh -4"
alias watch="watch --color"

# devops tooling
alias sls="sudo salt"
alias trr="terraform"

# optionals
[[ -x /usr/bin/xstow ]] && alias stow="xstow"

# busybox
# TODO generalize this into a userland switch statement
if [[ ! `hash busybox 2>/dev/null` ]]; then
    alias ls="ls --color=auto -Xhe"
fi


# DISTRIBUTIONS
# void
alias xi="sudo xbps-install"
alias xq="sudo xbps-query"

# alpine
alias sapk="sudo apk"

# arch
alias spm="sudo pacman"

# systemd
alias sc="sudo systemctl"
alias jc="sudo journalctl"
alias jf="sudo journalctl -f"


# MISC
alias d="docker"
alias hc="herbstclient"
alias fz="feh -Zd."
alias label="paste -d ' ' <(sort -R ~/pub/corpora/color-list.text) <(sort -R ~/pub/corpora/animal-names.text) | head -n1 | tr '[A-Z]' '[a-z]' | toilet -f pagga | lolcat -a -s 400"


# VERSION CONTROL
alias ga="git add"
alias gs="git status --ignore-submodules"


# GLOBALS
alias -g A="|ag"
alias -g AW="|awk"
alias -g C="|wc -l"
alias -g G="|grep"
alias -g H="|head"
alias -g L="|lolcat"
alias -g P="|$PAGER"
alias -g Q="&> /dev/null"
alias -g S="|sort"
alias -g SPR="|curl -F 'sprunge=<-' http://sprunge.us"
alias -g T="|tail"
alias -g TL="|toilet"
alias -g VL="/var/log/"
alias -g VLE=/var/log/everything.log
alias -g X="|xargs"

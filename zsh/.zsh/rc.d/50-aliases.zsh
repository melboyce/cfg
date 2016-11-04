# zshrc - aliases

# SYSTEM ADMINISTRATION
# misc
alias dfl="df -hl --exclude tmpfs --exclude devtmpfs --total"
alias dtr="tree -CFd"
alias dt="tree -pugsh --dirsfirst -L 1"
alias grep="grep -nH --color=auto"
alias h="history"
alias http="http --style monokai"
alias j="jobs"
alias killall="pkill"
alias ls="ls --color=auto --group-directories-first --classify --time-style='+%Y-%m-%d %H:%M' --human-readable -X"
alias ll="ls -la"
alias mt="multitail --follow-all"
alias nv="nvim"
alias psa="ps --forest -e --sort uid"
alias psc="ps xawf -eo pid,user,cgroup,args"
alias pse="ps -ef"
alias pt="pstree -lnG"
alias pta="pstree -lapG"
alias s="ssh -4"
alias sls="sudo salt"
alias tf="tail -f"
alias tree="tree -CF"
alias watch="watch --color"

# optionals
[[ -x /usr/bin/xstow ]] && alias stow="xstow"



# DISTRIBUTIONS
# void
alias xi="sudo xbps-install"
alias xq="sudo xbps-query"

# arch
alias spm="sudo pacman"

# systemd
alias sc="sudo systemctl"
alias jc="sudo journalctl"
alias jf="sudo journalctl -f"


# MISC
alias hc="herbstclient"
alias fz="feh -Zd."


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

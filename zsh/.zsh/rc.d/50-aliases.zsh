# zshrc - aliases

# SYSTEM ADMINISTRATION
alias dfl="df -hl --exclude tmpfs --exclude devtmpfs --total"
alias dh="dirs -v"
alias dt="tree -CFd"
alias f="free -m"
alias g="grep -nH --color=auto"
alias h="history"
alias http="http --style monokai"
alias j="jobs"
alias killall="pkill"  # just in case i'm on a "real" unix
alias l.="ls -d .[^.]*"
alias ll="ls -la"
alias ls="ls --color=auto --group-directories-first --classify --time-style='+%Y-%m-%d %H:%M' --human-readable -X"
alias lt="tree -pugsh --dirsfirst -L 1"
alias mt="multitail --follow-all"
alias psa="ps --forest -e --sort uid"
alias psc="ps xawf -eo pid,user,cgroup,args"
alias pse="ps -ef"
alias pstree="pstree -G"
alias s="ssh -4"
alias sls="sudo salt"
alias tf="tail -f"
alias tree="tree -CF"
alias w="wget"
alias watch="watch --color"
# distro-specific
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

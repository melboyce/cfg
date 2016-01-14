# zshrc - aliases
#
# mel@thestack.co

# commands
alias dfl="df -hl --exclude tmpfs --exclude devtmpfs --total"
alias dh="dirs -v"
alias dt="tree -CFd"
alias g="grep -nH --color=auto"
alias h="history"
alias hc="herbstclient"
alias http="http --style monokai"
alias j="jobs"
alias killall="pkill"  # just in case i'm on a "real" unix
alias l.="ls -d .[^.]*"
alias ll="ls -la"
alias ls="ls --color=auto --group-directories-first --classify --time-style='+%Y-%m-%d %H:%M' --human-readable -X"
alias psa="ps --forest -e --sort uid"
alias psc="ps xawf -eo pid,user,cgroup,args"
alias pse="ps -ef"
alias pstree="pstree -A"
alias s="ssh -4"
alias sls="salt"
alias spm="pacman"
alias tf="tail -f"
alias tree="tree -CF"
alias vs="vim -S ~/.vim/sessions/"
alias watch="watch --color"
alias xzd="xz -d"
alias z="zsh -ex"
alias f="feh -Zd."

# systemd
alias cg="systemd-cgls --no-pager"
alias jc="journalctl --no-pager"
alias jf="journalctl -fa --no-pager"
alias lc="loginctl --no-pager"
alias sc="systemctl --no-pager"
alias scdr="systemctl --system daemon-reload"

# sudo aliases
if (( EUID > 0 )); then
    alias lc="sudo loginctl --no-pager"
    alias sc="sudo systemctl --no-pager"
    alias scdr="sudo systemctl --system daemon-reload"
    alias sls="sudo salt"
    alias spm="sudo pacman"
fi

# globals
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
alias -g VLNA=/var/log/nginx/access.log
alias -g VLNE=/var/log/nginx/error.log
alias -g X="|xargs"

# suffixes
alias -s com=dwb
alias -s html=dwb
alias -s org=dwb

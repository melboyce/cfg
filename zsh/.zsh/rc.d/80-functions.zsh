# zshrc - functions

pull() {
    if [[ -d .hg ]]; then
        hg pull && hg up
    elif [[ -d .git ]]; then
        git pull
    else
        echo "nup"
    fi
}
push() {
    if [[ -d .hg ]]; then
        hg push
    elif [[ -d .git ]]; then
        git push
    else
        echo "nup"
    fi
}
zman() { PAGER="less -g -s '+/^       "$1"'" man zshall }
px() { ps uwwp ${$(pgrep -d, "${(j:|:)@}"):?no matches} }
hl() { egrep --color=always -e '' -e${^*} }
mkcd() { mkdir -p "$1" && cd "$1" }
compdef mkcd=mkdir  # completions work like mkdir
pstop() { ps -eo pid,user,pri,ni,vsz,rsz,stat,pcpu,pmem,time,comm --sort -pcpu | head -11 }
stowcfg() { pushd /home/mel/cfg; xstow -i sys */; popd }

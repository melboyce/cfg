# zshrc - functions

px() { ps uwwp ${$(pgrep -d, "${(j:|:)@}"):?no matches}; }
pstop() { ps -eo pid,user,pri,ni,vsz,rsz,stat,pcpu,pmem,time,comm --sort -pcpu | head -11; }

mkcd() { mkdir -p "$1" && cd "$1"; }
compdef mkcd=mkdir  # completions work like mkdir

gdac() {
    [[ -e "$1" ]] || { echo "gdac <file>"; return; }
    git diff "$1"
    read -rq ?"commit? " || return
    git add "$1"
    git commit
}

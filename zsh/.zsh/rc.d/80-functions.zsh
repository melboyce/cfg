# zshrc - functions

px() { ps uwwp ${$(pgrep -d, "${(j:|:)@}"):?no matches} }
pstop() { ps -eo pid,user,pri,ni,vsz,rsz,stat,pcpu,pmem,time,comm --sort -pcpu | head -11 }

mkcd() { mkdir -p "$1" && cd "$1" }
compdef mkcd=mkdir  # completions work like mkdir

# version control functions
gc() { git commit -m "$@" && git push }
gs() { git stauts }

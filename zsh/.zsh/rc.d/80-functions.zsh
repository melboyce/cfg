# zshrc - functions

px() { ps uwwp ${$(pgrep -d, "${(j:|:)@}"):?no matches} }
pstop() { ps -eo pid,user,pri,ni,vsz,rsz,stat,pcpu,pmem,time,comm --sort -pcpu | head -11 }

mkcd() { mkdir -p "$1" && cd "$1" }
compdef mkcd=mkdir  # completions work like mkdir

# version control functions
gc() { git commit -m "$@" && git push }
pull() {
	if [[ -d .git ]]; then
		git pull
	elif [[ -d .hg ]]; then
		hg pull
	else
		echo "nup"
	fi
}
push() {
	if [[ -d .git ]]; then
		git push
	elif [[ -d .hg ]]; then
		hg push
	else
		echo "nup"
	fi
}

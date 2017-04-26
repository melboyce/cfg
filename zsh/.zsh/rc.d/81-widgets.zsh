# zshrc - widgets

# store a command line in history without executing
commit-to-history() {
	print -s ${(z)BUFFER}
	zle send-break
}
zle -N commit-to-history
bindkey "^\n" commit-to-history

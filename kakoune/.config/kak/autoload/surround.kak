# surround.kak

def surround-selection %{
	prompt surround-char> X %{ %sh{
		case "$kak_reg_X" in
			\")     ls='"'; rs='"';;
			\')     ls="'"; rs="'";;
			\(|\))  ls="("; rs=")";;
			\[|\])  ls="["; rs="]";;
			\<|\>)  ls="<"; rs=">";;
			*)      ls=""; rs="";;
		esac
		echo "exec i${ls}<esc>a${rs}<esc>"
	}}
}
map global normal <c-s> ':surround-selection<ret>'

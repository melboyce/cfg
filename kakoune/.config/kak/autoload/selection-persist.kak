# selection-persist.kak

# TODO remove previous position before appending to dbfile

def save-selection %{ %sh{
	echo "`date +%s`\t$kak_buffile\t$kak_selections_desc" >> $HOME/.kakdb
}}
def restore-selection %{ %sh{
	if [ -f "$kak_buffile" ]; then
		sel=`ag $kak_buffile $HOME/.kakdb | tail -1 | cut -f3`
		[ -n "$sel" ] && echo "eval select $sel"
	fi
}}
hook global BufWritePre .* %{ save-selection }
map global normal <c-r> ':restore-selection<ret>'

# selection-persist.kak

# originally adapted from: https://github.com/kurkale6ka/kakoune-extra/blob/master/kakrc

# requires `sponge` from `moreutils`

# consider adding something like these to your kakrc:
# hook global BufWritePre .* %{ save-selection }
# map global normal <c-r> ':restore-selection<ret>'

decl str selectiondb %sh{ printf '%s/.local/share/kak/selection.db' "${HOME}" }

def save-selection %{ %sh{
	grep -v "$kak_buffile" "$kak_opt_selectiondb" | sponge "$kak_opt_selectiondb"
	echo "$kak_buffile\t$kak_selections_desc" >> "$kak_opt_selectiondb"
}}
def restore-selection %{ %sh{
	if [ -f "$kak_buffile" ]; then
		sel=`ag $kak_buffile $kak_opt_selectiondb | tail -1 | cut -f2`
		[ -n "$sel" ] && printf '%s\n' "eval select $sel"
	fi
}}
hook global KakBegin .* %{ %sh{ mkdir -p `dirname "$kak_opt_selectiondb"` }}

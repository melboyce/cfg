# godlv.kak

# consider adding something like these to your kakrc:
# map global normal <c-b> ':godlv-break-here<ret>'

decl str godlvinit %sh{ printf '%s/.local/share/kak/godlv' "$HOME" }

def godlv-break-here %{ %sh{
    printf 'break %s:%s\n' "$kak_buffile" "$kak_cursor_line" >> "$kak_opt_godlvinit"
}}

def godlv-clear-breaks %{ %sh{
    printf '' >"$kak_opt_godlvinit"
}}

hook global KakBegin .* %{ %sh{ mkdir -p `dirname "$kak_opt_godlvinit" 2>/dev/null` }}

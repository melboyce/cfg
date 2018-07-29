hook global BufCreate .*[.](awk) %{
    set-option buffer filetype awk
}

add-highlighter shared/awk regions
add-highlighter shared/awk/string  region '"' '"' fill string
add-highlighter shared/awk/comment region '#' '$' fill comment

add-highlighter shared/awk/code default-region group
add-highlighter shared/awk/code/operator regex [-=+<>&*|] 0:operator
add-highlighter shared/awk/code/pattern regex ^/.+/ 0:variable
add-highlighter shared/awk/code/ident regex \b(BEGIN|END)\b 0:variable
add-highlighter shared/awk/code/statement regex \b(if|else|while|for|do|while|print|printf|delete|exit|break|continue|next|nextfile|return)\b 0:identifier
add-highlighter shared/awk/code/function regex \b(length|rand|srand|int|substr|index|match|split|sub|gsub|sprintf|system|tolower|toupper)\b 0:keyword
add-highlighter shared/awk/code/value regex \$\d+ 0:value
add-highlighter shared/awk/code/variable regex \b(CONVFMT|FS|NF|NR|FNR|FILENAME|RS|OFS|ORS|OFMT|SUBSEP|ARGC|ARGV|ENVIRON)\b 0:type

hook -group awk-highlight global WinSetOption filetype=awk %{ add-highlighter window/awk ref awk }
hook -group awk-highlight global WinSetOption filetype=(?!awk).* %{ remove-highlighter window/awk }

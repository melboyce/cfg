# terraform.io

hook global BufCreate .*\.tf %{
    set buffer filetype tf
}

add-highlighter -group / regions -default code tf \
    string '"' \" '' \
    comment '//' $ ''

add-highlighter -group /tf/string fill string
add-highlighter -group /tf/comment fill comment
add-highlighter -group /tf/code regex \$.*\} 0:attribute

%sh{
    # grammar
    keywords="provider|resource"
    types="command"
    values="true|false|yes|no"
    functions="lookup|ceil"

    # highlighters
    printf %s "
        add-highlighter -group /tf/code regex \b(${keywords})\b 0:keyword
        add-highlighter -group /tf/code regex \b(${types})\b 0:type
        add-highlighter -group /tf/code regex \b(${values})\b 0:value
        add-highlighter -group /tf/code regex \b(${functions})\b 0:function
    "
}

hook -group tf-highlight global WinSetOption filetype=tf %{ add-highlighter ref tf }
hook -group tf-highlight global WinSetOption filetype=(?!tf).* %{ remove-highlighter tf }

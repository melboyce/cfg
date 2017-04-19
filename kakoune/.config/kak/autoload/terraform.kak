# https://terraform.io/
# Shameless copy of the golang syntax file (rc/base/go.kak)
# Super basic, but it works for me(tm)

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*\.tf %{
    set buffer filetype tf
}

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter -group / regions -default code tf \
    back_string '`' '`' '' \
    double_string '"' (?<!\\)(\\\\)*" '' \
    single_string "'" (?<!\\)(\\\\)*' '' \
    comment /\* \*/ '' \
    comment '//' $ '' \
    comment '#' $ ''

add-highlighter -group /tf/back_string fill string
add-highlighter -group /tf/double_string fill string
add-highlighter -group /tf/single_string fill string
add-highlighter -group /tf/comment fill comment

add-highlighter -group /tf/code regex %{-?([0-9]*\.(?!0[xX]))?\b([0-9]+|0[xX][0-9a-fA-F]+)\.?([eE][+-]?[0-9]+)?i?\b} 0:value

%sh{
    # Grammar
    keywords="connection|output|provider|variable|data|terraform"
    types="bool"
    values="false|true|on|off|yes|no"
    functions="resource|provisioner|module"

    # Add the language's grammar to the static completion list
    printf %s\\n "hook global WinSetOption filetype=tf %{
        set window static_words '${keywords}:${attributes}:${types}:${values}:${functions}'
    }" | sed 's,|,:,g'

    # Highlight keywords
    printf %s "
        add-highlighter -group /tf/code regex \b(${keywords})\b 0:keyword
        add-highlighter -group /tf/code regex \b(${attributes})\b 0:attribute
        add-highlighter -group /tf/code regex \b(${types})\b 0:type
        add-highlighter -group /tf/code regex \b(${values})\b 0:value
        add-highlighter -group /tf/code regex \b(${functions})\b 0:builtin
    "
}

# Commands
# ‾‾‾‾‾‾‾‾

def -hidden tf-indent-on-new-line %~
    eval -draft -itersel %=
        # preserve previous line indent
        try %{ exec -draft \;K<a-&> }
        # indent after lines ending with { or (
        try %[ exec -draft k<a-x> <a-k> [{(]\h*$ <ret> j<a-gt> ]
        # cleanup trailing white spaces on the previous line
        try %{ exec -draft k<a-x> s \h+$ <ret>d }
        # align to opening paren of previous line
        try %{ exec -draft [( <a-k> \`\([^\n]+\n[^\n]*\n?\' <ret> s \`\(\h*.|.\' <ret> '<a-;>' & }
        # copy // comments prefix
        try %{ exec -draft \;<c-s>k<a-x> s ^\h*\K/{2,} <ret> y<c-o><c-o>P<esc> }
    =
~

def -hidden tf-indent-on-opening-curly-brace %[
    # align indent with opening paren when { is entered on a new line after the closing paren
    try %[ exec -draft -itersel h<a-F>)M <a-k> \`\(.*\)\h*\n\h*\{\' <ret> s \`|.\' <ret> 1<a-&> ]
]

def -hidden tf-indent-on-closing-curly-brace %[
    # align to opening curly brace when alone on a line
    try %[ exec -itersel -draft <a-h><a-k>^\h+\}$<ret>hms\`|.\'<ret>1<a-&> ]
]

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook -group tf-highlight global WinSetOption filetype=tf %{ add-highlighter ref tf }

hook global WinSetOption filetype=tf %{
    # cleanup trailing whitespaces when exiting insert mode
    hook window InsertEnd .* -group tf-hooks %{ try %{ exec -draft <a-x>s^\h+$<ret>d } }
    hook window InsertChar \n -group tf-indent tf-indent-on-new-line
    hook window InsertChar \{ -group tf-indent tf-indent-on-opening-curly-brace
    hook window InsertChar \} -group tf-indent tf-indent-on-closing-curly-brace
}

hook -group tf-highlight global WinSetOption filetype=(?!tf).* %{ remove-highlighter tf }

hook global WinSetOption filetype=(?!tf).* %{
    remove-hooks window tf-hooks
    remove-hooks window tf-indent
}

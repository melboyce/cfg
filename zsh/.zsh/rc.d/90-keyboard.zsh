# zshrc - keyboard

autoload zkbd
typeset -g -A key

key[F1]='^[[11~'
key[F2]='^[[12~'
key[F3]='^[[13~'
key[F4]='^[[14~'
key[F5]='^[[15~'
key[F6]='^[[17~'
key[F7]='^[[18~'
key[F8]='^[[19~'
key[F9]='^[[20~'
key[F10]='^[[21~'
key[F11]='^[[23~'
key[F12]='^[[24~'
key[Backspace]='^?'
key[Insert]='^[[2~'
key[Home]='^[[7~'
key[PageUp]='^[[5~'
key[Delete]='^[[3~'
key[End]='^[[8~'
key[PageDown]='^[[6~'
key[Up]='^[[A'
key[Left]='^[[D'
key[Down]='^[[B'
key[Right]='^[[C'
key[Menu]=''''

[[ -n ${key[Left]}      ]] && bindkey "${key[Left]}"      backward-char
[[ -n ${key[Right]}     ]] && bindkey "${key[Right]}"     forward-char
[[ -n ${key[Up]}        ]] && bindkey "${key[Up]}"        up-line-or-history
[[ -n ${key[Down]}      ]] && bindkey "${key[Down]}"      down-line-or-history
[[ -n ${key[Home]}      ]] && bindkey "${key[Home]}"      beginning-of-line
[[ -n ${key[End]}       ]] && bindkey "${key[End]}"       end-of-line
[[ -n ${key[PageUp]}    ]] && bindkey "${key[PageUp]}"    history-beginning-search-backward
[[ -n ${key[PageDown]}  ]] && bindkey "${key[PageDown]}"  history-beginning-search-forward
[[ -n ${key[Delete]}    ]] && bindkey "${key[Delete]}"    delete-char
[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char

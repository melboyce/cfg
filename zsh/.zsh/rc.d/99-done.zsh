# zshrc - done

f=$(fortune -s)
hash toilet 2>/dev/null && toilet -f future -S --gay <<<$f
echo $f; echo

[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && {
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
}

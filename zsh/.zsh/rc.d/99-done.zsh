# zshrc - done

f=$(fortune -s)
hash toilet 2>/dev/null && toilet -f future -S --gay <<<$f
echo $f; echo

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

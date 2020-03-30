# zshrc - done

if hash toilet 2>/dev/null; then
    fortune -a | toilet -f future -S --gay
else
    fortune -a
fi
echo

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

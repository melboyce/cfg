# zshrc - done

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if (( $+commands[toilet] )); then
    fortune -a | toilet -f term --metal | lolcat
else
    fortune -a
fi

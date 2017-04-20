alias ls="ls -GFh"
alias mv="mv"
alias cp="cp"

function trrg() {
    terraform graph | dot -Tsvg | convert - plan.png && qlmanage -p plan.png 2>/dev/null
}

if [[ "`uname`" == "Darwin" ]]; then
    alias ls="ls -GFh"
    alias mv="mv"
    alias cp="cp"

    function trrg() {
        terraform graph | dot -Tsvg | convert - plan.png && qlmanage -p plan.png 2>/dev/null
    }
fi

function mygc() {
    [[ "$1" == "" ]] && { echo "$0 repo-slug"; return 64; }
    git clone "git@github.com:MYOB-Technology/$1"
}

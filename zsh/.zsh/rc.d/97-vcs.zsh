# zshrc - vcs stuff
function is_repo() {
    [[ -d .git ]] && echo "git"
    [[ -d .hg ]] && echo "hg"
    [[ `git rev-parse --git-dir 2>/dev/null` ]] && echo "git"
    echo "no"
}
function pull() {
    case "`is_repo`" in
        git)  git pull;;
        hg)   hg pull;;
        *)    echo "nop";;
    esac
}
function push() {
    case "`is_repo`" in
        git)  git push;;
        hg)   hg push;;
        *)    echo "nop";;
    esac
}

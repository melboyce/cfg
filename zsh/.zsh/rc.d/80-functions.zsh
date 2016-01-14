# zshrc - functions
#
# mel@thestack.co

archnews() {
    echo -e "$(echo $(curl --silent https://www.archlinux.org/feeds/news/ | awk ' NR == 1 {while ($0 !~ /<\/item>/) {print;getline} sub(/<\/item>.*/,"</item>") ;print}' | sed -e ':a;N;$!ba;s/\n/ /g') | \
        sed -e 's/&amp;/\&/g
        s/&lt;\|&#60;/</g
        s/&gt;\|&#62;/>/g
        s/<\/a>/£/g
        s/href\=\"/§/g
        s/<title>/\\n\\n\\n   :: \\e[01;31m/g; s/<\/title>/\\e[00m ::\\n/g
        s/<link>/ [ \\e[01;36m/g; s/<\/link>/\\e[00m ]/g
        s/<description>/\\n\\n\\e[00;37m/g; s/<\/description>/\\e[00m\\n\\n/g
        s/<p\( [^>]*\)\?>\|<br\s*\/\?>/\n/g
        s/<b\( [^>]*\)\?>\|<strong\( [^>]*\)\?>/\\e[01;30m/g; s/<\/b>\|<\/strong>/\\e[00;37m/g
        s/<i\( [^>]*\)\?>\|<em\( [^>]*\)\?>/\\e[41;37m/g; s/<\/i>\|<\/em>/\\e[00;37m/g
        s/<u\( [^>]*\)\?>/\\e[4;37m/g; s/<\/u>/\\e[00;37m/g
        s/<code\( [^>]*\)\?>/\\e[00m/g; s/<\/code>/\\e[00;37m/g
        s/<a[^§|t]*§\([^\"]*\)\"[^>]*>\([^£]*\)[^£]*£/\\e[01;31m\2\\e[00;37m \\e[01;34m[\\e[00;37m \\e[04m\1\\e[00;37m\\e[01;34m ]\\e[00;37m/g
        s/<li\( [^>]*\)\?>/\n \\e[01;34m*\\e[00;37m /g
        s/<!\[CDATA\[\|\]\]>//g
        s/\|>\s*<//g
        s/ *<[^>]\+> */ /g
        s/[<>£§]//g')\n\n";
}
pull() {
    if [[ -d .hg ]]; then
        hg pull && hg up
    elif [[ -d .git ]]; then
        git pull
    else
        echo "nup"
    fi
}
push() {
    if [[ -d .hg ]]; then
        hg push
    elif [[ -d .git ]]; then
        git push
    else
        echo "nup"
    fi
}
zman() { PAGER="less -g -s '+/^       "$1"'" man zshall }
px() { ps uwwp ${$(pgrep -d, "${(j:|:)@}"):?no matches} }
hl() { egrep --color=always -e '' -e${^*} }
mkcd() { mkdir -p "$1" && cd "$1" }
compdef mkcd=mkdir  # completions work like mkdir
pstop() { ps -eo pid,user,pri,ni,vsz,rsz,stat,pcpu,pmem,time,comm --sort -pcpu | head -11 }

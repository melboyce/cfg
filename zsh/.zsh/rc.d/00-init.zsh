# zshrc - core
#
# mel@thestack.co

hostname=`hostname`
cachedir=~/.cache/zsh
mkdir -p $cachedir

bindkey -e  # e=emacs v=vi
umask 022


# turn off flow control
stty start undef
stty stop undef


# shell parameters
DIRSTACKSIZE=9          # how many entries in the dirstack
HISTFILE=~/.histfile    # where to store history
HISTSIZE=100000         # number of items stored in the internal history list
LISTMAX=0               # ask for completions only if list will scroll
MAILCHECK=0             # don't check for mail
REPORTTIME=10           # show execution report on processes that take over 10s
SAVEHIST=$HISTSIZE      # number of history events to save in HISTFILE
TMPPREFIX="$TMP"        # where to put temporary files
WATCH="notme"           # watch for logins from 'notme'
WATCHFMT="%D %T %b%n%b %a %l from %m"


# dir stack persistence
DIRSTACKFILE=$cachedir/dirstack
if [[ -f $DIRSTACKFILE ]]; then
    dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
    [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi
chpwd() {
    print -l $PWD ${(u)dirstack} >| $DIRSTACKFILE
}

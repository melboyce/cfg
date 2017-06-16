# zshrc for a root account
# github.com/weirdtales/cfg

# no autocomplete extras,
# -i on file mutation commands
# no persistent hist or dirstacks etc
# bright ps1 in the format root@host:pwd
# designed to be a bit raw and uncomfortable

umask 002
mkdir -p /root/tmp
bindkey -e  # e=emacs v=vi
stty -ixon  # no flow-control

# params
TMP=/root/tmp
DIRSTACKSIZE=0
HISTFILE=
HISTSIZE=100
REPORTMEMORY=128
REPORTTIME=30
SAVEHIST=0
TMPPREFIX=$TMP
WATCH="all"
WATCHFMT="%D %T %b%n%b %a %l from %m"

# exports
export PATH="/sbin:/bin:/usr/sbin:/usr/bin"
export MANPATH="/usr/share/man"
export TMP="$TMP"
export TEMP="$TMP"
export TMPDIR="$TMP"
export EDITOR="vim"
export PAGER="less"

# options
setopt no_list_beep
setopt list_types
setopt bad_pattern
setopt no_glob_dots
setopt nonomatch
setopt hist_ignore_all_dups
setopt no_clobber
setopt no_flow_control  # yes, doubly so
setopt long_list_jobs
setopt notify
setopt prompt_percent
setopt prompt_subst
setopt pipe_fail
setopt beep

# modules
autoload -U colors zsh/terminfo
colors
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
autoload -U select-word-style
select-word-style bash
autoload run-help
autoload -Uz compinit
compinit

# aliases
alias cp="cp -i"
alias mv="mv -i"
alias tf="tail -f"
alias h="history"
alias j="jobs"
alias killall="pkill"
alias ls="ls --color=auto"
alias ll="ls -la"
alias s="ssh -4"

# prompt
PS1='%{%F{196}%}%n%{%F{237}%}@%{%F{190}%}%m%{%F{237}%}:%{%F{039}%}%/%{%k%f%} '

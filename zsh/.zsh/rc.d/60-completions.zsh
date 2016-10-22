# zshrc - completions
#
# note: add 'HashKnownHosts no' to .ssh/config

# load completions
autoload -U compinit
zmodload zsh/complist
compinit -d $cachedir/zcompdump

_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1
}

zstyle ':completion:::::' completer _force_rehash _complete
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*' cache-path $cachedir
zstyle ':completion:*' use-cache on
zstyle ':completion:*' force-list always
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*:man:*' menu yes select
zstyle ':completion:*:default' list-colors 'di=1;34'

zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:*:*:processes' command "ps a -o pid,user,comm,command -w -w"
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:kill:*' menu yes select
zstyle ':completion:*:kill:*:processes' list-colors "=(#b) #([0-9]#) #([a-z]#)*=37=31=33"

# ssh known hosts
local knownhosts
knownhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
zstyle ':completion:*:(ssh|scp|sftp):*' hosts $knownhosts

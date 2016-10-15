# zshrc - exports
#
# mel@thestack.co

TMP=$HOME/tmp
mkdir -p $TMP

export BROWSER="/usr/bin/qutebrowser"
export EDITOR="nvim"
export GREP_COLOR='31'
export MANPATH="$MANPATH:$HOME/man"
export MOST_EDITOR="nvim %s +%d"
export PAGER=most
export PATH="$PATH:$HOME/bin"
export PS_FORMAT="pid,user,group,nice,pri,psr,ppid,start,rss,stat,command"
export S_COLORS="always"
export SUDO_EDITOR="rvim"  # no shell commands, no suspend
export TEMP="$TMP"
export TMP="$TMP"
export TMPDIR="$TMP"
export TZ="Australia/Melbourne"
export VISUAL="nvim"

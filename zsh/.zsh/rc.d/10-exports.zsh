# zshrc - exports

# paths
export PATH="$PATH:$HOME/bin"
export MANPATH="/usr/share/man:/usr/local/share/man:/usr/local/man"
export TMP="$HOME/tmp"
export TEMP="$TMP"
export TMPDIR="$TMP"

# program associations
export EDITOR="kak"
export MOST_EDITOR="kak %s +%d"
export SUDO_EDITOR="nvim -Z"  # no shell commands, no suspend (not sure if neovim disables suspend)
export VISUAL="kak"
export BROWSER="/usr/bin/chromium"
[[ $(xdpyinfo 2>/dev/null) ]] || export BROWSER="/usr/bin/lynx"

# program options
export GREP_COLOR=31
export PAGER="most"
export PS_FORMAT="pid,user,group,nice,pri,psr,ppid,start,rss,stat,command"
export S_COLORS="always"

# l10n
export TZ="Australia/Melbourne"
export TIMEZONE=$TZ

# coreutils
export VERSION_CONTROL="off"
export BLOCK_SIZE="human-readable"

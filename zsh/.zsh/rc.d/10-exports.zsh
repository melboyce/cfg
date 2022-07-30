# zshrc - exports

# paths
export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/Library/Python/3.10/bin:$HOME/.rd/bin"
export MANPATH="/opt/local/share/man:/usr/share/man:/usr/local/share/man:/usr/local/man"
export TMP="$HOME/tmp"
export TEMP="$TMP"
export TMPDIR="$TMP"
export TMPPREFIX="$TMP/"

# program associations
export EDITOR=kak
export MOST_EDITOR="kak %s +%d"
export VISUAL=kak
export BROWSER=open

# program options
export GREP_COLOR=31
export PAGER=most
export PS_FORMAT=pid,user,group,nice,pri,psr,ppid,start,rss,stat,command
export S_COLORS=always

# l10n
export TZ=Australia/Melbourne
export TIMEZONE="$TZ"

# coreutils
export VERSION_CONTROL=off
export BLOCK_SIZE=human-readable

# gpg - added for pinentry-curses
GPG_TTY=$(tty)
export GPG_TTY

# xdg
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_RUNTIME_DIR="$HOME/run"
export XDG_TEMPLATES_DIR="$HOME/tpl"
export XDG_VIDEOS_DIR="$HOME/Videos"


# local exports
# shellcheck disable=SC1090
[[ -f "$HOME/.exports" ]] && source "$HOME/.exports"

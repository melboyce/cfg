# zshrc - exports

# paths
export PATH="$PATH:$HOME/bin"
export MANPATH="/usr/share/man:/usr/local/share/man:/usr/local/man"
export TMP="$HOME/tmp"
export TEMP="$TMP"
export TMPDIR="$TMP"
export TMPPREFIX="$TMP/"

# program associations
export EDITOR="kak"
export MOST_EDITOR="kak %s +%d"
export SUDO_EDITOR="nvim -Z"  # no shell commands, no suspend (not sure if neovim disables suspend)
export VISUAL="kak"
export BROWSER="/usr/bin/firefox"
xdpyinfo >/dev/null 2>&1 || export BROWSER="/usr/bin/lynx"

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

# horseshit
export XDG_DESKTOP_DIR="$HOME"
export XDG_DOWNLOAD_DIR="$HOME/d"
export XDG_DOCUMENTS_DIR="$HOME/doc"
export XDG_MUSIC_DIR="$HOME/music"
export XDG_PICTURES_DIR="$HOME/i"
export XDG_PUBLICSHARE_DIR="$HOME/pub"
export XDG_TEMPLATES_DIR="$HOME/tmpl"
export XDG_VIDEOS_DIR="$HOME/vid"


# local exports
# shellcheck disable=SC1090
[[ -f "$HOME/.exports" ]] && source "$HOME/.exports"

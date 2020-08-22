# zshrc - exports

# paths
export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
export MANPATH="/usr/share/man:/usr/local/share/man:/usr/local/man"
export TMP="$HOME/tmp"
export TEMP="$TMP"
export TMPDIR="$TMP"
export TMPPREFIX="$TMP/"

# program associations
export EDITOR=kak
export TERMINAL=alacritty
export MOST_EDITOR="kak %s +%d"
export SUDO_EDITOR="nvim -Z"  # no shell commands, no suspend (not sure if neovim disables suspend)
export VISUAL=kak
export BROWSER=/usr/bin/firefox
xdpyinfo >/dev/null 2>&1 || export BROWSER="/usr/bin/lynx"

# program options
export GREP_COLOR=31
export PAGER=most
export PS_FORMAT=pid,user,group,nice,pri,psr,ppid,start,rss,stat,command
export S_COLORS=always
export NNN_USE_EDITOR=1
export HUBR_DEFAULT_ORG=myob-ops
export PIPE_BRANCH=main

# l10n
export TZ=Australia/Melbourne
export TIMEZONE="$TZ"

# coreutils
export VERSION_CONTROL=off
export BLOCK_SIZE=human-readable

# horseshit
export XDG_DESKTOP_DIR="$HOME"
export XDG_DOWNLOAD_DIR="$HOME/d"
export XDG_DOCUMENTS_DIR="$HOME/w"
export XDG_MUSIC_DIR="$HOME/m"
export XDG_PICTURES_DIR="$HOME/i"
export XDG_TEMPLATES_DIR="$HOME/x"
export XDG_VIDEOS_DIR="$HOME/v"

# wayland
export XDG_RUNTIME_DIR="$HOME/run"


# local exports
# shellcheck disable=SC1090
[[ -f "$HOME/.exports" ]] && source "$HOME/.exports"

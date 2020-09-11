#!/bin/bash


# fonts
xset +fp /usr/share/fonts/artwiz-fonts
xset +fp $HOME/.fonts
xset fp rehash


# xset
xset r rate 200 50  # keyboard rate
xset -b             # disable BEEP


# resources and keyboard
xmodmap $HOME/.Xmodmap
xbindkeys
xrdb -load $HOME/.Xresources


# daemons etc
numlockx &
xautolock -time 10 -locker slock &
$HOME/bin/pointer-setup 2>/dev/null


# compositor
hash picom 2>/dev/null && picom -b


# start the terminal multiplexer
herbstluftwm

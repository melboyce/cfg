#!/bin/bash

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi


# fonts
xset +fp /usr/share/fonts/local
xset +fp /usr/share/fonts/artwiz-fonts
xset +fp $HOME/.fonts
xset fp rehash


# x config
xset r rate 200 50  # keyboard rate
xset -b             # disable BEEP
xmodmap $HOME/.Xmodmap
xbindkeys
xrdb -load $HOME/.Xresources


# daemons etc
numlockx &
xautolock -time 10 -locker slock &
urxvtd -o -f
rofi -key-run F12 -font "PragmataPro 8" -fg "#505050" -bg "#000000" -hlfg "#ffb964" -hlbg "#000000" -location 0 -separator-style solid -width 20 -lines 5 -hide-scrollbar &


# xinput crap
# pointer_id=`xinput list | egrep 'slave.+pointer' | grep -vi 'xtest' | cut -d= -f2 | awk '{ print $1 }'`
# ns_prop_id=`xinput list-props 12 | grep -i natural | grep -vi default | cut -d\( -f2 | cut -d\) -f1`
# xinput set-prop $pointer_id $ns_prop_id 1
xinput | egrep 'slave\s+pointer' | grep -vi xtest | while read line; do
  devid="`echo ${line##*=}|cut -f1`"
  propid=`xinput list-props $devid | grep 'libinput Natural Scrolling Enabled (' | cut -d\( -f2 | cut -d\) -f1`
  [[ "$propid" != "" ]] && xinput set-prop $devid $propid 1
done


# misc
mkdir -p $HOME/.cache/dmenu_run 2>/dev/null


dbus-launch --exit-with-session herbstluftwm

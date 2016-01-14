#!/bin/bash

set -f

monitor=${1:-0}
height=16
padding_top=0
padding_bottom=0
padding_left=0
padding_right=$padding_left
bottom=0
font="-*-smoothansi-medium-*-*-*-13-*-*-*-*-*-*-*"

geometry=( `herbstclient monitor_rect $monitor` )
x=${geometry[0]}
y=${geometry[1]}
((bottom)) && y=$((${geometry[1]}+${geometry[3]}-height))
width="${geometry[2]}"

x=$((x + padding_left))
width=$((width - padding_left - padding_right))
y=$((y + padding_top))

function uniq_linebuffered() {
    exec awk '$0 != l { print ; l=$0 ; fflush(); }' "$@"
}

update_pad() {
    ((bottom)) && herbstclient pad $monitor 0 0 "$1" \
               || herbstclient pad $monitor "$1"
}

activecolor="#9fbc00"
emphbg="#303030"

update_pad $((height + padding_top + padding_bottom))

{
    child+=" $!"
    while true; do
        date +$'date\t%M'
        sleep 2 || break
    done > >(uniq_linebuffered) &
    child+=" $!"
    herbstclient --idle
    kill $child
}|{
    tags=( `herbstclient tag_status $monitor` )
    date=""

    while true; do
        IFS=$'\t' read -ra cmd || break
        case "${cmd[0]}" in
            tag*)
                tags=( `herbstclient tag_status $monitor` )
                ;;
            focus_changed|window_title_changed)
                windowtitle="${cmd[@]:2}"
                ;;
            date)
                date=`date +'%Y-%m-%d'`
                hhmm=`date +'%H:%M'`
                ;;
            quit_panel)
                exit 0
                ;;
            *)
                ;;
        esac

        echo -n "%{l}%{A4:next:}%{A5:prev:}"

        for i in "${tags[@]}"; do
            occupied=true
            focused=false
            here=false
            urgent=false
            visible=true
            case ${i:0:1} in
                '.')
                    occupied=false
                    visible=false
                    ;;
                '#')
                    focused=true
                    here=true
                    ;;
                '%') focused=true;;
                '+') here=true;;
                '!') urgent=true;;
                ':') visible=false;;
            esac

            output=""
            $here     && output+="%{B#303030}" || output+="%{B-}"
            $visible  && output+="%{+o}" || output+="%{-o}"
            $occupied && output+="%{F-}" || output+="%{F#707070}"
            $urgent   && output+="%{B#ee3030}%{-o}"
            $focused  && output+="%{F#eeeeee}%{U#9fbc00}" || output+="%{U#454545}"
            output+="%{A1:use_${i:1}:} ${i:1} %{A}"
            echo -n "$output"
        done
        echo -n "%{A}%{A}%{F-}%{B-}%{-o}"
        [[ -n "$windowtitle" ]] \
            && echo -n "%{c}%{F#707070}${windowtitle:0:50}" \
            || echo -n "%{c} "
        echo -n "%{r}%{-o}%{F#707070} $date %{F#f0f0f0}$hhmm "
        echo "%{F-}%{B-}%{-o}%{-u}"
    done
} | ~/bin/lemonbar -d \
    -g "`printf '%dx%d%+d%+d' $width $height $x $y`" \
    -u 2 -f "$font" -B "#121212" | while read line; do
        case "$line" in
            use_*) herbstclient chain , focus_monitor "$monitor" , use "${line#use_}";;
            next)  herbstclient chain , focus_monitor "$monitor" , use_index +1 --skip-visible;;
            prev)  herbstclient chain , focus_monitor "$monitor" , use_index -1 --skip-visible;;
        esac
    done

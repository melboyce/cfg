#!/bin/bash

set -f

monitor=${1:-0}
height=16
padding_top=0
padding_bottom=0
padding_left=0
padding_right=$padding_left
bottom=0
font="PragmataPro:size=10"

geometry=( `herbstclient monitor_rect $monitor` )
x=${geometry[0]}
y=${geometry[1]}
((bottom)) && y=$((${geometry[1]}+${geometry[3]}-height))
realwidth="${geometry[2]}"

x=$((x + padding_left))
width=$((realwidth - padding_left - padding_right))
y=$((y + padding_top))

xgeom="${width}x${height}+$x+$y"

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

                # battery
                if [[ -x $HOME/bin/bat.sh ]]; then
                    batlev=`$HOME/bin/bat.sh`
                    batcol="#48e"
                    baticon="\uf059"  # question
                    if ((batlev>=0 && batlev<=10)); then
                        baticon="\uf244"; batcol="#e44"  # empty
                    elif ((batlev>=11 && batlev<=39)); then
                        baticon="\uf243"  # batt 1/3
                    elif ((batlev>=40 && batlev<=59)); then 
                        baticon="\uf242"  # batt 1/2
                    elif ((batlev>=60 && batlev<=79)); then
                        baticon="\uf241"  # batt 2/3
                    else
                        baticon="\uf240"  # batt full
                    fi
                    [[ "`cat /sys/class/power_supply/BAT0/status`" == "Charging" ]] && { baticon="\uf0e7$baticon"; batcol="#2a4"; }
                fi

                # wifi
                lqcol="#399"
                linkicon="\uf1eb"
                linkname="`(iwgetid -r)`"
                if [[ "$linkname" == "" ]]; then
                    lqcol="#a55"
                    linkqual="d/c"
                else
                    linkqual="`iwconfig 2>/dev/null | grep 'Link Q' | awk '{print $2}' | cut -d= -f2`"
                fi
                ;;
            quit_panel)
                exit 0
                ;;
            *)
                ;;
        esac

        output=""
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

            tagname="${i:1}"
            tagicon="$tagname"
            [[ "$tagname" == "w" ]] && tagicon="\uf0c2"
            [[ "$tagname" == "gimp" ]] && tagicon="\uf1fc"

            $here     && output+="%{B#333}" || output+="%{B-}"
            #$visible  && output+="%{F-}" || output+=""
            $occupied && output+="%{F-}" || output+="%{F#555}"
            $urgent   && output+="%{B#a33}" || output+="%{B-}%{-u}"
            $focused  && output+="%{B#560}%{U#ef2}%{+u}" || output+="%{B-}%{-u}"
            output+="%{A:herbstclient use $tagname:} $tagicon %{A}"
        done
        output+="%{F-}%{B-}%{-u}"

        output+="%{c}%{F#38c}$xxx%{F-}"

        output+="%{r}%{B-}%{F$lqcol}$linkicon $linkname $linkqual "
        output+="%{F#000}...%{F$batcol}$baticon $batlev "
        output+="%{F#000}...%{F#888}\uf017 $date %{F#EF2}${hhmm} "
        output+="%{F#822}%{A:slock:}\uf023%{A}"

        echo -e "$output"
    done
} | lemonbar -a 15 -f "$font" -f "Font Awesome" -u2 | bash

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
                    batcol="#138700"
                    [[ "$batlev" -lt "21" ]] && batcol="#933"
                    baticon="·"
                    [[ "`cat /sys/class/power_supply/BAT0/status`" == "Charging" ]] && baticon="⚡"
                fi

                # wifi
                lqcol="#399"
                linkicon="☢"
                linkname="`(iwgetid -r)`"
                if [[ "$linkname" == "" ]]; then
                    lqcol="#555"
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

            $here     && output+="^bg(#333)" || output+="^bg()"
            #$visible  && output+="^fg()" || output+=""
            $occupied && output+="^fg()" || output+="^fg(#555)"
            $urgent   && output+="^bg(#e33)"
            $focused  && output+="^bg(yellow)^fg(#111)" || output+=""
                output+=" $tagname "
            done
        output+="^fg()^bg()"

        dtw=`textwidth "$font" "x $linkname $linkqual x x $batlev x x $date $hhmm xxxxxxx"`
        pleft=$(( $realwidth - $dtw ))
        output+="^pa($pleft)"
        output+="^bg()^fg($lqcol)$linkicon $linkname $linkqual "
        output+="^fg(#333)· ^fg($batcol)$baticon $batlev "
        output+="^fg(#333)· ^fg(#777)÷ $date ^fg(yellow)${hhmm} "

        echo $output
    done
} | dzen2 -xs $(( $monitor + 1 )) -h $height -w $width -fn "$font"

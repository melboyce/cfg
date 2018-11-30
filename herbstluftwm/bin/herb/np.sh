#!/bin/bash

# herbstluft panel
# requires: lemonbar bc iwgetid iwconfig github.com/weirdtales/hostess
#
# TODO:
# - multihead

# control vars
font="PragmataPro:style=Regular:size=13"

col_bg="#222"
col_fg="#aaa"
col_tag="#5aa"
col_tag_active="#d28"
col_tag_urgent="#d28"
col_icon="#9e0"
col_icon_2="#5be"
col_icon_3="#e09"
col_data="#ed3"
col_dull="#555"

# tag icons
icon_tag="\uf22d"
icon_empty_tag="\uf107"
icon_focused="\uf005"
icon_focused_om="\uf006"
icon_urgent="\uf0f3"
icon_term="\uf120"
icon_web="\uf0c2"
icon_book="\uf02d"
icon_misc="\ue29b"
icon_sys="\uf0e4"

# widget icons
icon_date="\uf017"
icon_wifi="\uf1eb"
icon_wifi_down="\uf132"
icon_batt="\uf059"
icon_batt_chg="\uf0e7"
icon_temp="\uf29c"
icon_load="\uf0a0"

ui_sep="%{F${col_bg}}..%{F-}"
u_height=6  # underline height

monitor=${1:-0}
[[ $monitor -gt 0 ]] && { echo "no multihead :("; exit 1; }
herbstclient pad "$monitor" 30
fifo="/tmp/panel.fifo"


# scaffolding
[[ -e $fifo ]] && rm $fifo
mkfifo $fifo


# herbstluft events
herbstclient --idle >$fifo &


# system telemetry polling
"$GOPATH/bin/hostess" >$fifo &


# bar
tags=( $(herbstclient tag_status "$monitor" 2>/dev/null) )
while true; do
    IFS=$'\t' read -ra event || break
    case "${event[0]}" in
        quit_panel)    exit 0;;
        #focus_changed) { client_id="${event[1]}"; client_title="${event[2]}"; };;

        tag*)  tags=( $(herbstclient tag_status "$monitor" 2>/dev/null) );;
        date)  { date_ymd="${event[1]}"; date_hms="${event[2]}"; };;
        batt)  { batt_pc="${event[1]}"; batt_idx="${event[2]}"; batt_chg="${event[3]}"; };;
        wifi)  { wifi_ssid="${event[1]}"; wifi_pc="${event[2]}"; };;
        temp)  { temp_val="${event[1]}"; temp_idx="${event[2]}"; };;
        load)  { load_avg="${event[1]}"; };;
        alrt)  { alrt="${event[1]}"; };;
        *)     ;;
    esac

    # tags
    o_tags=""
    for i in "${tags[@]}"; do
        tagname="${i:1}"
        o_tags+="%{F${col_tag}}"
        empty=false; focused=false; thismonitor=false; othermonitor=false; urgent=false;
        case "${i:0:1}" in
            '.') empty=true;;
            ':') empty=false;;
            '+') thismonitor=true; focused=false;;
            '#') thismonitor=true; focused=true;;
            '-') othermonitor=true; focused=false;;
            '%') othermonitor=true; focused=true;;
            '!') urgent=true;;
        esac
        tagicon="$icon_empty_tag"
        $empty || tagicon="$icon_tag"
        case "$tagname" in
            t?) { tagicon="$icon_term"; tagtext="PROG"; };;
            w)  { tagicon="$icon_web"; tagtext="NETW";  };;
            b)  { tagicon="$icon_book"; tagtext="BOOK"; };;
            m)  { tagicon="$icon_misc"; tagtext="MISC"; };;
            s)  { tagicon="$icon_sys"; tagtext="SYS ";  };;
        esac
        $thismonitor && $focused && {
            o_tags+="%{B${col_tag_active}}%{F#fff} $tagtext"
        }
        $othermonitor && $focused && {
            o_tags+="%{B${col_tag}}%{F#fff} $tagtext"
        }
        $urgent && { o_tags+="%{F${col_tag_urgent}}"; tagicon="$icon_urgent"; }
        o_tags+="%{A:herbstclient use $tagname:} $tagicon %{B-}%{F-}%{-u}%{A}"
    done

    # wifi
    o_wifi="%{F${col_icon}}$icon_wifi %{F-}$wifi_pc%"
    [[ "$wifi_ssid" == "-" ]] && o_wifi="%{F${col_dull}}$icon_wifi_down %{F-}"

    # load
    o_load="%{F${col_icon}}$icon_load %{F-}$load_avg"

    # temp
    o_temp=""
    case "$temp_idx" in
        "0") icon_temp="\uf2cb";;
        "1") icon_temp="\uf2ca";;
        "2") icon_temp="\uf2c9";;
        "3") icon_temp="\uf2c8";;
        "4") icon_temp="\uf2c7";;
    esac
    [[ "$temp_idx" == "4" ]] && o_temp+="%{F${col_tag_urgent}}" || o_temp+="%{F${col_icon}}"
    o_temp+="$icon_temp %{F-}$temp_val°C"

    # battery
    o_batt=""
    case "$batt_idx" in
        "1") icon_batt="\uf244";;
        "2") icon_batt="\uf243";;
        "3") icon_batt="\uf242";;
        "4") icon_batt="\uf241";;
        "5") icon_batt="\uf240";;
    esac
    [[ "$batt_chg" -eq "1" ]] && o_batt+="%{F${col_data}}$icon_batt_chg "
    o_batt+="%{F${col_icon}}$icon_batt %{F-}$batt_pc%"

    # datetime
    o_date="%{F${col_icon}}$icon_date %{F-}"
    o_date+="$date_ymd%{F${col_data}} $date_hms"

    # alrt
    o_alrt="%{F-}%{B-}${alrt}%{F-}%{B-}"

    # locker
    o_lock="%{A:slock:}%{F${col_dull}}\uf023%{F-}%{A}"

    # packs
    o_left="${o_tags}"
    o_cent="${o_alrt}"
    o_right="${o_load}${ui_sep}${o_temp}${ui_sep}${o_batt}${ui_sep}${o_wifi}${ui_sep}${o_date} ${o_lock}"

    echo -e "%{l}$o_left%{c}$o_cent%{r}$o_right"
done <$fifo 2>/dev/null | lemonbar -a 20 -f "$font" -f "Font Awesome 5 Free:size=13" -u "$u_height" -B "$col_bg" -F "$col_fg" | bash

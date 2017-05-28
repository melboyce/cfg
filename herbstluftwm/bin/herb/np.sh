#!/bin/bash

# herbstluft panel
# requires: lemonbar bc iwgetid iwconfig

# control vars
font="PragmataPro:style=Regular:size=12"

col_bg="#222"
col_fg="#aaa"
col_tag="#5aa"
col_tag_active="#d28"
col_tag_urgent="#d28"
col_icon="#9e0"
col_data="#ed3"
u_height=6  # underline height

monitor=${1:-0}
bar_geom="x30++"  # [width]x[height]+[x]+[y]
herbstclient pad $monitor 30
battpath="/sys/class/power_supply/BAT0"
temppath="/sys/class/thermal/thermal_zone7"
fifo="/tmp/panel.fifo"
timeout=5


# scaffolding
cmd=$(basename "$0")
[[ $(pgrep -cx "$cmd") -gt 1 ]] && pkill -o "$cmd"
[[ -e $fifo ]] && rm $fifo
mkfifo $fifo


# datetime
while true; do
    printf "date\t%s\t%s\n" "$(date +'%Y-%m-%d')" "$(date +'%H:%M')"
    sleep $((timeout * 6))
done >$fifo &


# battery
while true; do
    [[ -e $battpath ]] || break
    batt_cf=$(cat $battpath/charge_full)
    batt_cn=$(cat $battpath/charge_now)
    batt_pc=$(echo "$batt_cn * 100 / $batt_cf" | bc)
    case $batt_pc in
         [0-9]|1[0-9])     batt_idx="0";;
        2[0-9]|3[0-9])     batt_idx="1";;
        4[0-9]|5[0-9])     batt_idx="2";;
        6[0-9]|7[0-9])     batt_idx="3";;
        8[0-9]|9[0-9]|100) batt_idx="4";;
        *)                 batt_idx="?";;
    esac
    batt_chg="0"
    [[ "$(cat $battpath/status)" == "Charging" ]] && batt_chg="1"
    printf "batt\t%s\t%s\t%s\n" "$batt_pc" "$batt_idx" "$batt_chg"
    sleep $((timeout * 2))
done >$fifo &


# temp
while true; do
    [[ -e $temppath ]] || break
    temp_val=$(echo $(cat $temppath/temp) "/1000" | bc)
    printf "temp\t%s\n" "$temp_val"
    sleep $((timeout * 1))
done >$fifo &


# wifi
while true; do
    hash iwgetid 2>/dev/null || { sleep $((timeout * 1024)); continue; }
    wifi_ssid="$(iwgetid -r 2>/dev/null)"
    if [[ "$wifi_ssid" == "" ]]; then
        printf "wifi\t%s\t%s\t%s\n" "-" "0" "0"
        sleep $((timeout * 2))
        continue
    fi
    wifi_pc=$(echo "scale=2;" "$(iwconfig 2>/dev/null | grep 'Link Q' | awk '{print $2}' | cut -d= -f2)" "*100" | bc)
    wifi_pc=$(printf %.f "$wifi_pc")
    case $wifi_pc in
         [0-9]|1[0-9])     wifi_idx="0";;
        2[0-9]|3[0-9])     wifi_idx="1";;
        4[0-9]|5[0-9])     wifi_idx="2";;
        6[0-9]|7[0-9])     wifi_idx="3";;
        8[0-9]|9[0-9]|100) wifi_idx="4";;
        *)                 wifi_idx="?";;
    esac
    printf "wifi\t%s\t%s\t%s\n" "$wifi_ssid" "$wifi_pc" "$wifi_idx"
    sleep $((timeout * 2))
done >$fifo &


# herbstluft
herbstclient --idle >$fifo &


# bar
tags=( $(herbstclient tag_status "$monitor" 2>/dev/null) )
date_ymd="$(date +'%Y-%m-%d')"; date_hms="$(date +'%H:%M')"
while true; do
    IFS=$'\t' read -ra event || break
    case "${event[0]}" in
        quit_panel)    exit 0;;
        focus_changed) { client_id="${event[1]}"; client_title="${event[2]}"; };;

        tag*)  tags=( $(herbstclient tag_status "$monitor" 2>/dev/null) );;
        date)  { date_ymd="${event[1]}"; date_hms="${event[2]}"; };;
        batt)  { batt_pc="${event[1]}"; batt_idx="${event[2]}"; batt_chg="${event[3]}"; };;
        wifi)  { wifi_ssid="${event[1]}"; wifi_pc="${event[2]}"; wifi_idx="${event[3]}"; };;
        temp)  { temp_val="${event[1]}"; };;
        *)     ;;
    esac

    # client icon
    if [[ "$client_id" != "" ]]; then
        client_name=$(xprop -id $client_id WM_CLASS|awk '{print $4}'|tr -d \"|tr 'A-Z' 'a-z')
    fi
    case "$client_name" in
        st-*)             client_icon="\uf120";;
        mupdf)            client_icon="\uf02d";;
        kakoune|nano|vim) client_icon="\uf0c7";;
        *)                client_icon="\uf1b2";;
    esac

    # tags
    o_tags=""
    for i in "${tags[@]}"; do
        o_tags+="%{F${col_tag}}"
        occupied=true; focused=false; here=false; urgent=false; visible=true
        case "${i:0:1}" in
            '.') occupied=false; visible=false;;
            '#') focused=true; here=true;;
            '%') focused=true;;
            '+') here=true;;
            '!') urgent=true;;
            ':') visible=false;;
        esac
        tagname="${i:1}"
        tagicon="\uf22d"
        $here     && o_tags+=""
        $occupied && { o_tags+=""; tagicon="\uf08a"; }
        $urgent   && { o_tags+="%{F${col_tag_urgent}}"; tagicon="\uf0f3"; }
        $focused  && { o_tags+="%{F${col_tag_active}}%{U${col_tag_active}}%{+u}"; tagicon="$client_icon"; }
        [[ "$tagname" == "w" ]]    && tagicon="\uf0c2"
        [[ "$tagname" == "gimp" ]] && tagicon="\uf1fc"
        o_tags+="%{A:herbstclient use $tagname:} $tagicon %{A}%{B-}%{F-}%{-u}"
    done

    o_right=""
    o_left=""

    # wifi
    wifi_icon="\uf1eb"
    [[ "$wifi_idx" -gt "0" ]] && o_left+="%{F${col_icon}}" || o_left+="%{F-}"
    o_left+="$wifi_icon %{F-}$wifi_ssid "
    [[ "$wifi_ssid" != "-" ]] && o_left+="%{F${col_data}}$wifi_pc%"
    o_left+="%{F${col_bg}}. "

    # temp
    temp_icon="\uf2c9"
    o_right+="%{F${col_icon}}$temp_icon "
    o_right+="%{F-}$temp_val°C"
    o_right+="%{F${col_bg}}. "

    # battery
    batt_icon="\uf059"
    case "$batt_idx" in
        "0") batt_icon="\uf244";;
        "1") batt_icon="\uf243";;
        "2") batt_icon="\uf242";;
        "3") batt_icon="\uf241";;
        "4") batt_icon="\uf240";;
        "?"|*) batt_icon="\uf059";;
    esac
    [[ "$batt_chg" -eq "1" ]] && o_right+="%{F${col_icon}}\uf0e7 "
    o_right+="%{F${col_icon}}$batt_icon %{F-}$batt_pc%"
    o_right+="%{F${col_bg}}. "

    # datetime
    o_right+="%{F${col_icon}}\uf017"
    o_right+="%{F-} $date_ymd%{F${col_data}} $date_hms"
    o_right+="%{B-}%{F-}"

    echo -e "%{l} $o_left%{c}$o_tags%{r}$o_right "
done <$fifo 2>/dev/null | lemonbar -g "$bar_geom" -f "$font" -f "Font Awesome" -u "$u_height" -B "$col_bg" -F "$col_fg" | bash

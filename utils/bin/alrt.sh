#!/bin/bash

fail() {
	echo "FAIL: $*"
	exit 1
}
usage() {
	echo "usage: $0 msg"
	exit
}

fifo=/tmp/panel.fifo
[[ $# -gt 0 ]] || usage
[[ -p $fifo ]] || fail "no fifo => $fifo"

(
	echo -e "alrt\t%{F#dee} \uf0f3  %{F#5be}$1 " >>$fifo
	sleep 10
	echo -e "alrt\t" >>$fifo
) &

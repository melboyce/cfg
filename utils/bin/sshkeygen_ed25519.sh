#!/usr/bin/zsh
die() { echo $*; exit; }
[[ $# == 1 ]] || die "usage: $0 keypath"
ssh-keygen -o -a100 -t ed25519 -f $1
echo -e "\n!! CHECK THE PERNS !!\n"
ls -la ${1}*
echo -e "\n!! CHECK THE PERMS !!"

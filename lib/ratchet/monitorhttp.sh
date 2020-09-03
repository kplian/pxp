#!/bin/bash
dir="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
command1="cd $dir"
if curl -I "https://vouz.me" 2>&1 | grep -w "200\|301" ; then
    echo "vouz.me is up"
else
    echo "vouz.me is down"
    eval $command1
    sh whatsapp.sh	
fi

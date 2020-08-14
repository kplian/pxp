#!/bin/bash
# This file should have excution permissions
# You can add to crontab like this to execute every minute:
# * * * * * /var/www/html/pxp/pxp/lib/ratchet/monitor.sh

dir="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
command1="cd $dir"
command2="nohup php73 pxp-Server.php > nohup.out 2>&1 &"
#command="mkdir $dir/test"
if pgrep -f "pxp-Server.php" >/dev/null 2>&1 ; then
    echo "websocket is running"
    echo $command
    #eval $command
else
    echo "websocket is not running"
    echo $command1
    eval $command1
    echo $command2
    eval $command2
    echo "websocket started"
fi

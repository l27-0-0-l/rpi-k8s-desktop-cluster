#!/bin/bash

script=$1
LOG_CMD=${2:-cat}
KEY=$HOME/.ssh/rpik8_rsa
ALL="rpi3-1 rpi4-1 rpi4-2 rpi4-3"

for node in $ALL ; do
    echo =========== $node
    if [ "cat" != "$LOG_CMD" ] ; then
        LOG_EXEC="tee $LOG_CMD.$node"
    else
        LOG_EXEC="cat"
    fi

    if [ -e "$script" ] ; then 
        scp -i $KEY -l pi $script $node:
        ssh -i $KEY -l pi $node ./$script | $LOG_EXEC
    else
        ssh -i $KEY -l pi $node "$script" | $LOG_EXEC
    fi
done



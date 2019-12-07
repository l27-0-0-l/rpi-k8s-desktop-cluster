#!/bin/bash

script=$1
KEY=.ssh/rpik8_rsa
ALL="rpi3-1 rpi4-1 rpi4-2 rpi4-3"
for node in $ALL ; do
   scp -i $KEY -l pi $script $node:
   ssh -i $KEY -l pi $node ./$script
done



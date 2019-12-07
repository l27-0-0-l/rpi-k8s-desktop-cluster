#!/bin/bash

NAMESPACES=$(kubectl get namespaces -o jsonpath="{.items[*].metadata.name}")

NAMESPACED_TRUE=$(kubectl api-resources --namespaced=true --verbs=get | grep -v ^NAME | awk '{print $1}')
NAMESPACED_FALSE=$(kubectl api-resources --namespaced=false --verbs=get | grep -v ^NAME | awk '{print $1}')

echo NAMESPACED $NAMESPACED_TRUE
echo SOLO $NAMESPACED_FALSE

DATE=$(date +%Y-%m-%d_%H-%M-%s)
mkdir DUMP_KUBE_$DATE
cd DUMP_KUBE_$DATE

for i in $NAMESPACED_FALSE ; do 
    kubectl get $i > $i.txt
done

for i in $NAMESPACES ; do
    mkdir $i
    ( cd $i
        for j in $NAMESPACED_TRUE ; do
            kubectl -n $i get $j > $j.txt
         done
    )
done


#!/bin/bash

if [ -z "$1" ] ; then
   kubectl config get-contexts
   exit 1
fi

CTX_ARG=${1:-}
CONTEXT=" --context $CTX_ARG "
NAMESPACES=$(kubectl $CONTEXT get namespaces -o jsonpath="{.items[*].metadata.name}")

NAMESPACED_TRUE=$(kubectl $CONTEXT api-resources --namespaced=true --verbs=get | grep -v ^NAME | awk '{print $1}' | sort | uniq)
NAMESPACED_FALSE=$(kubectl $CONTEXT api-resources --namespaced=false --verbs=get | grep -v ^NAME | awk '{print $1}' | sort | uniq)

DATE=$(date +%Y-%m-%d_%H-%M-%S)
mkdir "DUMP_KUBE_${CTX_ARG}_$DATE"
cd "DUMP_KUBE_${CTX_ARG}_$DATE"

for j in $NAMESPACED_FALSE ; do
    kubectl $CONTEXT get "$j" > "$j.txt" 2> /dev/null
    if [ ! -s "$j.txt" ] ; then
        rm -f "$j.txt"
    else
        kubectl $CONTEXT get "$j" -o yaml > "$j.yaml" 2> /dev/null
        if [ "events" != "$j" ] ; then
            OBJECTS=$(cat "$j.txt"|grep -v ^NAME|awk '{print $1}')
            mkdir "$j"
            cd "$j"
            for k in $OBJECTS ; do 
                kubectl $CONTEXT get "$j" "$k" -o yaml > "$j.$k.yaml" 2> /dev/null
            done
            cd ..
            ls "$j" > "$j.lst"
        fi
    fi
done

mkdir _NAMESPACES
cd _NAMESPACES
for i in $NAMESPACES ; do
    mkdir "$i"
    cd "$i"
        for j in $NAMESPACED_TRUE ; do
            kubectl $CONTEXT -n "$i" get "$j" > "$j.txt" 2> /dev/null
            if [ ! -s "$j.txt" ] ; then
                rm -f "$j.txt"
            else
                kubectl $CONTEXT -n "$i" get "$j" -o yaml > "$j.yaml" 2> /dev/null
                if [ "events" != "$j" ] ; then
                    OBJECTS=$(cat "$j.txt"|grep -v ^NAME|awk '{print $1}')
                    mkdir "$j"
                    cd "$j"
                    for k in $OBJECTS ; do 
                        kubectl $CONTEXT -n "$i" get "$j" "$k" -o yaml > "$j.$k.yaml" 2> /dev/null
                    done
                    cd ..
                    ls "$j" > "$j.lst"
                fi
 
            fi
         done
    cd ..
    ls "$i" > "$i.lst"
done

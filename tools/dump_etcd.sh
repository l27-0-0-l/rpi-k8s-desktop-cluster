#!/bin/bash

if [ -z "$1" ] ; then
   kubectl config get-contexts
   exit 1
fi

CTX_ARG=${1:-}
CONTEXT=" --context $CTX_ARG "
DATE=$(date +%Y-%m-%d_%H-%M-%S)
mkdir DUMP_ETCD_${CTX_ARG}_$DATE
cd DUMP_ETCD_${CTX_ARG}_$DATE

kubectl $CONTEXT -n kube-system exec -it etcd-rpi3-0 -- /bin/sh -c 'ETCDCTL_API=3 etcdctl --endpoints https://127.0.0.1:2379 --cacert /etc/kubernetes/pki/etcd/ca.crt --key /etc/kubernetes/pki/etcd/server.key --cert /etc/kubernetes/pki/etcd/server.crt get "" --prefix=true -w json'  > etcd_dump.json

cat etcd_dump.json | jq -r .kvs[].key  > keys

for i in $(cat keys) ; do echo -n $i|base64 -d ; echo ; done > dump_all

TOTAL=$(cat etcd_dump.json | jq .count)
CNT=0
DUMP="$PWD/etcd_dump.json"
mkdir CONTENT
cd CONTENT
while [ $CNT -lt $TOTAL ] ; do
   KEY=$(cat "$DUMP" | jq -r ".kvs[$CNT].key"|base64 --decode)
   mkdir -p ".$KEY"
   cat "$DUMP" | jq -r ".kvs[$CNT].key" | base64 --decode > ".$KEY"/key
   cat "$DUMP" | jq -r ".kvs[$CNT].value" | base64 --decode > ".$KEY"/value
   echo $CNT > ".$KEY"/num
   mkdir -p BYCNT
   cd BYCNT
   mkdir $CNT
   cd $CNT
   cat "$DUMP" | jq -r ".kvs[$CNT].key" | base64 --decode > key 
   cat "$DUMP" | jq -r ".kvs[$CNT].value" | base64 --decode > value
   FILETYPE=$(file -b value)
   if [ "$FILETYPE" == "JSON data" ] ; then
       cp value json_value
   fi
   cd ..
   cd ..
   CNT=$((CNT+1))
done

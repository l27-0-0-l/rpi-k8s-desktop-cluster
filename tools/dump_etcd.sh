#!/bin/bash

DATE=$(date +%Y-%m-%d_%H-%M-%s)
mkdir DUMP_ETCD_$DATE
cd DUMP_ETCD_$DATE

kubectl -n kube-system exec -it etcd-rpi3-0 -- /bin/sh -c 'ETCDCTL_API=3 etcdctl --endpoints https://127.0.0.1:2379 --cacert /etc/kubernetes/pki/etcd/ca.crt --key /etc/kubernetes/pki/etcd/server.key --cert /etc/kubernetes/pki/etcd/server.crt get "" --prefix=true -w json'  > etcd_dump.json

cat etcd_dump.json | jq -r .kvs[].key  > keys

for i in $(cat keys) ; do echo -n $i|base64 -d ; echo ; done > dump_all

#!/bin/bash
NAME=multipass-demo
IMAGE=18.04
CPU=2
MEM=3G
DISK=10G

## unset any proxy env vars
unset PROXY HTTP_PROXY HTTPS_PROXY http_proxy https_proxy

## launch multipass
multipass launch $IMAGE --name $NAME --cpus $CPU --mem $MEM --disk $DISK --cloud-init ./cloud-init.yaml
sleep 10

## mount current dir into the multipass instance
multipass mount . $NAME:/root/$NAME

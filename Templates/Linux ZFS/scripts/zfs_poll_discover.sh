#!/usr/bin/env bash
declare -a pools
n=0
for i in $(sudo zpool list -H -o name); do
  pools[$n]="$i"
  let "n= $n + 1"
done
length=${#pools[@]}
let "last= $length - 1"
for (( i=0; i<${length}; i++ ))
do
    case $i in
	$last)
            POOL="{\"{#ZFSPOOL}\":\"${pools[$i]}\"}"
	;;
	*)
            POOL="{\"{#ZFSPOOL}\":\"${pools[$i]}\"},"
	;;
    esac
    POOLALL="$POOLALL""$POOL"
done
echo "{\"data\":["$POOLALL"]}"


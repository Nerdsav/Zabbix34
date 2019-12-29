#!/usr/bin/env bash
################################################
declare -a datasets
n=0
for i in $(sudo zfs list -H -o name | grep '/'); do
  datasets[$n]="$i"
  let "n= $n + 1"
done
length=${#datasets[@]}
let "last= $length - 1"
for (( i=0; i<${length}; i++ ))
do
    case $i in
    $last)
            DATASET="{\"{#ZFSDATASET}\":\"${datasets[$i]}\"} "
    ;;
    0)
            DATASET="{\"{#ZFSDATASET}\":\"${datasets[$i]}\"}, "
    ;;
    *)
            DATASET="{\"{#ZFSDATASET}\":\"${datasets[$i]}\"}, "
    ;;
    esac
    SETALL="$SETALL""$DATASET"
done
echo "{\"data\":["$SETALL"]}"


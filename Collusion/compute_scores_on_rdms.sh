#!/bin/bash

#source ~/venvs/py27/bin/activate

FEATURESET=$1
DISTANCE=$2
ONWHAT=$3
THRESHOLD=$4
NETWORK=$5
if [ -z "$FEATURESET" ]; then
    echo 'Error: FEATURESET is not specified'
    exit
fi
if [ -z "$DISTANCE" ]; then
    echo 'Error: DISTANCE is not specified'
    exit
fi
if [ -z "$ONWHAT" ]; then
    echo 'Error: ONWHAT is not specified'
    exit
fi
if [ -z "$THRESHOLD" ]; then
    echo 'Error: THRESHOLD is not specified'
    exit
fi
if [ -z "$NETWORK" ]; then
    echo 'Error: NETWORK is not specified'
    exit
fi

nfiles=$(ls -l ../../Data/Intracranial/Processed/$FEATURESET/*.mat | wc -l)
for i in $(seq 1 $nfiles)
do
    let i=i-1
    srun --partition=long,phi,main -c 1 --mem=2000 -t 96:00:00 python RSAScorer.py -f $FEATURESET -d $DISTANCE -i $i -o $ONWHAT -t $THRESHOLD -n $NETWORK &
    sleep 1
done

echo 'All sent'

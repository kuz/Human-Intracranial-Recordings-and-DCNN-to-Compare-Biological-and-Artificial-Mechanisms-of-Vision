#!/bin/bash

#source ~/venvs/py27/bin/activate

FEATURESET=$1
DISTANCE=$2
ONWHAT=$3
THRESHOLD=$4
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

nfiles=$(ls -l ../../Data/Intracranial/Processed/$FEATURESET/*.mat | wc -l)
for i in $(seq 1 $nfiles)
do
    let i=i-1
    # EEnet
    #srun -N 1 --partition=long --cpus-per-task=1 --mem=2000 --exclude=idu[38-41] python RSAScorer.py -f $FEATURESET -d $DISTANCE -i $i -o $ONWHAT -t $THRESHOLD &
    # Rocket
    srun --partition=long,phi,main -c 1 --mem=2000 -t 96:00:00 python RSAScorer.py -f $FEATURESET -d $DISTANCE -i $i -o $ONWHAT -t $THRESHOLD &
    sleep 2
done

echo 'All sent'

#!/bin/bash

export LD_LIBRARY_PATH=/gpfs/hpchome/a72073/Python/lib/:/usr/lib:/usr/local/lib:/usr/lib64:/usr/local/lib64:/gpfs/hpchome/a72073/Software/lib
source ~/Python/bin/activate

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
    srun -N 1 --cpus-per-task=1 --mem=2000 -t 24:00:00 python RSAScorer.py -f $FEATURESET -d $DISTANCE -i $i -o $ONWHAT -t $THRESHOLD &
    sleep 5
done


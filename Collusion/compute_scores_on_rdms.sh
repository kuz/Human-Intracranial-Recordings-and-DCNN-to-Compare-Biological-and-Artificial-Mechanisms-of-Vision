#!/bin/bash

source ~/Python/bin/activate
FEATURESET=meangamma_bipolar_noscram_artif_brodmann_resppositive
DISTANCE=euclidean
ONWHAT=image
THRESHOLD=0.00001
nfiles=$(ls -l ../../Data/Intracranial/Processed/$FEATURESET/*.mat | wc -l)
for i in $(seq 1 $nfiles)
do
    let i=i-1
    srun -N 1 --partition=long --cpus-per-task=1 --mem=2000 --exclude idu[38-41] python RSAScorer.py -f $FEATURESET -d $DISTANCE -i $i -o $ONWHAT -t $THRESHOLD &
    sleep 5
done


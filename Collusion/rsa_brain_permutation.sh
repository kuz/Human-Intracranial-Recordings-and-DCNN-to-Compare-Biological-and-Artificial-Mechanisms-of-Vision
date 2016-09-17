#!/bin/bash

source ~/Python/bin/activate
FEATURESET=meangamma_bipolar_noscram_artif_responsive_brodmann
DISTANCE=euclidean
nfiles=$(ls -l ../../Data/Intracranial/Processed/$FEATURESET/*.mat | wc -l)
for run in $(seq 1 1000)
do
    echo "------------------------ RUN $run ------------------------"
    srun -N 1 --partition=long --cpus-per-task=1 --mem=2000 --exclude idu[01-03,31-32,38-41] python rsa_brain_permutation.py -f $FEATURESET -d $DISTANCE --prun $run &
    sleep 60
done


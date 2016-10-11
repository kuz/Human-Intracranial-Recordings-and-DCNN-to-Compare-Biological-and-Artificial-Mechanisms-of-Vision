#!/bin/bash

source ~/Python/bin/activate
FEATURESET=meangamma_bipolar_noscram_artif_responsive_brodmann
DISTANCE=euclidean
nfiles=$(ls -l ../../Data/Intracranial/Processed/$FEATURESET/*.mat | wc -l)
#for i in $(seq 1 $nfiles)
for i in $(seq 140 140)
do
    let i=i-1
    srun -N 1 --partition=long --cpus-per-task=1 --mem=2000 --exclude idu[38-41] python map_layers_to_probes_rsa.py --sid $i --featureset $FEATURESET --distance $DISTANCE &
    sleep 5
done


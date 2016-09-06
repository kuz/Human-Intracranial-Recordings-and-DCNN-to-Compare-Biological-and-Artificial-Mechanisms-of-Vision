#!/bin/bash

source ~/Python/bin/activate
FEATURESET=meangamma_bipolar_noscram_artif_responsive
DISTANCE=euclidean
nfiles=$(ls -l ../../Data/Intracranial/Processed/$FEATURESET/*.mat | wc -l)
for i in $(seq 1 $nfiles)
do
    let i=i-1
    # 01-12
    srun -N 1 --partition=long --cpus-per-task=1 --mem=2000 --exclude idu[01-03,31-37,38-41] python map_layers_to_probes_rsa.py --sid $i --featureset $FEATURESET --distance $DISTANCE &
    sleep 5
done


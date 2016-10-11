#!/bin/bash

source ~/Python/bin/activate
FEATURESET=meangamma_bipolar_noscram_artif_responsive
nfiles=$(ls -l ../../Data/Intracranial/Processed/$FEATURESET/*.mat | wc -l)
for i in $(seq 1 $nfiles)
do
    let i=i-1
    srun -N 1 --partition=long --cpus-per-task=4 --mem=15000 --exclude idu[38-41] python map_layers_to_probes_store_all_r.py --sid $i --activations numpy.reference --featureset $FEATURESET &
    sleep 10
done


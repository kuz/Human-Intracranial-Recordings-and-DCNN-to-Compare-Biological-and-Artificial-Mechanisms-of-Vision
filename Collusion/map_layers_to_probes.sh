#!/bin/bash

source ~/Python/bin/activate
nfiles=$(ls -l ../../Data/Intracranial/Processed/meangamma_ventral_w250_10hz/*.mat | wc -l)
for i in $(seq 1 $nfiles)
do
    let i=i-1
    srun -N 1 --partition=long --cpus-per-task=6 --mem=24000 --exclude idu08,idu09,idu10,idu38,idu39,idu40,idu41 python map_layers_to_probes.py --sid $i --activations numpy.reference --featureset meangamma_ventral_noscram &
    sleep 10
done


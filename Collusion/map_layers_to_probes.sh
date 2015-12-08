#!/bin/bash

source ~/Python/bin/activate
nfiles=$(ls -l ../../Data/Intracranial/Processed/meangamma/*.mat | wc -l)
for i in $(seq 1 $nfiles)
do
    let i=i-1
    srun -N 1 --partition=long --cpus-per-task=12 --mem=48000 --exclude idu38,idu39,idu40,idu41 python map_layers_to_probes.py --sid $i --activations numpy.reference --featureset meangamma &
    sleep 10
done


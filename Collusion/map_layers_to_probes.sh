#!/bin/bash

nfiles=$(ls -l ../../Data/Intracranial/Processed/maxamp/*.mat | wc -l)
for i in $(seq 1 $nfiles)
do
    let i=i-1
    srun -N 1 --cpus-per-task=12 --mem=48000 python map_layers_to_probes.py --sid $i --featureset maxamp &
    sleep 10
done


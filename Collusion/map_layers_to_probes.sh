#!/bin/bash

nfiles=$(ls -l ../../Data/Intracranial/Processed/maxamp/*.mat | wc -l)
for i in $(seq 1 $nfiles)
do
    let i=i-1
    srun -N 1 --cpus-per-task=8 --mem=60000 -t 32:00:00 python map_layers_to_probes.py --sid $i &
    sleep 10
done


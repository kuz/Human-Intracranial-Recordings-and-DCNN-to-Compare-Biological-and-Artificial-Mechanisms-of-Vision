#!/bin/bash

source ~/Python/bin/activate
FEATURESET=meangamma_bipolar_noscram_artif_responsive
nfiles=$(ls -l ../../Data/Intracranial/Processed/$FEATURESET/*.mat | wc -l)
for i in $(seq 1 $nfiles)
do
    let i=i-1
    # 01-12
    srun -N 1 --partition=long --cpus-per-task=6 --mem=24000 --exclude idu[01-03,31-37,38-41] python map_pixels_to_probes_store_all_r.py --sid $i --featureset $FEATURESET &
    sleep 10
done


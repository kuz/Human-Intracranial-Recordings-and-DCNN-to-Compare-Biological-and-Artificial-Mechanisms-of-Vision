#!/bin/bash

source ~/Python/bin/activate
FEATURESET=meangamma_biploar_noscram_ventral_artif
nfiles=$(ls -l ../../Data/Intracranial/Processed/$FEATURESET/*.mat | wc -l)
for i in $(seq 1 $nfiles)
do
    let i=i-1
    srun -N 1 --partition=long --cpus-per-task=6 --mem=24000 --exclude idu38,idu39,idu40,idu41 python mapper_cv_scores.py --sid $i --activations numpy.reference --featureset $FEATURESET &
    sleep 10
done


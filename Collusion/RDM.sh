#!/bin/bash

# parameters
source ~/Python/bin/activate
FEATURESET=meangamma_bipolar_noscram_artif_responsive_brodmann
DISTANCE=euclidean

# pixels
srun -N 1 --partition=long --cpus-per-task=1 --mem=2000 --exclude idu[38-41] python RSA.py -s pixels -d $DISTANCE &

# dnn
srun -N 1 --partition=long --cpus-per-task=1 --mem=6000 --exclude idu[38-41] python RSA.py -s dnn -d $DISTANCE -a numpy.reference &

# brain
nfiles=$(ls -l ../../Data/Intracranial/Processed/$FEATURESET/*.mat | wc -l)
for i in $(seq 1 $nfiles)
do
    let i=i-1
    srun -N 1 --partition=long --cpus-per-task=1 --mem=2000 --exclude idu[38-41] python RSA.py -s brain -d $DISTANCE -i $i -f $FEATURESET &
    sleep 2
done


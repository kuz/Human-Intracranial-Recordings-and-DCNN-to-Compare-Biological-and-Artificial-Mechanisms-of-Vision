#!/bin/bash

# parameters
source ~/Python/bin/activate
FEATURESET=meangamma_bipolar_noscram_artif_brodmann_resppositive
DISTANCE=euclidean

# pixels
srun -N 1 --partition=long --cpus-per-task=1 --mem=2000 --exclude idu[38-41] python RDM.py -t pixels -d $DISTANCE -f $FEATURESET &

# dnn
srun -N 1 --partition=long --cpus-per-task=1 --mem=6000 --exclude idu[38-41] python RDM.py -t dnn -d $DISTANCE -f $FEATURESET -a numpy.reference &

# brain
nfiles=$(ls -l ../../Data/Intracranial/Processed/$FEATURESET/*.mat | wc -l)
for i in $(seq 1 $nfiles)
do
    let i=i-1
    srun -N 1 --partition=long --cpus-per-task=1 --mem=2000 --exclude idu[38-41] python RDM.py -t brain -d $DISTANCE -i $i -f $FEATURESET &
    sleep 2
done


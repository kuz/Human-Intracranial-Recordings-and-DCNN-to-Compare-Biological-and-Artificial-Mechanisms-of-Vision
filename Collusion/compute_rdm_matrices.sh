#!/bin/bash

# parameters
source ~/venvs/py27/bin/activate

FEATURESET=$1
DISTANCE=$2
if [ -z "$FEATURESET" ]; then
    echo 'Error: FEATURESET is not specified'
    exit
fi
if [ -z "$DISTANCE" ]; then
    echo 'Error: DISTANCE is not specified'
    exit
fi

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


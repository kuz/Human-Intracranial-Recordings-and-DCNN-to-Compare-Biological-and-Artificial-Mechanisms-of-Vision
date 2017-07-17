#!/bin/bash

# parameters
module load python-2.7.11
source ~/ve/py27/bin/activate

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
srun --partition=long,phi,main -c 1 --mem=2000 -t 96:00:00 python RDM.py -t pixels -d $DISTANCE -f $FEATURESET &

# dnn
srun --partition=long,phi,main -c 1 --mem=2000 -t 96:00:00 python RDM.py -t dnn -d $DISTANCE -f $FEATURESET -n alexnet &
srun --partition=long,phi,main -c 1 --mem=2000 -t 96:00:00 python RDM.py -t dnn -d $DISTANCE -f $FEATURESET -n alexnetrandom &

# brain
nfiles=$(ls -l ../../Data/Intracranial/Processed/$FEATURESET/*.mat | wc -l)
for i in $(seq 1 $nfiles)
do
    let i=i-1
    srun --partition=long,phi,main -c 1 --mem=2000 -t 96:00:00 python RDM.py -t brain -d $DISTANCE -i $i -f $FEATURESET &
    sleep 1
done

echo 'All sent'


#!/bin/bash

export LD_LIBRARY_PATH=/gpfs/hpchome/a72073/Python/lib/:/usr/lib:/usr/local/lib:/usr/lib64:/usr/local/lib64:/gpfs/hpchome/a72073/Software/lib
source ~/Python/bin/activate

FEATURESET=meanhighgamma_LFP_bipolar_noscram_artif_brodmann_w150_highgamma_resppositive
DISTANCE=euclidean
ONWHAT=matrix
THRESHOLD=1.0
nfiles=$(ls -l ../../Data/Intracranial/Processed/$FEATURESET/*.mat | wc -l)
for i in $(seq 1 $nfiles)
do
    let i=i-1
    srun -N 1 --cpus-per-task=1 --mem=2000 -t 24:00:00 python RSAScorer.py -f $FEATURESET -d $DISTANCE -i $i -o $ONWHAT -t $THRESHOLD &
    sleep 5
done


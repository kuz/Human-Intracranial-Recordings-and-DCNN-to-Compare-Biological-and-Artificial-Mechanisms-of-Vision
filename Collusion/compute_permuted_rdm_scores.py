import os
import time
import argparse
import numpy as np
import scipy.io as sio
from subprocess import Popen

parser = argparse.ArgumentParser(description='Permute RDM matrices and compute similarity scores')
parser.add_argument('-f', '--featureset', dest='featureset', type=str, required=True, help='Directory with brain features (Processed/?)')
parser.add_argument('-d', '--distance', dest='distance', type=str, required=True, help='The distance metric to use')
parser.add_argument('-o', '--onwhat', dest='onwhat', type=str, required=True, help='image or matrix depending on which you to compute the correlation on')
parser.add_argument('-t', '--threshold', dest='threshold', type=str, required=True, help='Significance level a score must have to be counter (1.0 to store all)')
parser.add_argument('-n', '--network', dest='network', type=str, required=True, help='Activations of which DNN are to be used')

args = parser.parse_args()
featureset = str(args.featureset)
distance = str(args.distance)
onwhat = str(args.onwhat)
threshold = str(args.threshold)
network = str(args.network)

DATADIR = '../../Data'

subjects = sorted(os.listdir('%s/Intracranial/Processed/%s/' % (DATADIR, featureset)))
for sid in range(len(subjects)):
    s = sio.loadmat('%s/Intracranial/Processed/%s/%s' % (DATADIR, featureset, subjects[sid]))
    for pid in range(len(np.ravel(s['s']['probes'][0][0][0][0][3]))):
        print "echo 'Processing subject %d probe %d'" % (sid, pid)
        print 'srun --partition=long,phi,main -c 2 --mem=8000 -t 96:00:00 python RDMPermuter.py -i %d -p %d -b rsa -f %s -d %s -o %s -t %s -n %s &' % (sid, pid, featureset, distance, onwhat, threshold, network)
        print 'sleep 3'

print 'echo "All sent"'


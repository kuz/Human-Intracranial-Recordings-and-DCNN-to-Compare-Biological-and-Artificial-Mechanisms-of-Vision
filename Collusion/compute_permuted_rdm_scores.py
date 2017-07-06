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

args = parser.parse_args()
featureset = str(args.featureset)
distance = str(args.distance)
onwhat = str(args.onwhat)
threshold = str(args.threshold)
DATADIR = '../../Data'

subjects = os.listdir('%s/Intracranial/Processed/%s/' % (DATADIR, featureset))
for sid in range(len(subjects)):
    s = sio.loadmat('%s/Intracranial/Processed/%s/%s' % (DATADIR, featureset, subjects[sid]))
    for pid in range(len(np.ravel(s['s']['probes'][0][0][0][0][3]))):
        #print 'Processing subject %d probe %d' % (sid, pid)
        #Popen(['srun -N 1 --partition=long --cpus-per-task=1 --mem=4000 -t 24:00:00 python RDMPermuter.py -i %d -p %d -b rsa -f %s -d %s -o %s -t %s' % (sid, pid, featureset, distance, onwhat, threshold)], shell='True', stdin=None, stdout=None, stderr=None, close_fds=True)
        #time.sleep(15)
        print "echo 'Processing subject %d probe %d'" % (sid, pid)
        print 'srun -N 1 --partition=long --cpus-per-task=2 --mem=8000 -t 24:00:00 --exclude idu[38-41] python RDMPermuter.py -i %d -p %d -b rsa -f %s -d %s -o %s -t %s &' % (sid, pid, featureset, distance, onwhat, threshold)
        print 'sleep 3'

print 'echo "All sent"'


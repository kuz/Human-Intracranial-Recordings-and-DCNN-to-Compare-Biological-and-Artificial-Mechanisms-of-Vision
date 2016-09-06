import os
import glob
import numpy as np
import argparse
from scipy.stats import spearmanr
from sklearn.preprocessing import MinMaxScaler

# read in command line arguments
parser = argparse.ArgumentParser(description='Compute RSA matrices for each electrode')
parser.add_argument('-i', '--sid', dest='sid', type=int, required=True, help='Subject ID')
parser.add_argument('-f', '--featureset', dest='featureset', type=str, required=True, help='Directory with brain features (Processed/?)')
parser.add_argument('-d', '--distance', dest='dist', type=str, required=True, help='The distance metric to use')
args = parser.parse_args()
sid = int(args.sid)
featureset = str(args.featureset)
dist = str(args.dist)

# load layer similarity matrices including the "layer 0" (pixel space)
layers = ['pixels', 'conv1', 'conv2', 'conv3', 'conv4', 'conv5', 'fc6', 'fc7', 'fc8']
dnn_dsm = {}
for layer in layers:
    dnn_dsm[layer] = np.loadtxt('../../Data/RSA/%s/numbers/dnn-%s.txt' % (dist, layer))

# load brain response dissimilarity matrices
brain_dsm = {}
listing = glob.glob('../../Data/RSA/%s/numbers/brain-%d-*.txt' % (dist, sid))
for pid, filename in enumerate(listing):
    brain_dsm[pid] = np.loadtxt(filename)

# compute correlation between every layer-brain pair of RSA matrices
mms = MinMaxScaler()
nprobes = len(listing)
nstim = brain_dsm[0].shape[0]
maps = np.empty((nprobes, len(layers)))
for lid, layer in enumerate(layers):
    for pid in range(nprobes):
        dnn = mms.fit_transform(dnn_dsm[layer])
        brain = mms.fit_transform(brain_dsm[pid])
        score = 0
        for i in range(nstim):
            # here we can decide what do we use as a score between the two matrices
            # a) number of images that were significantly correlated in both matrices
            r, p = spearmanr(dnn[i, :], brain[i, :])
            if p < 0.0001:
                score += 1

            # b) sum of r scores of all significanly correlated images
            # todo
        maps[pid, lid] = score

# replace NaN's with 0
maps[np.isnan(maps)] = 0.0

# store the scores
subjects = os.listdir('../../Data/Intracranial/Processed/%s/' % featureset)
np.savetxt('../../Data/Intracranial/Probe_to_Layer_Maps/rsa_%s_%s/%s.txt' % (dist, featureset, os.path.splitext(subjects[sid])[0]), maps, fmt='%.4f')


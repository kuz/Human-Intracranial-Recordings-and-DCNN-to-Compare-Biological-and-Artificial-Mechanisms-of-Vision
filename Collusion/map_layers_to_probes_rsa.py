import os
import glob
import numpy as np
import argparse
from scipy.stats import spearmanr, pearsonr
from sklearn.preprocessing import MinMaxScaler

# read in command line arguments
parser = argparse.ArgumentParser(description='Compute RSA matrices for each electrode')
parser.add_argument('-i', '--sid', dest='sid', type=int, required=True, help='Subject ID')
parser.add_argument('-f', '--featureset', dest='featureset', type=str, required=True, help='Directory with brain features (Processed/?)')
parser.add_argument('-d', '--distance', dest='dist', type=str, required=True, help='The distance metric to use')
parser.add_argument('-s', '--shuffle', dest='shuffle', type=bool, required=False, default=False, help='Whether to shuffle data for a permutation test')
args = parser.parse_args()
sid = int(args.sid)
featureset = str(args.featureset)
dist = str(args.dist)
shuffle = bool(args.shuffle)

suffix = ''
if shuffle:
    suffix = '.shuffled'

# read list of subjects
subjects = os.listdir('../../Data/Intracranial/Processed/%s/' % featureset)
sname = subjects[14].split('.')[0]

# load layer similarity matrices including the "layer 0" (pixel space)
layers = ['pixels', 'conv1', 'conv2', 'conv3', 'conv4', 'conv5', 'fc6', 'fc7', 'fc8']
dnn_dsm = {}
for layer in layers:
    dnn_dsm[layer] = np.loadtxt('../../Data/RSA/%s%s/numbers/dnn-%s.txt' % (dist, suffix, layer))

# load brain response dissimilarity matrices
brain_dsm = {}
listing = glob.glob('../../Data/RSA/%s%s/numbers/brain-%s-*.txt' % (dist, suffix, sname))
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
            #r, p = spearmanr(dnn[i, :], brain[i, :])
            #if p < 0.00001:
            #    score += 1

            # b) sum of r scores of all significanly correlated images
            r, p = spearmanr(dnn[i, :], brain[i, :])
            #if p < 0.00001:
            score += r
        
        maps[pid, lid] = score / float(nstim)

# replace NaN's with 0
maps[np.isnan(maps)] = 0.0

# store the scores
np.savetxt('../../Data/Intracranial/Probe_to_Layer_Maps/rsa_%s%s_%s/%s.txt' % (dist, suffix, featureset, sname), maps, fmt='%.4f')


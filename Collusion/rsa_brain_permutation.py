import os
import time
import numpy as np
import scipy.io as sio
from scipy.spatial import distance
from scipy.stats import spearmanr
import argparse
from sklearn.preprocessing import MinMaxScaler

# read in command line arguments
parser = argparse.ArgumentParser(description='Compute RSA matrices for each electrode')
parser.add_argument('-f', '--featureset', dest='featureset', type=str, required=True, help='Directory with brain features (Processed/?)')
parser.add_argument('-d', '--distance', dest='dist', type=str, required=True, help='The distance metric to use')
parser.add_argument('-p', '--prun', dest='prun', type=int, required=False, default=0, help='Permutation test run number')
args = parser.parse_args()
featureset = str(args.featureset)
dist = str(args.dist)
prun = int(args.prun)

# load list of stimuli in the order they were presented to DNN
dnn_stimuli = np.loadtxt('../../Data/DNN/imagesdone.txt', dtype={'names': ('stimulus', 'class'), 'formats': ('S10', 'i1')})
dnn_stimuli = [x[0].split('.')[0] for x in dnn_stimuli]

# load layer similarity matrices including the "layer 0" (pixel space)
layers = ['pixels', 'conv1', 'conv2', 'conv3', 'conv4', 'conv5', 'fc6', 'fc7', 'fc8']
dnn_dsm = {}
for layer in layers:
    dnn_dsm[layer] = np.loadtxt('../../Data/RSA/%s.shuffled/numbers/dnn-%s.txt' % (dist, layer))

# load list of subjects
subjects = os.listdir('../../Data/Intracranial/Processed/%s/' % featureset)

# load brain data
brain_dsm = {}
for sid, sfile in enumerate(subjects):

    # load the matlab structure 
    s = sio.loadmat('../../Data/Intracranial/Processed/%s/%s' % (featureset, sfile))
    subject = {}
    subject['data'] = s['s']['data'][0][0]

    # sort brain responses by category
    stimuli_of_interest = list(np.loadtxt('../Intracranial/stimsequence.txt', dtype='string'))
    sorted_stimuli_of_interest = sorted(stimuli_of_interest)
    new_order = []
    for s in sorted_stimuli_of_interest:
        new_order.append(stimuli_of_interest.index(s))

    # randomly reshuffle responses
    new_order = np.random.permutation(new_order)
    representation = subject['data'][new_order]

    # compute similarity matrices for each probe
    nstim = representation.shape[0]
    nprobes = representation.shape[1]
    for p in range(nprobes):
        brain_dsm[p] = distance.squareform(distance.pdist(representation[:, p].reshape((nstim, 1)), dist))
    if nprobes == 0:
        brain_dsm[0] = np.zeros((nstim, nstim))
    
    # map layer RDMs to probe RMDs
    mms = MinMaxScaler()
    maps = np.zeros((nprobes, len(layers)))
    for lid, layer in enumerate(layers):
        for pid in range(nprobes):
            dnn = mms.fit_transform(dnn_dsm[layer])
            brain = mms.fit_transform(brain_dsm[pid])
            r, p = spearmanr(np.ravel(dnn), np.ravel(brain))
            if r > 0.0 and p <= 0.00001:
                maps[pid, lid] = r
    
    # store the scores
    np.savetxt('../../Data/Intracranial/Probe_to_Layer_Maps/Permutation/rsa_%s_%s/%d/%s.txt' % (dist, featureset, prun, os.path.splitext(subjects[sid])[0]), maps, fmt='%.6f')






import os
import numpy as np
import scipy.io as sio
from scipy.spatial import distance
from matplotlib import pylab as plt
import argparse

# read in command line arguments
parser = argparse.ArgumentParser(description='Compute RSA matrices for each electrode')
parser.add_argument('-f', '--featureset', dest='featureset', type=str, required=True, help='Directory with brain features (Processed/?)')
parser.add_argument('-d', '--distance', dest='dist', type=str, required=True, help='The distance metric to use')
parser.add_argument('-s', '--shuffle', dest='shuffle', type=bool, required=False, default=False, help='Whether to shuffle data for a permutation test')
args = parser.parse_args()
featureset = str(args.featureset)
dist = str(args.dist)
shuffle = bool(args.shuffle)

nareas = 49

# load list of stimuli in the order they were presented to DNN
print 'Loading DNN stimuli...'
dnn_stimuli = np.loadtxt('../../Data/DNN/imagesdone.txt', dtype={'names': ('stimulus', 'class'), 'formats': ('S10', 'i1')})
dnn_stimuli = [x[0].split('.')[0] for x in dnn_stimuli]

# sort brain rcesponses by category
stimuli_of_interest = list(np.loadtxt('../Intracranial/stimsequence.txt', dtype='string'))
nstim = len(stimuli_of_interest)
sorted_stimuli_of_interest = sorted(stimuli_of_interest)
new_order = []
for s in sorted_stimuli_of_interest:
    new_order.append(stimuli_of_interest.index(s))

# read list of subjects
listing = os.listdir('../../Data/Intracranial/Processed/%s/' % featureset)

# area activations across subjects
area_activations = {}
for aid in range(nareas):
    area_activations[aid] = np.empty((nstim, 0))

# extract per-areas activations from all subjects
for sfile in listing:

    # load the matlab structure 
    s = sio.loadmat('../../Data/Intracranial/Processed/%s/%s' % (featureset, sfile))
    subject = {}
    subject['stimseq'] = [x[0][0] for x in s['s']['stimseq'][0][0]]
    subject['stimgroups'] = [x[0] for x in s['s']['stimgroups'][0][0]]
    subject['probes'] = {}
    subject['probes']['rod_names'] = list(s['s']['probes'][0][0][0][0][0])
    subject['probes']['probe_ids'] = [x[0] for x in list(s['s']['probes'][0][0][0][0][1])]
    subject['probes']['mni'] = s['s']['probes'][0][0][0][0][2]
    subject['probes']['areas'] = np.ravel(s['s']['probes'][0][0][0][0][3])
    subject['data'] = s['s']['data'][0][0]
    subject['name'] = s['s']['name'][0][0][0]

    # sort images in the same order as it was presented to DNN
    if shuffle == True:
        new_order = np.random.permutation(new_order)
    representation = subject['data'][new_order]

    # put activations from different areas to difference matrices
    for aid in range(nareas):
        area_activations[aid] = np.concatenate((area_activations[aid], representation[:, subject['probes']['areas'] == aid]), axis=1)

# compute similarity matrices
for aid in range(nareas):
    sm = distance.squareform(distance.pdist(area_activations[aid], dist))

    # store the data
    suffix = ''
    if shuffle:
        suffix = '.shuffled'
    np.savetxt('../../Data/RSA/%s%s/numbers/area-%d.txt' % (dist, suffix, aid), sm, fmt='%.6f')

    # store the plot
    plt.figure();
    plt.imshow(sm);
    #if np.max(sm) > 5.0:
    #    plt.clim(0.0, 5.0);
    plt.colorbar();
    plt.savefig('../../Data/RSA/%s%s/plots/area-%d.png' % (dist, suffix, aid));
    plt.clf();

import os
import time
import numpy as np
import scipy.io as sio
from scipy.spatial import distance
#from matplotlib import pylab as plt
import argparse

# read in command line arguments
parser = argparse.ArgumentParser(description='Compute RSA matrices for each electrode')
parser.add_argument('-i', '--sid', dest='sid', type=int, required=True, help='Subject ID')
parser.add_argument('-f', '--featureset', dest='featureset', type=str, required=True, help='Directory with brain features (Processed/?)')
parser.add_argument('-d', '--distance', dest='dist', type=str, required=True, help='The distance metric to use')
parser.add_argument('-s', '--shuffle', dest='shuffle', type=str, required=False, default=False, help='Whether to shuffle data for a permutation test')
args = parser.parse_args()
sid = int(args.sid)
featureset = str(args.featureset)
dist = str(args.dist)
shuffle = bool(args.shuffle == 'True')

# based on the configuration decide on some parameters
suffix = ''
if shuffle:
    suffix = '.shuffled'

# load list of stimuli in the order they were presented to DNN
dnn_stimuli = np.loadtxt('../../Data/DNN/imagesdone.txt', dtype={'names': ('stimulus', 'class'), 'formats': ('S10', 'i1')})
dnn_stimuli = [x[0].split('.')[0] for x in dnn_stimuli]

# read list of subjects
listing = os.listdir('../../Data/Intracranial/Processed/%s/' % featureset)

# load brain data
sfile = listing[sid]
print 'Processing %s...' % sfile

# load the matlab structure 
s = sio.loadmat('../../Data/Intracranial/Processed/%s/%s' % (featureset, sfile))
subject = {}
#subject['stimseq'] = [x[0][0] for x in s['s']['stimseq'][0][0]]
#subject['stimgroups'] = [x[0] for x in s['s']['stimgroups'][0][0]]
#subject['probes'] = {}
#subject['probes']['rod_names'] = list(s['s']['probes'][0][0][0][0][0])
#subject['probes']['probe_ids'] = [x[0] for x in list(s['s']['probes'][0][0][0][0][1])]
#subject['probes']['mni'] = s['s']['probes'][0][0][0][0][2]
subject['data'] = s['s']['data'][0][0]
subject['name'] = s['s']['name'][0][0][0]

# sort brain responses by category
stimuli_of_interest = list(np.loadtxt('../Intracranial/stimsequence.txt', dtype='string'))
sorted_stimuli_of_interest = sorted(stimuli_of_interest)
new_order = []
for s in sorted_stimuli_of_interest:
    new_order.append(stimuli_of_interest.index(s))

# sort images in the same order as it was presented to DNN
if shuffle:
    new_order = np.random.permutation(new_order)
representation = subject['data'][new_order]

# compute similarity matrices
nstim = representation.shape[0]
nprobes = representation.shape[1]
for p in range(nprobes):
    sm = distance.squareform(distance.pdist(representation[:, p].reshape((nstim, 1)), dist))
    
    # store the data
    np.savetxt('../../Data/RSA/%s%s/numbers/brain-%s-%d.txt' % (dist, suffix, subject['name'], p), sm, fmt='%.3f')

    # store the plot
    #plt.figure();
    #plt.imshow(sm);
    #plt.colorbar();
    #plt.savefig('../../Data/RSA/%s%s/plots/brain-%s-%d.png' % (dist, suffix, subject['name'], p));
    #plt.clf();

# store all-zeros if this subject does not have any probes
if nprobes == 0:
    sm = np.zeros((nstim, nstim))
    np.savetxt('../../Data/RSA/%s%s/numbers/brain-%s-%d.txt' % (dist, suffix, subject['name'], 0), sm, fmt='%.3f')

"""

Given intracranial recordings of a subject attempt to predict each probe's activity from activations of layers of DNN.
For each probe we find the layer which is the best at precting the probe's activity.

"""

import os
import time
import numpy as np
import scipy.io as sio
from sklearn import linear_model
from scipy.stats import pearsonr
import multiprocessing
from joblib import Parallel, delayed
import argparse

# read in command line arguments
parser = argparse.ArgumentParser(description='Train all linear models for a given subject.')
parser.add_argument('-i', '--sid', dest='sid', type=int, required=True, help='Subject ID')
parset.add_argument('-f', '--featureset', dest='featureset', type=str, required=True, help='Directory under Processed/')
args = parser.parse_args()
sid = int(args.sid)
featureset = str(args.featureset)

# parameters
#ncores = multiprocessing.cpu_count()
ncores = 8
print "Working with %d CPUs" % ncores

def predict_from_layer(layer_activations, layer, subject, subject_id, nsubjects, dnn_stimuli):
    """
    Takes one layer and predicts all probe activations from that layer
    """

    nstims = subject['data'].shape[0]
    nprobes = subject['data'].shape[1]

    # display progress
    print 'Training models for subject %s (%d/%d), layer %s' % (subject['name'], subject_id, nsubjects, layer)

    # place to store coefficients
    r_coefs = np.zeros(nprobes)

    # pick 70% of stimuli for training and 30% for layer assignment
    # TODO: should this be before the for cycle
    # TODO: replace with cross-validation
    train_idx = np.random.choice(range(nstims), size=int(nstims * 0.7), replace=False)
    assign_idx = list(set(range(nstims)) - set(train_idx))

    # create the dataset
    layer_activity = np.zeros((nstims, layer_activations.shape[1]))
    probe_responses = np.zeros((nstims, nprobes))
    for sid_brain, stimulus in enumerate(subject['stimseq']):
        sid_dnn = dnn_stimuli.index(stimulus)
        layer_activity[sid_brain, :] = layer_activations[sid_dnn, :]
        probe_responses = subject['data']

    # split the dataset
    train_layer_activity = layer_activity[train_idx, :]
    train_probe_responses = probe_responses[train_idx, :]
    assign_layer_activity = layer_activity[assign_idx, :]
    assign_probe_responses = probe_responses[assign_idx, :]

    # build a linear predictor for each probe
    for pid in range(len(subject['probes']['probe_ids'])):

        print '  %s, %s, %d' % (subject['name'], layer, pid)

        # train a model
        clf = linear_model.Lasso(alpha = 0.1, max_iter=10000)
        clf.fit(train_layer_activity, train_probe_responses[:, pid])

        # attempt prediction on the assignment set
        true = assign_probe_responses[:, pid]
        predicted = clf.predict(assign_layer_activity)

        # store the correlation coefficient
        r, pval = pearsonr(true, predicted)
        if pval <= 0.05:
            r_coefs[pid] = r
        else:
            r_coefs[pid] = 0.0

    return (subject['name'], layer, r_coefs)

# prepare lists of probe coordinates for each layer
print 'Loading list of layers...'
layers = os.listdir('../../Data/DNN/Activations/numpy')
assignments = {}
for layer in layers:
    assignments[layer] = []

# load DNN activations
print 'Loading DNN activations...'
activations = {}
for layer in layers:
    activations[layer] = np.load('../../Data/DNN/Activations/numpy/%s/activations.npy' % layer)

# load list of stimuli in the order they were presented to DNN
print 'Loading DNN stimuli...'
dnn_stimuli = np.loadtxt('../../Data/DNN/imagesdone.txt', dtype={'names': ('stimulus', 'class'), 'formats': ('S10', 'i1')})
dnn_stimuli = [x[0].split('.')[0] for x in dnn_stimuli]

# read list of subjects
listing = os.listdir('../../Data/Intracranial/Processed/%s/' % featureset)

# grid of (subject, layer) pairs to compute
subject_layer_grid = []

# load brain data
sfile = listing[sid]
print '  Loading %s...' % sfile

# load the matlab structure 
s = sio.loadmat('../../Data/Intracranial/Processed/%s/%s' % (featureset, sfile))
subject = {}
subject['stimseq'] = [x[0][0] for x in s['s']['stimseq'][0][0]]
subject['stimgroups'] = [x[0] for x in s['s']['stimgroups'][0][0]]
subject['probes'] = {}
subject['probes']['rod_names'] = list(s['s']['probes'][0][0][0][0][0])
subject['probes']['probe_ids'] = [x[0] for x in list(s['s']['probes'][0][0][0][0][1])]
subject['probes']['mni'] = s['s']['probes'][0][0][0][0][2]
subject['data'] = s['s']['data'][0][0]
subject['name'] = s['s']['name'][0][0][0]

for layer in layers:
    subject_layer_grid.append((sid, layer))

# for each probe, layer combination train a linear model to predict the probe response from the layer activations
print 'Training linear models...'
start = time.time()
results = Parallel(n_jobs=ncores)(delayed(predict_from_layer)
                                 (activations[layer], layer, subject, subject_id, len(listing), dnn_stimuli)
                                 for (subject_id, layer) in subject_layer_grid)
print 'Training the models took', time.time() - start

# aggregate results and store to files
print 'Storing mapping for %s...' % subject['name']

# prepare the structure
coefficients = [None] * 8

# put every result to a corresponding cell
for record in results:
    sname, layer, r_coefs = record
    coefficients[layers.index(layer)] = r_coefs

# build the mapping
r_coefs = np.vstack(coefficients)
r_coefs = np.nan_to_num(r_coefs)

# for each probe find the layer it is most correlated with
probe_to_layer_map = np.argmax(r_coefs, axis=0) + 1

# store probe to layer mapping for the subject
np.savetxt('../../Data/Intracranial/Probe_to_Layer_Maps/%s.txt' % subject['name'], probe_to_layer_map, fmt='%i')

    



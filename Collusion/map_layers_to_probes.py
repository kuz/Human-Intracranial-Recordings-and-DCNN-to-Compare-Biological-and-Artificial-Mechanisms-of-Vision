"""

Given intracranial recordings of a subject attempt to predict each probe's activity from activations of layers of DNN.
For each probe we find the layer which is the best at precting the probe's activity.

"""

import os
import numpy as np
import scipy.io as sio
from sklearn import linear_model
from scipy.stats import pearsonr
import multiprocessing
from joblib import Parallel, delayed


# parameters
ncores = multiprocessing.cpu_count()

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

# load list of subjects
listing = os.listdir('../../Data/Intracranial/Processed/maxamp/')

def predict_from_layer(activations, layer, nstims, nprobes, subject):
    """
    Takes one layer and predicts all probe activations from that layer
    """
    
    # place to store coefficients
    r_coefs = np.zeros(nprobes)

    # pick 70% of stimuli for training and 30% for layer assignment
    # TODO: should this be before the for cycle
    # TODO: replace with cross-validation
    train_idx = np.random.choice(range(nstims), size=int(nstims * 0.7), replace=False)
    assign_idx = list(set(range(nstims)) - set(train_idx))

    # create the dataset
    layer_activity = np.zeros((nstims, activations[layer].shape[1]))
    probe_responses = np.zeros((nstims, nprobes))
    for sid_brain, stimulus in enumerate(subject['stimseq']):
        sid_dnn = dnn_stimuli.index(stimulus)
        layer_activity[sid_brain, :] = activations[layer][sid_dnn, :]
        probe_responses = subject['data']

    # split the dataset
    train_layer_activity = layer_activity[train_idx, :]
    train_probe_responses = probe_responses[train_idx, :]
    assign_layer_activity = layer_activity[assign_idx, :]
    assign_probe_responses = probe_responses[assign_idx, :]

    # build a linear predictor for each probe
    for pid in range(len(subject['probes']['probe_ids'])):

        # train a model
        clf = linear_model.Lasso(alpha = 0.1)
        clf.fit(train_layer_activity, train_probe_responses[:, pid])

        # attempt prediction on the assignment set
        true = assign_probe_responses[:, pid]
        predicted = clf.predict(assign_layer_activity)

        # store the correlation coefficient
        r, pval = pearsonr(true, predicted)[0]
        if pval <= 0.05:
            r_coefs[pid] = r
        else:
            r_coefs[pid] = 0.0

    return r_coefs

# for each subject
for sfile in listing:

    print 'Processing %s...' % sfile

    # load the subject file and parse Matlab data structure into a python dict
    print '  Loading matlab structure...'
    s = sio.loadmat('../../Data/Intracranial/Processed/maxamp/%s' % sfile)
    subject = {}
    subject['stimseq'] = [x[0][0] for x in s['s']['stimseq'][0][0]]
    subject['stimgroups'] = [x[0] for x in s['s']['stimgroups'][0][0]]
    subject['probes'] = {}
    subject['probes']['rod_names'] = list(s['s']['probes'][0][0][0][0][0])
    subject['probes']['probe_ids'] = [x[0] for x in list(s['s']['probes'][0][0][0][0][1])]
    subject['probes']['mni'] = s['s']['probes'][0][0][0][0][2]
    subject['data'] = s['s']['data'][0][0]
    subject['name'] = s['s']['name'][0][0][0]

    nstims = subject['data'].shape[0]
    nprobes = subject['data'].shape[1]

    # storage for the prediction results
    r_coefs = np.zeros((nprobes, len(layers)))

    # for each probe, layer combination train a linear model to predict the probe response from the layer activations
    print '  Training linear models...'
    results = Parallel(n_jobs=ncores)(delayed(predict_from_layer)(activations, layer, nstims, nprobes, subject) for layer in layers)
    results = np.vstack(results)
    results = np.nan_to_num(results)

    # for each probe find the layer it is most correlated with
    probe_to_layer_map = np.array(np.argmax(results, axis=0) + 1, dtype=np.int8)

    # store probe to layer mapping for the subject
    np.savetxt('../../Data/Intracranial/Probe_to_Layer_Maps/%s.txt' % subject['name'], probe_to_layer_map)

    



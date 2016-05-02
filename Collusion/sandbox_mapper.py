"""

Given intracranial recordings of a subject attempt to predict each probe's activity from activations of layers of DNN.
For each probe we find the layer which is the best at precting the probe's activity.

"""

import os
import time
import numpy as np
import scipy.io as sio
from sklearn import linear_model
from sklearn import cross_validation
from sklearn.decomposition import PCA, FastICA, KernelPCA
from scipy.stats import pearsonr
import multiprocessing
from joblib import Parallel, delayed
import argparse

# read in command line arguments
sid = 53
np_activation_data = 'numpy.reference'
featureset = 'meangamma_ventral_noscram'

# parameters
ncores = 6
print "Working with %d CPUs" % ncores

# prepare lists of probe coordinates for each layer
print 'Loading list of layers...'
layers = os.listdir('../../Repository/DNN/activations/%s' % np_activation_data)
assignments = {}
for layer in layers:
    assignments[layer] = []

# load DNN activations
print 'Loading DNN activations...'
activations = {}
for layer in layers:
    activations[layer] = np.load('../../Repository/DNN/activations/%s/%s/activations.npy' % (np_activation_data, layer))

# load list of stimuli in the order they were presented to DNN
print 'Loading DNN stimuli...'
dnn_stimuli = np.loadtxt('../../Data/DNN/imagesdone.txt', dtype={'names': ('stimulus', 'class'), 'formats': ('S10', 'i1')})
dnn_stimuli = [x[0].split('.')[0] for x in dnn_stimuli]

# read list of subjects
listing = os.listdir('../../Data/Intracranial/Processed/%s/' % featureset)

# load brain data
sfile = listing[sid]
print 'Loading %s...' % sfile

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

# for convenience
nstims = subject['data'].shape[0]
nprobes = subject['data'].shape[1]

# create the dataset: for each layer we'll have DNN activations as features
# and probe response as the target value to predict
layer_activity = {}
for layer in layers:
    layer_activity[layer] = np.zeros((nstims, activations[layer].shape[1]))
    probe_responses = np.zeros((nstims, nprobes))
    for sid_brain, stimulus in enumerate(subject['stimseq']):
        sid_dnn = dnn_stimuli.index(stimulus)
        layer_activity[layer][sid_brain, :] = activations[layer][sid_dnn, :]
        probe_responses = subject['data']

#for layer in layers:
#    for pid in range(len(subject['probes']['probe_ids'])):
#        predict_from_layer(subject['name'], layer, pid, layer_activity[layer], probe_responses[:, pid])
layer = 'conv5'
pid = 11

subject_name = subject['name']
layer_activity_all = layer_activity[layer]
probe_responses_all = probe_responses[:, pid]

print '=== %s: %s -> %d ===' % (subject_name, layer, pid)

# parameters
n_runs = 7
n_cv = 10
n_iter = 50


"""
# PCA
pca = KernelPCA(n_components=100, kernel='poly')
layer_activity_all = pca.fit_transform(layer_activity_all)

# Randomized PCA

# ICA
#ica = FastICA(n_components=100)
#layer_activity_all = ica.fit_transform(layer_activity_all)

# parameter search
# http://scikit-learn.org/stable/auto_examples/linear_model/plot_lasso_model_selection.html

# Uncomment to do permutation testing
#probe_responses_all = np.random.permutation(probe_responses_all)

def scan_alpha(alphas, n_iter, layer_activity_all, probe_responses_all, n_cv):
    max_r2 = -1.0
    best_alpha = 1.0
    for a in alphas:
        clf = linear_model.Ridge(alpha=a, max_iter=n_iter)
        r2 = np.mean(cross_validation.cross_val_score(clf, layer_activity_all, probe_responses_all, cv=n_cv))
        print 'alpha %f gave %.4f' % (a, r2)
        if r2 >= max_r2:
            best_alpha = a
            max_r2 = r2
    return best_alpha


# parameter search
alphas = np.array([0.0, 0.0001, 0.001, 0.01, 0.1, 1.0, 10.0, 10.0**2, 10.0**3, 10.0**4, 10.0**5, 10.0**6, 10.0**7, 10.0**8, 10.0**9, 10.0**10, 10.0**11, 10.0**12, 10.0**13, 10.0**14, 10.0**15])
best_alpha = scan_alpha(alphas, n_iter, layer_activity_all, probe_responses_all, n_cv)

# more granular search for alpha
best_alpha_id = np.where(alphas == best_alpha)[0][0]
from_id = 0 if best_alpha_id == 0 else best_alpha_id - 1
till_id = len(alphas)-1 if best_alpha_id == len(alphas)-1 else best_alpha_id + 1
f = alphas[from_id]
t = alphas[till_id]
s = (t - f) / 50.0
alphas = np.arange(f, t, s)
best_alpha = scan_alpha(alphas, n_iter, layer_activity_all, probe_responses_all, n_cv)

print 'Best alpha = %.4f' % best_alpha

# repeat predictability estimation [n_runs] times
r_scores = np.zeros(n_runs)
for run in range(n_runs):
    shuffle_idx = np.random.choice(range(layer_activity_all.shape[0]), size=layer_activity_all.shape[0], replace=False)
    layer_activity_all = layer_activity_all[shuffle_idx]
    probe_responses_all = probe_responses_all[shuffle_idx]
    
    clf = linear_model.Ridge(alpha=best_alpha, max_iter=n_iter)
    clf.fit(layer_activity_all, probe_responses_all)
    score_train = clf.score(layer_activity_all, probe_responses_all)
    predicted_train = clf.predict(layer_activity_all)
    r_train, pval_train = pearsonr(probe_responses_all, predicted_train)
    
    clf = linear_model.Ridge(alpha=best_alpha, max_iter=n_iter)
    predicted = cross_validation.cross_val_predict(clf, layer_activity_all, probe_responses_all, cv=n_cv) 
    score_cv = cross_validation.cross_val_score(clf, layer_activity_all, probe_responses_all, cv=n_cv)
    r, pval = pearsonr(probe_responses_all, predicted)
    
    print "Train: %.4f (r = %.4f, p = %.4f), CV: %.4f (r = %.4f, p = %.4f)" % (score_train, r_train, pval_train, np.mean(score_cv), r, pval)
    if pval > 0.001 or r < 0.0:
        r = 0.0
    r_scores[run] = r
"""

"""
# to consider a probe to be a significant match we request that at least half
# of the reshuflings have indicated is as such
if np.sum(r_scores > 0.0) >= n_runs / 2.0:
    final_score = np.mean(r_scores)
else:
    final_score = 0.0

# display progress
print 'Fitted  %s: %s to probe %d -- %f (%s)' % (subject_name, layer, pid, final_score, r_scores)

return (layer, pid, r)
"""



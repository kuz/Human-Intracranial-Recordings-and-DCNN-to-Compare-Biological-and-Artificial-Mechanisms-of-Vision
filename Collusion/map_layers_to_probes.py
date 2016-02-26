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
from sklearn.decomposition import PCA
from scipy.stats import pearsonr
import multiprocessing
from joblib import Parallel, delayed
import argparse


# read in command line arguments
#parser = argparse.ArgumentParser(description='Train all linear models for a given subject.')
#parser.add_argument('-i', '--sid', dest='sid', type=int, required=True, help='Subject ID')
#parser.add_argument('-a', '--activations', dest='np_activation_data', type=str, required=True, help='Directory with DNN activations (DNN/activations/?)')
#parser.add_argument('-f', '--featureset', dest='featureset', type=str, required=True, help='Directory with brain features (Processed/?)')
#args = parser.parse_args()
#sid = int(args.sid)
#np_activation_data = str(args.np_activation_data)
#featureset = str(args.featureset)

sid = 53
np_activation_data = 'numpy.reference'
featureset = 'meangamma_ventral_noscram'

# parameters
print 'Mapping subject %d represented with "%s" to %s DNN activations' % (sid, featureset, np_activation_data)
#ncores = multiprocessing.cpu_count()
ncores = 6
print "Working with %d CPUs" % ncores


# train linear model to predict probe [pid] response from [layer]
# activations, measure the prediction performace on the test set
# of stimuli
def predict_from_layer(subject_name, layer, pid, layer_activity_all, probe_responses_all):

    # parameters
    n_runs = 7
    n_cv = 10
    n_iter = 50

    # parameter search
    # http://scikit-learn.org/stable/auto_examples/linear_model/plot_lasso_model_selection.html
    alphas = [0.001, 0.01, 0.1, 0.3, 0.5, 0.7, 1.0, 10.0]
    max_r = -1.0
    best_alpha = 1.0
    for a in alphas:
        clf = linear_model.Lasso(alpha=a, max_iter=n_iter)
        predicted = cross_validation.cross_val_predict(clf, layer_activity_all, probe_responses_all, cv=n_cv)
        r, pval = pearsonr(probe_responses_all, predicted)
        #print '%s: %s to probe %d with alpha %f gave %.4f' % (subject_name, layer, pid, a, r)
        if r >= max_r:
            best_alpha = a
            max_r = r

    # repeat predictability estimation [n_runs] times
    r_scores = np.zeros(n_runs)
    for run in range(n_runs):

        # reshuffle the dataset to force another instance of cross-validation
        shuffle_idx = np.random.choice(range(layer_activity_all.shape[0]), size=layer_activity_all.shape[0], replace=False)
        layer_activity_all = layer_activity_all[shuffle_idx]
        probe_responses_all = probe_responses_all[shuffle_idx]

        # evaluate performance on the test set
        clf = linear_model.Lasso(alpha=best_alpha, max_iter=n_iter)
        clf.fit(layer_activity_all, probe_responses_all)
        score_train = clf.score(layer_activity_all, probe_responses_all)
        predicted_train = clf.predict(layer_activity_all)
        r_train, pval = pearsonr(probe_responses_all, predicted_train)

        # predict piecewise all of the data using CV
        clf = linear_model.Lasso(alpha=best_alpha, max_iter=n_iter)
        predicted = cross_validation.cross_val_predict(clf, layer_activity_all, probe_responses_all, cv=n_cv) 
        score_cv = cross_validation.cross_val_score(clf, layer_activity_all, probe_responses_all, cv=n_cv)

        # store the correlation coefficient
        r, pval = pearsonr(probe_responses_all, predicted)

        # print summary
        #print '--------------------------------------------------------'
        #print 'R^2 on TRAIN = ', score_train
        #print 'R^2 on CV    = ', np.mean(score_cv)
        #print 'Pearson r on TRAIN = ', r_train
        #print 'Pearson r on CV    = ', r
        #print '--------------------------------------------------------'

        # drop not significant results
        if pval > 0.001 or r < 0.0:
            r = 0.0
        r_scores[run] = r

    # to consider a probe to be a significant match we request that at least half
    # of the reshuflings have indicated is as such
    if np.sum(r_scores > 0.0) >= n_runs / 2.0:
        final_score = np.mean(r_scores)
    else:
        final_score = 0.0

    # display progress
    print 'Fitted  %s: %s to probe %d -- %f (%s)' % (subject_name, layer, pid, final_score, r_scores)

    return (layer, pid, final_score)


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

# grid of (subject, layer, pribe) triples to compute in parallel
parallel_grid = []
for layer in layers:
    for pid in range(len(subject['probes']['probe_ids'])):
        parallel_grid.append((layer, pid))

# for each (layer, probe) combination train a linear model to predict the probe response from the layer activations
start = time.time()
results = Parallel(n_jobs=ncores, backend="threading")(delayed(predict_from_layer)(subject['name'], layer, pid,
                                                               layer_activity[layer], probe_responses[:, pid])
                                                       for (layer, pid) in parallel_grid)
print 'Training the models took', time.time() - start

# aggregate results and store to files
print 'Storing mapping for %s...' % subject['name']

# prepare the structure
coefficients = [None] * 8
for lid in range(len(layers)):
    coefficients[lid] = [0.0] * nprobes

# put every result to a corresponding cell
for record in results:
    layer, pid, r = record
    coefficients[layers.index(layer)][pid] = r

# build the mapping
r_coefs = np.vstack(coefficients)
r_coefs = np.nan_to_num(r_coefs)

# for each probe find the layer it is most correlated with
probe_to_layer_map = np.argmax(r_coefs, axis=0) + 1

# replace layer ID with `-1` if no significant assignments were found (all 0s)
for pid in range(nprobes):
    if np.sum(r_coefs[:, pid]) == 0.0:
        probe_to_layer_map[pid] = -1

# store probe to layer mapping for the subject
np.savetxt('../../Data/Intracranial/Probe_to_Layer_Maps/%s/%s.txt' % (featureset, subject['name']), probe_to_layer_map, fmt='%i')

    



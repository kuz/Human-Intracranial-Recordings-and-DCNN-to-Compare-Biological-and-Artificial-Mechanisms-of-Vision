import os
import numpy as np
import scipy.io as sio
from sklearn import linear_model
from sklearn import cross_validation
from sklearn.decomposition import PCA
from scipy.stats import spearmanr
import multiprocessing
from joblib import Parallel, delayed
import argparse

class LinearPredictor:

    #: Paths
    CODEDIR = '../../Repository'
    DATADIR = '../../Data'

    #: Current subject
    sid = None
    subject = {}

    #: Dataset parameter
    featureset = None
    np_activation_data = None
    nstims = None
    nprobes = None

    #: Computation parameters
    ncores = 6
    n_runs = 7
    n_cv = 10
    n_iter = 50

    #: List of layers
    layers = None

    #: Data
    assignments = {}
    activations = {}
    layer_activity = {}
    probe_responses = {}

    #: List of subjects
    subjects = None

    def __init__(self, sid, featureset, np_activation_data):

        self.sid = sid
        self.featureset = featureset
        self.np_activation_data = np_activation_data

        print 'Mapping subject %d represented with "%s" to %s DNN activations' % (self.sid, self.featureset, self.np_activation_data)

        # prepare lists of probe coordinates for each layer
        self.layers = os.listdir('%s/DNN/activations/%s' % (self.CODEDIR, self.np_activation_data))
        for layer in self.layers:
            self.assignments[layer] = []

        # load DNN activations
        for layer in self.layers:
            self.activations[layer] = np.load('%s/DNN/activations/%s/%s/activations.npy' % (self.CODEDIR, self.np_activation_data, layer))

        # load list of stimuli in the order they were presented to DNN
        dnn_stimuli = np.loadtxt('%s/DNN/imagesdone.txt' % self.DATADIR, dtype={'names': ('stimulus', 'class'), 'formats': ('S10', 'i1')})
        dnn_stimuli = [x[0].split('.')[0] for x in dnn_stimuli]

        # read list of subjects
        self.subjects = os.listdir('%s/Intracranial/Processed/%s/' % (self.DATADIR, self.featureset))

        # load brain data
        sfile = self.subjects[self.sid]
        s = sio.loadmat('%s/Intracranial/Processed/%s/%s' % (self.DATADIR, self.featureset, sfile))
        self.subject['stimseq'] = [x[0][0] for x in s['s']['stimseq'][0][0]]
        self.subject['stimgroups'] = [x[0] for x in s['s']['stimgroups'][0][0]]
        self.subject['probes'] = {}
        self.subject['probes']['rod_names'] = list(s['s']['probes'][0][0][0][0][0])
        self.subject['probes']['probe_ids'] = [x[0] for x in list(s['s']['probes'][0][0][0][0][1])]
        self.subject['probes']['mni'] = s['s']['probes'][0][0][0][0][2]
        self.subject['data'] = s['s']['data'][0][0]
        self.subject['name'] = s['s']['name'][0][0][0]

        # for convenience
        self.nstims = self.subject['data'].shape[0]
        self.nprobes = self.subject['data'].shape[1]

        # create the dataset: for each layer we'll have DNN activations as features
        # and probe response as the target value to predict
        for layer in self.layers:
            self.layer_activity[layer] = np.zeros((self.nstims, self.activations[layer].shape[1]))
            self.probe_responses[layer] = np.zeros((self.nstims, self.nprobes))
            for sid_brain, stimulus in enumerate(self.subject['stimseq']):
                sid_dnn = dnn_stimuli.index(stimulus)
                self.layer_activity[layer][sid_brain, :] = self.activations[layer][sid_dnn, :]
                self.probe_responses[layer] = self.subject['data']


    def scan_alpha(self, alphas, layer, pid):
        max_r2 = -1.0
        best_alpha = 1.0
        for a in alphas:
            clf = linear_model.Ridge(alpha=a, max_iter=self.n_iter)
            r2 = np.mean(cross_validation.cross_val_score(clf, self.layer_activity[layer], self.probe_responses[:, pid], cv=self.n_cv))
            if r2 >= max_r2:
                best_alpha = a
                max_r2 = r2
        return best_alpha

    def predict_from_layer(self, layer, pid, probe_responses_all):
        """
        Train a linear model to predict probe's [pid] responses from [layer] activations,
        measure the prediction performace on the test set of stimuli
        """

        # to do artifact rejection we have dropped some number of images from each of the probes
        # now each proble has varying number of "trials" (images), to keep the data in matrix
        # format we inroduce a "poison pill" value of -123456 -- the images with this values as
        # a response should be excluded from further analysis
        keep_stim = self.probe_responses[:, pid] != -123456
        self.layer_activity[layer] = self.layer_activity[layer][keep_stim]
        self.probe_responses[:, pid] = self.probe_responses[:, pid][keep_stim]
        
        # uncomment for the permutation test
        #self.probe_responses[:, pid] = np.random.permutation(self.probe_responses[:, pid])

        # PCA
        try:
            pca = PCA(n_components=200)
            self.layer_activity[layer] += np.random.rand(self.layer_activity[layer].shape[0], self.layer_activity[layer].shape[1]) * 1e-6
            self.layer_activity[layer] = pca.fit_transform(self.layer_activity[layer])
        except:
            print 'ERROR: PCA did not converge. Skipping the probe'
            return (layer, pid, np.zeros(self.n_runs))

        # parameter search
        # http://scikit-learn.org/stable/auto_examples/linear_model/plot_lasso_model_selection.html
        alphas = np.array([0.0, 0.0001, 0.001, 0.01, 0.1, 1.0, 10.0, 10.0**2, 10.0**3, 10.0**4, 10.0**5, 10.0**6, 10.0**7, 10.0**8, 10.0**9, 10.0**10, 10.0**11, 10.0**12, 10.0**13, 10.0**14, 10.0**15])
        best_alpha = self.scan_alpha(alphas, layer, pid)

        # more granular search for alpha
        best_alpha_id = np.where(alphas == best_alpha)[0][0]
        from_id = 0 if best_alpha_id == 0 else best_alpha_id - 1
        till_id = len(alphas)-1 if best_alpha_id == len(alphas)-1 else best_alpha_id + 1 
        f = alphas[from_id]
        t = alphas[till_id]
        s = (t - f) / 50.0
        alphas = np.arange(f, t, s)
        best_alpha = self.scan_alpha(alphas, layer, pid)
    
        # repeat predictability estimation [self.n_runs] times
        r_scores = np.zeros(self.n_runs)
        for run in range(self.n_runs):

            # reshuffle the dataset to force another instance of cross-validation
            shuffle_idx = np.random.choice(range(self.layer_activity[layer].shape[0]), size=self.layer_activity[layer].shape[0], replace=False)
            self.layer_activity[layer] = self.layer_activity[layer][shuffle_idx]
            self.probe_responses[:, pid] = self.probe_responses[:, pid][shuffle_idx]

            # predict piecewise all of the data using CV
            clf = linear_model.Ridge(alpha=best_alpha, max_iter=self.n_iter)
            predicted = cross_validation.cross_val_predict(clf, self.layer_activity[layer], self.probe_responses[:, pid], cv=self.n_cv) 

            # store the correlation coefficient
            r, pval = spearmanr(self.probe_responses[:, pid], predicted)

            # drop not significant results
            if pval > 0.0001 or r < 0.0:
                r = 0.0
            r_scores[run] = r
    
        print 'Fitting  %s: %s to probe %d -- %s' % (self.subject['name'], layer, pid, r_scores)
        return (layer, pid, r_scores)

    def compute(self):

        # grid of (subject, layer, pribe) triples to compute in parallel
        parallel_grid = []
        for layer in self.layers:
            for pid in range(len(self.subject['probes']['probe_ids'])):
                parallel_grid.append((layer, pid))

        # for each (layer, probe) combination train a linear model to predict the probe response from the layer activations
        results = Parallel(n_jobs=self.ncores, backend="threading")(delayed(self.predict_from_layer)(layer, pid) for (layer, pid) in parallel_grid)

        output = np.zeros((self.nprobes, len(self.layers)))
        for record in results:
            layerid = self.layers.index(record[0])
            pid = record[1]
            output[pid, layerid] = np.mean(record[2])

        # store probe to layer mapping for the subject
        np.savetxt('../../Data/Intracranial/Probe_to_Layer_Maps/%s/%s.txt' % (featureset, self.subject['name']), output, fmt='%.4f')

if __name__ == '__main__':

    # read in command line arguments
    parser = argparse.ArgumentParser(description='Train all linear models for a given subject.')
    parser.add_argument('-i', '--sid', dest='sid', type=int, required=True, help='Subject ID')
    parser.add_argument('-a', '--activations', dest='np_activation_data', type=str, required=True, help='Directory with DNN activations (DNN/activations/?)')
    parser.add_argument('-f', '--featureset', dest='featureset', type=str, required=True, help='Directory with brain features (Processed/?)')
    args = parser.parse_args()
    sid = int(args.sid)
    np_activation_data = str(args.np_activation_data)
    featureset = str(args.featureset)

    lp = LinearPredictor(sid, featureset, np_activation_data)
    lp.compute()

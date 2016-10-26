import os
import glob
import numpy as np
import argparse
from scipy.stats import spearmanr, pearsonr
from sklearn.preprocessing import MinMaxScaler


class RSAScorer:

    #: Paths
    DATADIR = '../../Data'
    OUTDIR = None

    #: Paramters to compute on: dataeset, method, significance levels
    featureset = None
    scope = None
    threshold = None

    #: List of subjects
    subjects = None

    #: Current subject
    sid = None
    sname = None

    #: List of layers
    layers = ['pixels', 'conv1', 'conv2', 'conv3', 'conv4', 'conv5', 'fc6', 'fc7', 'fc8']

    #: The distance measure that was used to compute RDMs
    distance = None

    #: Addition featureset suffix, marks if the RDM were computed on original or shuffled data
    suffix = ''

    #: RDMs on DNN layers
    dnn_dsm = {}

    #: RDMs on probe responses
    brain_dsm = {}

    #: Final results
    scores = None

    def __init__(self, featureset, distance, sid, scope, threshold):
        self.featureset = featureset
        self.distance = distance
        self.sid = sid
        self.scope = scope
        self.threshold = threshold

        # read list of subjects
        self.subjects = os.listdir('%s/Intracranial/Processed/%s/' % (self.DATADIR, featureset))
        self.sname = self.subjects[self.sid].split('.')[0]

        #if shuffle:
            #suffix = '.shuffled'

        # load layer RDMs including the "layer 0" (pixel space)
        for layer in self.layers:
            self.dnn_dsm[layer] = np.loadtxt('../../Data/RSA/%s.%s%s/numbers/dnn-%s.txt' %
                                             (self.featureset, self.distance, self.suffix, layer))

        # load brain response dissimilarity matrices
        listing = glob.glob('%s/RSA/%s.%s%s/numbers/brain-%s-*.txt' %
                            (self.DATADIR, self.featureset, self.distance, self.suffix, self.sname))
        for pid, filename in enumerate(listing):
            self.brain_dsm[pid] = np.loadtxt(filename)

        # create a directory
        self.OUTDIR = '%s/Intracranial/Probe_to_Layer_Maps/rsa_%s.%s%s.%s%s' % (self.DATADIR, self.featureset, self.distance, self.suffix, self.scope, ('%.10f' % self.threshold)[2:].rstrip('0'))
        try:
            os.mkdir(self.OUTDIR)
        except:
            print 'WARNING: directory %s already exists, make sure we are not overwriting something important there.' % self.OUTDIR

    @staticmethod
    def compute_one_correlation_score(dnn, brain, scope, threshold):

        if scope == 'matrix':
            r, p = spearmanr(np.ravel(dnn), np.ravel(brain))
            if threshold < 1.0:
                if r > 0.0 and p <= threshold:
                    return r
                else:
                    return 0.0
            else:
                return r 

        if scope == 'image':
            nrows = brain.shape[0]
            score = 0
            for i in range(nrows):
                r, p = spearmanr(dnn[i, :], brain[i, :])
                if threshold < 1.0:
                    if r > 0.0 and p <= threshold:
                        score += r
                else:
                    score += r
            return score / float(nrows)

    def compute_rdm_correlation_scores(self):
        """
        @param scope: either 'matrix' or 'image' to indicate whethet correlation is computed
                      between whole matrices or image-by-image and then averaged
        @param threshold: signicance threshold a correlation must have to be stored as a result
                          use None to store all of the scores for the permutation test
        """
        mms = MinMaxScaler()
        nprobes = len(self.brain_dsm)
        nstim = self.brain_dsm[0].shape[0]
        self.scores = np.zeros((nprobes, len(self.layers)))
        for lid, layer in enumerate(self.layers):
            for pid in range(nprobes):
                dnn = mms.fit_transform(self.dnn_dsm[layer])
                brain = mms.fit_transform(self.brain_dsm[pid])
                self.scores[pid, lid] = RSAScorer.compute_one_correlation_score(dnn, brain, self.scope, self.threshold)

                """
                if self.scope == 'matrix':
                    r, p = spearmanr(np.ravel(dnn), np.ravel(brain))
                    if self.threshold < 1.0:
                        if r > 0.0 and p <= self.threshold:
                            self.scores[pid, lid] = r 
                    else:
                        self.scores[pid, lid] = r 

                if self.scope == 'image':
                    score = 0
                    for i in range(nstim):
                        r, p = spearmanr(dnn[i, :], brain[i, :])

                        if self.threshold < 1.0:
                            if r > 0.0 and p <= self.threshold:
                                score += r
                        else:
                            score += r
                    self.scores[pid, lid] = score / float(nstim)
                """

        self.scores[np.isnan(self.scores)] = 0.0

        return self.scores

    def store_rdm_correlation_scores(self):
        np.savetxt('%s/%s.txt' % (self.OUTDIR, self.sname), self.scores, fmt='%.4f')

    def load_rdm_correlation_scores(self):
        self.scores = np.loadtxt('%s/%s.txt' % (self.OUTDIR, self.sname))


if __name__ == '__main__':

    # read in command line arguments
    parser = argparse.ArgumentParser(description='Compute correlation scores between RDM matrices for each probe-layer pair')
    parser.add_argument('-i', '--sid', dest='sid', type=int, required=True, help='Subject ID')
    parser.add_argument('-f', '--featureset', dest='featureset', type=str, required=True, help='Directory with brain features (Processed/?)')
    parser.add_argument('-d', '--distance', dest='distance', type=str, required=True, help='The distance metric to use')
    parser.add_argument('-o', '--onwhat', dest='onwhat', type=str, required=True, help='image or matrix depending on which you to compute the correlation on')
    #parser.add_argument('-s', '--shuffle', dest='shuffle', type=bool, required=False, default=False, help='Whether to shuffle data for a permutation test')
    parser.add_argument('-t', '--threshold', dest='threshold', type=float, required=True, help='Significance level a score must have to be counter (1.0 to store all)')
    args = parser.parse_args()
    sid = int(args.sid)
    featureset = str(args.featureset)
    distance = str(args.distance)
    #shuffle = bool(args.shuffle)
    onwhat = str(args.onwhat)
    threshold = float(args.threshold)

    rsascorer = RSAScorer(featureset, distance, sid, onwhat, threshold)
    rsascorer.compute_rdm_correlation_scores()
    rsascorer.store_rdm_correlation_scores()

